/**
 * @author emilio.sosa@unah.hn
 * @date November 23, 2020.
 * @version 2.0
 */

/**
* Notas de interés.
* Según mi investigación, cada transacción debe seguir un procedimiento similar y sistemático, el cuál debe consistir en peticiones para abrir la base de datos, control de errores y eventos, cerrado de la base de datos al finalizar la transacción.
* Es por esto, que las funciones que tienen encapsuladas las transacciones de IndexedDB comparten bloques de control similares.
* Quizás esté erróneo y este código puede ser más limpio. 
* Sin embargo, es funcional.
*/

/**
 * @author Emilio Sosa
 * 
 * @function insertElement
 *  Función que encapsula el procedimiento de la transacción que inserta un nuevo elemento en la base de datos de Indexed DB.
 * @param text 
 *  Parámetro que representa el texto genérico que se agregará a la base de datos.
 */
function insertElement(elementText) {
    /**
   * Esta request se usa para abrir la base de datos.
   */
    let request = window.indexedDB.open("randomTexts", 1);

    /**
     * Este bloque de evento es ingresado cuando la base de datos es abierta por primera vez, y crea los parámetros de la tabla a usar, así como su nombre, su llave, índices autoincrementales, etc.
     * @db es el resultado de la request que abre la base de datos.
     * @store es una función de la variable db, en este caso es usada para crear un objeto de almacenamiento para los elementos guardados en la base.
     * @index es una función de la variable store, sirve para designar nombre de indice, la unicidad de elementos, entre otras cosas.
     */
    request.onupgradeneeded = function (e) {
        let db = request.result,
            store = db.createObjectStore("textStore", { autoIncrement: true }),
            index = store.createIndex("text", "text", { unique: false });
    };

    /** 
     * Luego del bloque anterior, se pasa directamente al bloque siguiente, el @onsuccess .
     * Es importante mencionar que el bloque @onupgradeneeded solamente será accedido cuando la base sea abierta por primera vez o su versión sea cambiada.
     * Las variables son iguales, pero la diferencia es que las funciones llaman a transacciones, almacenamientos e índices que ya han sido creados en el bloque de eventos anterior.
     */
    request.onsuccess = function (e) {
        let db = request.result,
            tx = db.transaction("textStore", "readwrite"),
            store = tx.objectStore("textStore"),
            index = store.index("text");

        db.onerror = function (e) {
            console.log("Error: " + e.target.errorCode);
        };

        /**
         * Estando dentro del bloque @onsuccess llamamos a una función de la variable @store (put), la cual nos permite agregar un objeto especificando el @index al que pertenece, y asignándole a ese mismo un valor, el cual es el que recibe la función @insertElement .
         */
        store.put({ text: elementText });

        /**
         * Este bloque se ejecuta para cerrar la base de datos una vez que la transacción @tx ha sido completada.
         */
        tx.oncomplete = function () {
            db.close();
        };

        /**
         * Impresión en consola para asegurarnos que todo salió correcto.
         */
        console.log("added");

    };

    /**
     * Captura de error en caso de que @request no sea exitoso.
     */
    request.onerror = function (e) {
        console.log("Error: " + e.target.errorCode);
    };


}

/**
 * @author Emilio Sosa
 * 
 * @function deleteElement
 *  Esta función prescinde de un elemento en la base de datos.
 * 
 * @param elementText 
 *  Este es el texto que debe tener el objeto en la base que va a ser eliminado.
 */
function deleteElement(elementText) {
    let request = window.indexedDB.open("randomTexts", 1);

    request.onupgradeneeded = function () {
        let db = request.result,
            store = db.createObjectStore("textStore", { autoIncrement: true }),
            index = store.createIndex("text", "text", { unique: false });
    };

    request.onsuccess = function () {
        let db = request.result,
            tx = db.transaction("textStore", "readwrite"),
            store = tx.objectStore("textStore"),
            index = store.index("text");

        db.onerror = function (e) {
            console.log("Error: " + e.target.errorCode);
        };

        /**
         * Llamamos a la función @onsuccess de la función @openCursor , la cual nos ayudará a crear un apuntador.
         */
        store.openCursor().onsuccess = function (e) {
            /**
             * Creamos la variable @cursor , la cual será resultado del evento del @onsuccess
             */
            var cursor = e.target.result;
            if (cursor) {
                /**
                 * Verificamos que @cursor sea válido.
                 */
                if (cursor.value.text === elementText) {
                    /**
                     * Ahora, si @cursor está posicionado en un objeto cuyo valor de texto es igual al parámetro ingresado, procede a deshacerse del objeto.
                     * 
                     */
                    var request = cursor.delete();
                    request.onsuccess = function () {
                        console.log("deleted");
                    };

                    request.onerror = function () {
                        console.log("Elements not found.");
                    }
                } else {
                    /**
                     * Si su valor de texto no concuerda con el parámetro, se moverá a la siguiente posición.
                     */
                    cursor.continue();
                }
            }
        }

        tx.oncomplete = function () {
            db.close();
        };

    };

    request.onerror = function (e) {
        console.log("Error: " + e.target.errorCode);

    };
}

