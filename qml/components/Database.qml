import QtQuick 2.0
import U1db 1.0 as U1db
import Ubuntu.Components 0.1

// Lessons are stored into timetableDatabase document
// which is synced trhough devices with the U1 service
Item {
    id: root

    property var content: []

    U1db.Database {
        id: storage
        path: "timetable"

        property real count: storage.listDocs().length
    }

    // Database helper functions
    function load() {
        var docList = storage.listDocs()
        // docList has an extra element at its end
        // don't ask me why
        for(var n = 0; n < docList.length - 1; n++) {
            var doc = storage.getDoc(docList[n])
            var newObjectString = "import QtQuick 2.0; Lesson {name: \"{{name}}\"; color: \"{{color}}\"; weekday: {{weekday}}; hour: {{hour}} }"
            newObjectString = newObjectString.replace("{{name}}", doc.name)
            newObjectString = newObjectString.replace("{{color}}", doc.color)
            newObjectString = newObjectString.replace("{{weekday}}", doc.weekday)
            newObjectString = newObjectString.replace("{{hour}}", doc.hour)
            var newObject = Qt.createQmlObject(newObjectString, mainView);
            content.push(newObject)
        }
    }

    function save(lesson) {
        var qmlString = "import QtQuick 2.0; import U1db 1.0 as U1db;U1db.Document {id: {{id}};database: storage;docId: '{{docID}}';create: true;defaults: { 'name': '{{name}}', 'color': '{{color}}','weekday': '{{weekday}}', 'hour': '{{hour}}' }}"
        qmlString = qmlString.replace("{{id}}", "lesson" + storage.count)
        qmlString = qmlString.replace("{{docID}}", storage.count)
        qmlString = qmlString.replace("{{name}}", lesson.name)
        qmlString = qmlString.replace("{{color}}", lesson.color)
        qmlString = qmlString.replace("{{weekday}}", lesson.weekday)
        qmlString = qmlString.replace("{{hour}}", lesson.hour)
        Qt.createQmlObject(qmlString, mainView, "dynamicNewDocument" + storage.count);
        storage.count++
    }

    function del(lesson) {

    }

    function update(lesson) {

    }
}