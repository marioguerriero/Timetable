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

    property string lessonQmlString: "import QtQuick 2.0; Lesson {name: \"{{name}}\"; color: \"{{color}}\"; weekday: {{weekday}}; hour: {{hour}}; location: {{location}}; instructor: {{instructor}}; note: {{note}}; }"
    property string lessonDocumentQmlString: "import QtQuick 2.0; import U1db 1.0 as U1db;U1db.Document {id: {{id}};database: storage;docId: '{{docID}}';create: true;defaults: { 'name': '{{name}}', 'color': '{{color}}','weekday': '{{weekday}}', 'hour': '{{hour}}' }}"

    U1db.Database {
        id: storage
        path: "timetabledb9"

        property real count: storage.listDocs().length
        Component.onCompleted: console.log(storage.listDocs().length)
    }

    // Database helper functions
    function load() {
        if(loaded)
            return
        loaded = !loaded

        var docList = storage.listDocs()
        // docList has an extra element at its end
        // don't ask me why
        for(var n = 0; n < docList.length; n++) {
            var doc = storage.getDoc(docList[n])
            var newObjectString = buildLessonFromString(lessonQmlString, doc)
            var newObject = Qt.createQmlObject(newObjectString, storage);
            content.push(newObject)
        }
    }

    function reload() {
        loaded = false
        load()
    }

    function save(lesson) {
        var qmlString = buildLessonFromString(lessonDocumentQmlString, lesson)
        qmlString = qmlString.replace("{{id}}", "lesson" + storage.count)
        qmlString = qmlString.replace("{{docID}}", storage.count)
        storage.count++
        Qt.createQmlObject(qmlString, storage);
    }

    function del(lesson) {
        var docList = storage.listDocs()
        var id = -1
        for(var n = 0; n < docList.length; n++) {
            id = docList[n]
            // Get id's lesson
            var doc = storage.getDoc(id)
            console.log(id)
            var obj = buildLessonFromString(lessonQmlString, doc)
            var l = Qt.createQmlObject(obj, root)
            if(l.equalsComplete(lesson) && id != -1) {
                storage.deleteDoc(id)
                storage.count--
            }
        }
    }

    function update(lesson) {
        del(lesson)
        save(lesson)
    }

    function getLesson(weekday, hour) {
        for(var n = 0; n < content.length; n++) {
            var item = content[n]
            if(item.weekday == weekday && item.hour == hour)
                return item
        }
        return undefined
    }

    // Used to build a simple Lesson object from a valid Qml string
    // it takes data from a generic Qml element containing them (it may
    // be a U1db.Document or a Lesson as well)
    function buildLessonFromString(obj, doc) {
        obj = obj.replace("{{name}}", doc.name)
        obj = obj.replace("{{color}}", doc.color)
        obj = obj.replace("{{weekday}}", doc.weekday)
        obj = obj.replace("{{hour}}", doc.hour)
        obj = obj.replace("{{location}}", doc.location)
        obj = obj.replace("{{instructor}}", doc.instructor)
        obj = obj.replace("{{note}}", doc.note)
        return obj
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