function modifyElement(elementText) {

}

/**
 * @author Emilio Sosa
 * 
 * @function getNextElement
 *  Función que devuelve el elemento posterior al elemento actual.
 * 
 * @param elementText
 *  Texto del objeto al cuál se está apuntando actualmente.
 */
function getNextElement(elementText) {
    let request = window.indexedDB.open("randomTexts", 1);

    request.onupgradeneeded = function (e) {
        let db = request.result,
            store = db.createObjectStore("textStore", { autoIncrement: true }),
            index = store.createIndex("text", "text", { unique: false });
    };

    request.onsuccess = function (e) {
        let db = request.result,
            tx = db.transaction("textStore", "readwrite"),
            store = tx.objectStore("textStore"),
            index = store.index("text");

        db.onerror = function (e) {
            console.log("Error: " + e.target.errorCode);
        };

        /**
         * Creamos un arreglo @storeCount el cual será provisional.
         * También creamos nuestro @openCursor para crear un objeto de cursor nuevo.
         */
        var storeCount = [],
            openCursor = store.openCursor();

        openCursor.onsuccess = function (e) {
            var cursor = e.target.result;

            if (cursor) {
                /**
                 * Mientras el cursor sea válido, los valores de texto de la base de datos se irán agregando a el arreglo provisional hecho anteriormente.
                 */
                storeCount.push(cursor.value.text);
                cursor.continue();

            }
            
            /**
             * Recorremos el arreglo que ya tiene los elementos de la base de datos.
             */
            for (i = 0; i < storeCount.length; i++) {
                /**
                 * Verificamos si el texto del objeto enviado como parámetro coincide con el del arreglo.
                 */
                if (storeCount[i] === elementText) {
                    /**
                     * De ser así, nos aseguramos de que el siguiente valor sea uno existente. De no ser así, dejamos solamente el último.
                     */
                    if ((i + 2) > storeCount.length) {
                        document.getElementById("elementText").value = storeCount[storeCount.length - 1];
                        //console.log("Este es el último");
                    
                    /**
                     * De lo contrario, se pasa al siguiente elemento y se muestra en la caja de texto.
                     */
                    } else {
                        document.getElementById("elementText").value = storeCount[i + 1];
                        console.log(storeCount[i + 1]);

                    }
                }
            }


        };

        tx.oncomplete = function () {
            db.close();
        };

    };

    request.onerror = function (e) {
        console.log("Error: " + e.target.errorCode);
    };

}

/**
 * @author Emilio Sosa
 * 
 * @function getPreviousElement
 *  Función que devuelve el elemento posterior al elemento actual.
 * 
 * @param elementText
 *  Texto del objeto al cuál se está apuntando actualmente.
 */
function getPreviousElement(elementText) {
    let request = window.indexedDB.open("randomTexts", 1);

    request.onupgradeneeded = function (e) {
        let db = request.result,
            store = db.createObjectStore("textStore", { autoIncrement: true }),
            index = store.createIndex("text", "text", { unique: false });
    };

    request.onsuccess = function (e) {
        let db = request.result,
            tx = db.transaction("textStore", "readwrite"),
            store = tx.objectStore("textStore"),
            index = store.index("text");

        db.onerror = function (e) {
            console.log("Error: " + e.target.errorCode);
        };

        /**
         * Creamos un arreglo @storeCount el cual será provisional.
         * También creamos nuestro @openCursor para crear un objeto de cursor nuevo.
         */
        var storeCount = [],
            openCursor = store.openCursor();

        openCursor.onsuccess = function (e) {
            var cursor = e.target.result;

            if (cursor) {
                /**
                 * Mientras el cursor sea válido, los valores de texto de la base de datos se irán agregando a el arreglo provisional hecho anteriormente.
                 */
                storeCount.push(cursor.value.text);
                cursor.continue();

            }

            for (i = 0; i < storeCount.length; i++) {
                /**
                 * Verificamos si el texto del objeto enviado como parámetro coincide con el del arreglo.
                 */
                if (storeCount[i] === elementText) {
                    /**
                     * De ser así, nos aseguramos de que el valor anterior sea uno existente. De no ser así, dejamos solamente el primero.
                     */
                    if ((i - 1) < 1) {
                        document.getElementById("elementText").value = storeCount[0];
                        console.log("Este es el primero.");
                    /**
                     * De lo contrario, se pasa al elemento anterior y se muestra en la caja de texto.
                     */    
                    } else {
                        document.getElementById("elementText").value = storeCount[i - 1];
                        console.log(storeCount[i - 1]);
                    }
                }
            }

        };

        tx.oncomplete = function () {
            db.close();
        };

    };

    request.onerror = function (e) {
        console.log("Error: " + e.target.errorCode);
    };

}

