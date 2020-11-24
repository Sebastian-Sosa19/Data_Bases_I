
// Nos aseguramos que indexedDB funcione en cualquier navegador.
window.indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;

window.IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.msIDBTransaction;

window.IDBKeyRange = window.IDBKeyRange || window.webkitIDBKeyRange || window.msIDBKeyRange;

/*
  Object Structure : id, text
*/

/*
  @request : Usamos el open para definir la abertura de una base de datos, junto a su nombre y versión, si esta base es inexistente, su número de versión es 1.


*/
// let request = window.indexedDB.open("Texts", 1),
//     db,
//     tx,
//     store,
//     index;

// // Evento que ocurrirá cuando la base de datos sea abierta por primera vez
// request.onupgradeneeded = function(e) {
//   let db = request.result, 
//       store = db.createObjectStore("textStore", {keyPath : "id"}),
//       // store = db.createObjectStore("Components", {autoIncrement: true});
//       index = store.createIndex("text", "text", {unique : false});

// };

// // Recibiremos un mensaje o aviso al intentar abrir nuestra base de datos, esta función de la variable request nos responderá si ocurre un error.
// request.onerror = function(e) {
//   console.log("Ha ocurrido un error: " + e.target.errorCode);
// };

// // Al igual pero de manera opuesta al caso anterior, esta función nos responderá con el resultado de la consulta.
// request.onsuccess = function(e) {
//   db = request.result;
//   tx = db.transaction("textStore", "readwrite");
//   store = tx.objectStore("textStore");
//   index = store.index("text");

//   db.onerror = function(e) {
//     console.log("Error: " + e.target.errorCode);
//   }

//   /**
//    * Here we store data
//    store.put({id: 1, text: "first text"});
//    store.put({id: 2, text: "second text"});
//    * 
//   */

//   // Here we retrieve data
//   let q1 = store.get(1);
//   let qs = index.get("first text");

//   q1.onsuccess = function(){
//     console.log(q1.result);
//     console.log(q1.result.text);
//   }

//   tx.oncomplete = function(){
//     db.close();
//   }
  
// };

function insertElement(text){
  let request = window.indexedDB.open("Texts", 1);

  request.onupgradeneeded = function(e) {
    let db = request.result,
        //store = db.createObjectStore("textStore", {keyPath : "id"}),
        store = db.createObjectStore("textStore", {autoIncrement: true}),
        index = store.createIndex("text", "text", {unique : false});
  };

  request.onsuccess = function(e) {
    let db = request.result,
        tx = db.transaction("textStore", "readwrite"),
        store = tx.objectStore("textStore"),
        index = store.index("text");
      
    db.onerror = function(e) {
      console.log("Error: " + e.target.errorCode);
    };  
   
    store.put({text: text});    
    
    tx.oncomplete = function(){
      db.close();
    };

    console.log("added");
    
  };

}

function retrieveElement(elementText){
  let request = window.indexedDB.open("Texts", 1);

  request.onupgradeneeded = function(e) {
    let db = request.result,
        //store = db.createObjectStore("textStore", {keyPath : "id"}),
        store = db.createObjectStore("textStore", {autoIncrement: true}),
        index = store.createIndex("text", "text", {unique : false});
  };

  request.onsuccess = function(e) {
    let db = request.result,
        tx = db.transaction("textStore", "readwrite"),
        store = tx.objectStore("textStore"),
        index = store.index("text");
      
    db.onerror = function(e) {
      console.log("Error: " + e.target.errorCode);
    };
   
    let q = index.get(elementText);
    q.onsuccess = function(){
      console.log(q.result.text);
    };
    
    tx.oncomplete = function(){
      db.close();
    };
    
  };

  request.onerror = function(e){
    console.log("Error: " + e.target.errorCode);
  };

}

function deleteElement(elementText){
  let request = window.indexedDB.open("Texts", 1);

  request.onupgradeneeded = function(e) {
    let db = request.result,
        //store = db.createObjectStore("textStore", {keyPath : "id"}),
        store = db.createObjectStore("textStore", {autoIncrement: true}),
        index = store.createIndex("text", "text", {unique : false});
        //store > count 
  };

  request.onsuccess = function(e) {
    let db = request.result,
        tx = db.transaction("textStore", "readwrite"),
        store = tx.objectStore("textStore"),
        index = store.index("text");        
      
    db.onerror = function(e) {
      console.log("Error: " + e.target.errorCode);
    };
   
    store.delete(elementText);

    console.log("deleted");
    
    tx.oncomplete = function(){
      db.close();
    };
    
  };

  request.onerror = function(e){
    console.log("Error: " + e.target.errorCode);
  };

}










//Agregar
//
//Buscar
//Siguiente
//Anterior
//
//Modificar