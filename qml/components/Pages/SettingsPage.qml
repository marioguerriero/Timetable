import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0
import Ubuntu.Components.Popups 1.0

import "../../../js/Utils.js" as Utils
import "../../../js/SettingsConst.js" as Keys

Page {
    id: root
    visible: false
    title: i18n.tr("Settings")

    property var hours: settings.getSetting(Keys.HOURS)
    property var weekdays: settings.getSetting(Keys.WEEKDAYS)

    Flickable {
        id: flickable

        anchors.fill: parent

        contentHeight: container.height * 1.3
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
                    checked: settings.getSetting(Keys.NOTIFY)
                    onCheckedChanged: settings.setSetting(Keys.NOTIFY, checked)
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
            }

            Header {
                text: i18n.tr("Exams")
            }

            SingleValue {
                id: desiredVoteValue
                text: i18n.tr("Desired Vote")
                value: settings.getSetting(Keys.DESIRED_VOTE)
                onClicked: PopupUtils.open(desiredVoteComp, desiredVoteValue)
            }

            Header {
                text: i18n.tr("Others")
            }

            Standard {
                text: i18n.tr("About")
                onClicked: stack.push(aboutPage)
            }
        }
    }

    // Desired Vote Dialog
    Component {
        id: desiredVoteComp
        Dialog {
            id: dialog
            title: i18n.tr("Desired Vote")
            TextField {
                id: field
                text: caller.value
                inputMethodHints: Qt.ImhDigitsOnly
            }
            Button {
                text: i18n.tr("Confirm")
                gradient: UbuntuColors.orangeGradient
                onClicked: PopupUtils.close(dialog)
            }
            Component.onCompleted: field.forceActiveFocus()
        }
    }
}
