import QtQuick 2.0
import U1db 1.0 as U1db

Item {
    id: root

    property var content: []
    // Used to prevent multiple invocations of load method
    property bool loaded: false

    property string examQmlString: "import QtQuick 2.0; Exam { vote: {{vote}}; ects: {{ects}}; name:\"{{name}}\"; color:\"{{color}}\"; date:\"{{date}}\" }"
    property string examDocumentQmlString: "import QtQuick 2.0; import U1db 1.0 as U1db; U1db.Document {id: {{id}};database: storage;docId: '{{docID}}';create: true;defaults: { 'vote': '{{vote}}', 'ects': '{{ects}}','name': '{{name}}', 'color': '{{color}}', 'date': '{{date}}' }}"

    U1db.Database {
        id: storage
        path: "timetabledb-exams1"

        property real count: storage.listDocs().length
    }

    // Database helper functions
    function load() {
        if(loaded)
            return
        loaded = !loaded

        var docList = storage.listDocs()
        for(var n = 0; n < docList.length; n++) {
            var doc = storage.getDoc(docList[n])
            var newObjectString = buildExamFromString(examQmlString, doc)
            var newObject = Qt.createQmlObject(newObjectString, storage);
            if(newObject.name != "undefined") {
                content.push(newObject)
            }
        }
    }

    function reload() {
        loaded = false
        load()
    }

    function save(exam) {
        var qmlString = buildExamFromString(examDocumentQmlString, exam)
        qmlString = qmlString.replace("{{id}}", "exam" + storage.count)
        qmlString = qmlString.replace("{{docID}}", storage.count)
        storage.count++
        var l = Qt.createQmlObject(qmlString, storage)
    }

    function del(exam) {
        var docList = storage.listDocs()
        var id = -1
        for(var n = 0; n < docList.length; n++) {
            id = docList[n]
            // Get id's exam
            var doc = storage.getDoc(id)
            var obj = buildExamFromString(examQmlString, doc)
            var l = Qt.createQmlObject(obj, root)
            if(l.equals(exam) && id != -1) {
                storage.deleteDoc(id)
                storage.count--
            }
        }
    }

    function update(exam) {
        save(exam)
    }

    function getExam(lesson) {
        var exam = undefined

        return exam
    }

    // Used to build a simple exam object from a valid Qml string
    // it takes data from a generic Qml element containing them (it may
    // be a U1db.Document or an Exam as well)
    function buildExamFromString(obj, doc) {
        obj = obj.replace("{{vote}}", doc.vote)
        obj = obj.replace("{{ects}}", doc.ects)
        obj = obj.replace("{{name}}", doc.name)
        obj = obj.replace("{{color}}", doc.color)
        obj = obj.replace("{{date}}", doc.date)
        return obj
    }

    // Return a list with all Exams without duplicated entries
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
