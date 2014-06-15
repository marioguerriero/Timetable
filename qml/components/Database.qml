import QtQuick 2.0
import U1db 1.0 as U1db
import Ubuntu.Components 0.1

// Lessons are stored into timetableDatabase document
// which is synced trhough devices with the U1 service
Item {
    id: root

    property var content: []
    // Used to prevent multiple invocations of load method
    property bool loaded: false

    U1db.Database {
        id: storage
        path: "timetabledb"

        property real count: storage.listDocs().length
    }

    // Database helper functions
    function load() {
        if(loaded)
            return
        loaded = !loaded

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

    function reload() {
        loaded = false
        load()
    }

    function save(lesson) {
        var qmlString = "import QtQuick 2.0; import U1db 1.0 as U1db;U1db.Document {id: {{id}};database: storage;docId: '{{docID}}';create: true;defaults: { 'name': '{{name}}', 'color': '{{color}}','weekday': '{{weekday}}', 'hour': '{{hour}}' }}"
        qmlString = qmlString.replace("{{id}}", "lesson" + storage.count)
        qmlString = qmlString.replace("{{docID}}", storage.count)
        qmlString = qmlString.replace("{{name}}", lesson.name)
        qmlString = qmlString.replace("{{color}}", lesson.color)
        qmlString = qmlString.replace("{{weekday}}", lesson.weekday)
        qmlString = qmlString.replace("{{hour}}", lesson.hour)
        storage.count++
        Qt.createQmlObject(qmlString, mainView, "dynamicNewDocument" + storage.count);
    }

    function del(lesson) {
        var docList = storage.listDocs()
        var id = -1
        for(var n = 0; n < docList.length - 1; n++) {
            id = docList[n]
            // Get id's lesson
            var doc = storage.getDoc(id)
            var obj = "import QtQuick 2.0; Lesson {name: \"{{name}}\"; color: \"{{color}}\"; weekday: {{weekday}}; hour: {{hour}} }"
            obj = obj.replace("{{name}}", doc.name)
            obj = obj.replace("{{color}}", doc.color)
            obj = obj.replace("{{weekday}}", doc.weekday)
            obj = obj.replace("{{hour}}", doc.hour)
            var l = Qt.createQmlObject(obj, root);
            if(l.equalsComplete(lesson))
                break
        }
        if(id != -1) storage.deleteDoc(id)
    }

    function update(lesson) {

    }

    function getLesson(weekday, hour) {
        for(var n = 0; n < content.length; n++) {
            var item = content[n]
            if(item.weekday == weekday && item.hour == hour)
                return item
        }
        return undefined
    }

    // Return a list with all Lessons without duplicated entries
    function getAll() {
        reload()
        var list = []
        for(var n = 0; n < content.length; n++) {
            var item = content[n]
            var duplicate = false
            for(var i = 0; i < list.length; i++) {
                if(list[i].equals(item)) {
                    duplicate = true
                    break
                }
            }
            if(!duplicate) {
                list.push(item)
            }
        }
        return list
    }
}
