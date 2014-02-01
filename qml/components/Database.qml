import QtQuick 2.0
import U1db 1.0 as U1db
import Ubuntu.Components 0.1

// Lessons are stored into timetableDatabase document
// which is synced trhough devices with the U1 service
Item {
    id: root

    property var tes: []

    U1db.Database {
        id: storage
        path: "timetable"
    }

    U1db.Document {
        id: timetableDatabase

        database: storage
        docId: "timetabledb"
        create: true

        defaults: {
            timetable: [{}]
        }
    }

    // Database helper functions
    function load() {

    }

    function save(lesson) {

    }

    function del(lesson) {

    }

    function update(lesson) {

    }
}
