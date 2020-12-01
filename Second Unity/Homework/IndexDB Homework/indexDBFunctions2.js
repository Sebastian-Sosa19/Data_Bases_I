/**
 * @author Emilio Sebastián Sosa \ 20171003818
 * @date November 23, 2020.
 * @version 0.3
 * 
 */

var request = null,
    db = null,
    store = null,
    tx = null,
    index = null;

function startConnection() {
    request = window.indexedDB.open("randomTexts", 1);

    request.onupgradeneeded = function (e) {
        db = request.result;
        store = db.createObjectStore("textStore", { autoIncrement: true });
        index = store.createIndex("text", "text", { unique: false });
    };

    request.onsuccess = function (e) {
        db = request.result;
        tx = db.transaction("textStore", "readwrite");
        store = tx.objectStore("textStore");
        index = store.index("text");

        db.onerror = function (e) {
            console.log("Error: " + e.target.errorCode);
        };

        // tx.oncomplete = function () {
        //     db.close();
        // };
    };

    request.onerror = function (e) {
        console.log("Error: " + e.target.errorCode);
    };

}

function insertElement(elementText) {
    store.put({ text: elementText });

    tx.oncomplete = function () {
        db.close();
    };

    console.log("added");
}

function printDB() {
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
}