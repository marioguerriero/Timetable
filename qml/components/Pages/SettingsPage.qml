import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0

import "../../../js/Utils.js" as Utils

Page {
    id: root
    visible: false
    title: i18n.tr("Settings")

    property var hours: settings.getSetting("hours")
    property var weekdays: settings.getSetting("weekdays")

    Flickable {
        id: flickable

        anchors.fill: parent

        contentHeight: container.height + units.gu(10)
        flickableDirection: Flickable.VerticalFlick
        interactive: true

        Column {
            id: container
            width: root.width
            height: root.height

            Header {
                text: i18n.tr("General")
            }

            Standard {
                text: i18n.tr("Notify upcoming lessons")
                control: Switch {
                    checked: settings.getSetting("notify")
                    onCheckedChanged: settings.setSetting("notify", checked)
                }
            }

            Header {
                text: i18n.tr("Timetable")
            }

            Standard {
                text: i18n.tr("Hour rows")
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

            Standard {
                text: i18n.tr("Weekdays columns")
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

            Header {
                text: i18n.tr("Exams")
            }

            Standard {
                text: i18n.tr("About")
                onClicked: stack.push(aboutPage)
            }
        }
    }
}
