import QtQuick 2.0
import U1db 1.0 as U1db
import Ubuntu.Components 0.1

import "../../js/Utils.js" as Utils

// Settings are all stored in a Document
Item {
    id: root

    U1db.Database {
        id: storage
        path: "settingsdb"
    }

    U1db.Document {
        id: settings

        database: storage
        docId: 'settingsdb'
        create: true

        defaults: {
            hours: []
            weekdays: []
        }
    }

    // Set settings to default if they are not set
    function init() {
        var hours = getSetting("hours")
        if(hours == undefined) {
            var hours = Utils.getHourModel()
            setSetting("hours", hours.slice(8, 19))
        }
        var weekdays = getSetting("weekdays")
        if(weekdays == undefined) {
            var weekdays = Utils.getWeekDays()
            setSetting("weekdays", weekdays.slice(0, 6))
        }
    }

    function getSetting(name) {
        var tempContents = {};
        tempContents = settings.contents
        return tempContents.hasOwnProperty(name) ? tempContents[name] : settings.defaults[name]
    }

    function setSetting(name, value) {
        if (getSetting(name) !== value) {
            var tempContents = {}
            tempContents = settings.contents
            tempContents[name] = value
            settings.contents = tempContents
        }
    }
}
