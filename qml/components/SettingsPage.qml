import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1

import "../../js/Utils.js" as Utils

Page {
    id: root
    visible: false
    title: i18n.tr("Settings")

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
                var list = []
                console.log(index)
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
        }

        Standard {
            text: i18n.tr("About")
            onClicked: stack.push(aboutPage)
        }
    }
}
