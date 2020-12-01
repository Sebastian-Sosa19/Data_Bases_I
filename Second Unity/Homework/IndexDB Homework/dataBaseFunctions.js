
/**
 * @author emilio.sosa@unah.hn
 * @date November 23, 2020.
 * @version 1.0
 */

/**
 * Notas de interés.
 * Según mi investigación, cada transacción debe seguir un procedimiento similar y sistemático, el cuál debe consistir en peticiones para abrir la base de datos, control de errores y eventos, cerrado de la base de datos al finalizar la transacción.
 * Es por esto, que las funciones que tienen encapsuladas las transacciones de IndexedDB comparten bloques de control similares.
 * Quizás esté erróneo y este código puede ser más limpio. 
 * Sin embargo, es funcional.
 */

/**
 * @function insertElement
 *  Función que encapsula el procedimiento de la transacción que inserta un nuevo elemento en la base de datos de Indexed DB.
 * @param text 
 *  Parámetro que representa el texto genérico que se agregará a la base de datos.
 */

function insertElement(text) {
  /**
   * Esta request se usa para abrir la base de datos.
   */
  let request = window.indexedDB.open("Texts", 1);

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
    store.put({ text: text });

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
 * @function deleteElement
 *  Esta función prescinde de un elemento en la base de datos.
 * 
 * @param elementText 
 *  Este es el texto que debe tener el objeto en la base que va a ser eliminado.
 */
function deleteElement(elementText) {
  let request = window.indexedDB.open("Texts", 1);

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
     * Se almacena el proceso de borrado en una variable, la cual consiste en una función de la variable @store
     */
    // var objDelete = store.delete(elementText);

    // objDelete.onsuccess = function(e) {

    /**
     * De ser el borrado exitoso, se envía un mensaje de confirmación en consola.
     */
    // console.log("deleted");

    //};

    store.openCursor().onsuccess = function (e) {
      var cursor = e.target.result;
      if (cursor) {
        if (cursor.value.text === elementText) {
          var request = cursor.delete();
          request.onsuccess = function () {
            console.log("deleted");
          };
        } else {
          console.log("Element not found.");
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



function modifyElement(newText) {
  let request = window.indexedDB.open("Texts", 1);

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

    // Modification code


    tx.oncomplete = function () {
      db.close();
    };

  };

  request.onerror = function (e) {
    console.log("Error: " + e.target.errorCode);
  };
}

/**
 * @function nextElement
 *  Función que devuelve el elemento posterior al elemento actual.
 * 
 * @param elementText
 *  Texto del objeto al cuál se está apuntando actualmente.
 */
function nextElement(elementText) {
  let request = window.indexedDB.open("Texts", 1);

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
      window.alert("No next value.");
    };

    /**
     * Creamos una variable @current para obtener el valor actual sobre el cuál estamos. Esta variable usa la función @getkey que toma como parámetro el texto del objeto y devuelve un objeto con información del mismo.
     */
    let current = index.getKey(elementText);

    /**
     * Bloque de éxito de la variable @current
     */
    current.onsuccess = function (e) {
      /**
       * Creamos otra variable @currentIndex la cuál guarda el resultado de la variable @current , siendo este la posición del objeto en la tabla de la base.
       */
      currentIndex = current.result;

      /**
       * La variable @next obtiene el siguiente objeto en la tabla especificando un get de la variable @storage que recibe como parámetro la posición del objeto en la tabla, y devuelve el objeto en dicha posición. Como estamos buscando el siguiente, le sumamos uno al valor @currentIndex que ya habíamos obtenido, y así pasar a la siguiente posición.
       */
      let next = store.get(currentIndex + 1);
      next.onsuccess = function (e) {

        /**
         * Finalmente, asignamos a nuestro objeto DOM de caja de texto su nuevo valor, que será el result de la variable @next , y de este result necesitamos el valor del campo text, campo que definimos en la configuración @storage inicialmente.
         */
        document.getElementById("elementText").value = (next.result.text);
        console.log(next.result.text);

      };
    };

    /**
     * Cierre de tabla al finalizar la transacción.
     */
    tx.oncomplete = function () {
      db.close();
    };

  };

  request.onerror = function (e) {
    console.log("Error: " + e.target.errorCode);
  };
}

/**
 * @function previousElement
 *  Función que devuelve el elemento posterior al elemento actual.
 * 
 * @param elementText
 *  Texto del objeto al cuál se está apuntando actualmente.
 */
function previousElement(elementText) {
  let request = window.indexedDB.open("Texts", 1);

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
     * Creamos una variable @current para obtener el valor actual sobre el cuál estamos. Esta variable usa la función @getkey que toma como parámetro el texto del objeto y devuelve un objeto con información del mismo.
     */
    let current = index.getKey(elementText);

    /**
     * Bloque de éxito de la variable @current
     */
    current.onsuccess = function (e) {
      /**
       * Creamos otra variable @currentIndex la cuál guarda el resultado de la variable @current , siendo este la posición del objeto en la tabla de la base.
       */
      currentIndex = current.result;

      /**
       * La variable @previous obtiene el objeto anterior en la tabla especificando un get de la variable @storage que recibe como parámetro la posición del objeto en la tabla, y devuelve el objeto en dicha posición. Como estamos buscando el siguiente, le restamos uno al valor @currentIndex que ya habíamos obtenido, y así pasar a la posición anterior.
       */
      let previous = store.get(currentIndex - 1);
      previous.onsuccess = function (e) {

        /**
       * Finalmente, asignamos a nuestro objeto DOM de caja de texto su nuevo valor, que será el result de la variable @previous , y de este result necesitamos el valor del campo text, campo que definimos en la configuración @storage inicialmente.
       */
        document.getElementById("elementText").value = (previous.result.text);
      };

    };

    /**
     * Cierre de tabla al finalizar la transacción.
     */
    tx.oncomplete = function () {
      db.close();
    };

  };

  request.onerror = function (e) {
    console.log("Error: " + e.target.errorCode);
  };

}

/**
 * @function getFirstElement
 *  Función que localiza el primer elemento en la tabla. 
 * 
 */
function getFirstElement() {
  let request = window.indexedDB.open("Texts", 1);

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
     * Designamos una variable @q que usará la función get de @storage , la cuál recibe como parámetro un número como referencia a un id en la tabla.
     * En este caso, nos basta con hacerle saber que necesitamos el 1.
     */
    var q = store.get(1);
    /**
     * Bloque de éxito de la variable @q .
     */
    q.onsuccess = function () {

      /**
       * En este bloque, solamente asignamos al objeto del DOM el resultado de la variable @q , y de ese resultado el texto almacenado.
       */
      document.getElementById("elementText").value = (q.result.text);

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
 * @function getLastElement
 *  Localiza el último elemento en la tabla de la base de datos.
 */
function getLastElement() {
  let request = window.indexedDB.open("Texts", 1);

  request.onupgradeneeded = function (e) {
    let db = request.result,
      //store = db.createObjectStore("textStore", {keyPath : "id"}),
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
     * Designamos la variable @lastIndex que hace uso de la función count de @store .
     */
    let lastIndex = store.count();
    /**
     * Bloque de éxito de @lastIndex
     */
    lastIndex.onsuccess = function () {
      /**
       * El resultado de @lastIndex contiene el número de objetos en la tabla de la base de datos, y este es asignado a la variable @lastElement
       */
      let lastElement = lastIndex.result,
        /**
       * Designamos una variable @q que usará la función get de @storage , la cuál recibe como parámetro un número como referencia a un id en la tabla.
       * Le pasamos el número obtenido en la variable @lastElement , el cuál debe ser el tamaño de la tabla y por ende el último objeto.
       */
        q = store.get(lastElement);

      /**
       * Bloque de éxito de @q
       */
      q.onsuccess = function () {

        console.log(q.result.text);

        /**
         * Se le asigna al valor del objeto DOM el resultado de @q , el texto del resultado.
         */
        document.getElementById("elementText").value = q.result.text;
      };

    };

    tx.oncomplete = function () {
      db.close();
    };

  };

  request.onerror = function (e) {
    console.log("Error: " + e.target.errorCode);
  };

}

function retrieveElementByText(elementText) {
  let request = window.indexedDB.open("Texts", 1);

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

    let q = index.get(elementText);
    q.onsuccess = function () {
      console.log(q.result.text);
    };

    tx.oncomplete = function () {
      db.close();
    };

  };

  request.onerror = function (e) {
    console.log("Error: " + e.target.errorCode);
  };

}

function retrieveElementByIndex(elementIndex) {
  let request = window.indexedDB.open("Texts", 1);

  request.onupgradeneeded = function (e) {
    let db = request.result,
      //store = db.createObjectStore("textStore", {keyPath : "id"}),
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

    let q = store.get(elementIndex);
    q.onsuccess = function () {
      console.log(q.result.text);
    };

    tx.oncomplete = function () {
      db.close();
    };

  };

  request.onerror = function (e) {
    console.log("Error: " + e.target.errorCode);
  };

}

function getIndex(elementText) {
  let request = window.indexedDB.open("Texts", 1);

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

    let objIndex = index.getKey(elementText);

    objIndex.onsuccess = function (e) {
      console.log(objIndex.result);

    }

    tx.oncomplete = function () {
      db.close();
    };

  };

  request.onerror = function (e) {
    console.log("Error: " + e.target.errorCode);
  };

}