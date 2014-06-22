import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0

import "../../js/Utils.js" as Utils

Page {
    id: root
    visible: false
    title: i18n.tr("Settings")

    property var hours: settings.getSetting("hours")
    property var weekdays: settings.getSetting("weekdays")

    Column {
        width: parent.width
        height:parent.height

        Header {
            text: i18n.tr("Hour rows:")
        }

        ItemSelector {
            multiSelection: true
            expanded: false
            model: Utils.getHourModel()
            containerHeight: units.gu(24)
            onDelegateClicked: {
                console.log("TODO")
            }
            Component.onCompleted: {
            }
        }

        Header {
            text: i18n.tr("Weekdays columns:")
        }

        ItemSelector {
            multiSelection: true
            expanded: false
            model: Utils.getWeekDays()
            containerHeight: units.gu(24)
            onDelegateClicked: {
                console.log("TODO")
            }
            Component.onCompleted: {
            }
        }

        Standard {
            text: i18n.tr("About")
            onClicked: stack.push(aboutPage)
        }
    }
}