/**
 * @author Emilio Sosa
 * 
 * @function getFirstElement
 *  Función que localiza el primer elemento en la tabla. 
 * 
 */
function getFirstElement() {
    let request = window.indexedDB.open("randomTexts", 1);

    request.onupgradeneeded = function (e) {
        let db = request.result,
            store = db.createObjectStore("textStore", { autoIncrement: true }),
            index = store.createIndex("text", "text", { unique: false });
    };

    request.onsuccess = function (e) {
        let db = request.result,
            tx = db.transaction("textStore", "readwrite"),
            store = tx.objectStore("textStore"),
            index = store.index("text");

        db.onerror = function (e) {
            console.log("Error: " + e.target.errorCode);
        };

        /**
         * Inicializamos un nuevo cursor.
         */
        var openCursor = store.openCursor();

        openCursor.onsuccess = function (e) {
            var cursor = e.target.result;

            if (cursor) {
                /**
                 * Verificamos que el cursor sea válido, y cómo está recién inicializado este estará en la primera posición, así que solamente hay que mandar su valor a la caja de texto.
                 */
                document.getElementById("elementText").value = (cursor.value.text);

            }
        };

        tx.oncomplete = function () {
            db.close();
        };

    };

    request.onerror = function (e) {
        console.log("Error: " + e.target.errorCode);
    };

}

/**
 * @author Emilio Sosa
 * 
 * @function getLastElement
 *  Localiza el último elemento en la tabla de la base de datos.
 */
function getLastElement() {
    let request = window.indexedDB.open("randomTexts", 1);

    request.onupgradeneeded = function (e) {
        let db = request.result,
            store = db.createObjectStore("textStore", { autoIncrement: true }),
            index = store.createIndex("text", "text", { unique: false });
    };

    request.onsuccess = function (e) {
        let db = request.result,
            tx = db.transaction("textStore", "readwrite"),
            store = tx.objectStore("textStore"),
            index = store.index("text");

        db.onerror = function (e) {
            console.log("Error: " + e.target.errorCode);
        };

        /**
         * Creamos un arreglo @storeCount el cual será provisional.
         * También creamos nuestro @openCursor para crear un objeto de cursor nuevo.
         */
        var storeCount = [],
            openCursor = store.openCursor();

        openCursor.onsuccess = function (e) {
            var cursor = e.target.result;

            if (cursor) {
                /**
                 * Mientras el cursor sea válido, los valores de texto de la base de datos se irán agregando a el arreglo provisional hecho anteriormente.
                 */
                storeCount.push(cursor.value.text);
                cursor.continue();
            }

            /**
             * Finalmente, llamamos al último elemento de nuestro arreglo provisional y lo insertamos en la caja de texto.
             */
            document.getElementById("elementText").value = storeCount[storeCount.length - 1];

        };

        tx.oncomplete = function () {
            db.close();
        };

    };

    request.onerror = function (e) {
        console.log("Error: " + e.target.errorCode);
    };

}

/**
 * @function printDB
 *  Función de prueba utilizada en el desarrollo del programa.
 */
function printDB() {
    let request = window.indexedDB.open("randomTexts", 1);

    request.onupgradeneeded = function (e) {
        let db = request.result,
            store = db.createObjectStore("textStore", { autoIncrement: true }),
            index = store.createIndex("text", "text", { unique: false });
    };

    request.onsuccess = function (e) {
        let db = request.result,
            tx = db.transaction("textStore", "readwrite"),
            store = tx.objectStore("textStore"),
            index = store.index("text");

        db.onerror = function (e) {
            console.log("Error: " + e.target.errorCode);
        };

        // last element code
        var openCursor = store.openCursor();

        openCursor.onsuccess = function (e) {
            var cursor = e.target.result;

            if (cursor) {
                console.log(cursor.value.text);
                cursor.continue();
            }

        };

        openCursor.onerror = function () {
            console.log("No more elemnets");
        };


        tx.oncomplete = function () {
            db.close();
        };


    };

    request.onerror = function (e) {
        console.log("Error: " + e.target.errorCode);
    };

}