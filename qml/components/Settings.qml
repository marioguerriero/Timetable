import QtQuick 2.0
import U1db 1.0 as U1db
import Ubuntu.Components 0.1

import "../../js/Utils.js" as Utils
import "../../js/SettingsConst.js" as Keys

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
            notify: false
            desiredVote: 110
        }
    }

    // Set settings to default if they are not set
    function init() {
        var value = getSetting(Keys.HOURS)
        if(value === undefined) {
            setSetting(Keys.HOURS, Utils.getHourModel().slice(8, 19))
        }
        value = getSetting(Keys.WEEKDAYS)
        if(value === undefined) {
            var weekdays = Utils.getWeekDays()
            setSetting(Keys.WEEKDAYS, Utils.getWeekDays().slice(0, 6))
        }
        value = getSetting(Keys.NOTIFY)
        if(value === undefined)
            setSetting(Keys.NOTIFY, false)
        value = getSetting(Keys.DESIRED_VOTE)
        if(value === undefined)
            setSetting(Keys.DESIRED_VOTE, 110)
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
