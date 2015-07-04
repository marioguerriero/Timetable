import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0

import "../"
import "../../../js/Utils.js" as Utils

Page {
    id: root
    title: i18n.tr("Timetable")

    anchors.margins: units.gu(2)

    Flickable {
        id: flickable

        anchors {
            fill: parent
            topMargin: units.gu(4)
        }

        StateSaver.properties: "contentY, contentX"

        // Using container.height makes it go in loop (???)
        contentHeight: parent.height
        contentWidth: container.width

        interactive: true

        Row {
            id: container
            spacing: units.gu(1.5)

            x: mainView.width > container.width ? (mainView.width - container.width) / 2 : 0

            // Hours colum
            Column {
                spacing: units.gu(1)

                Repeater {
                    width: parent.width
                    model: {
                        var list = []
                        // Add an empty space at the top
                        list.push(undefined)
                        list.concat(Utils.getHourModel())
                    }

                    delegate: UbuntuShape {
                        width: units.gu(10)
                        height: units.gu(5)
                        Label {
                            text: modelData ? modelData : ""
                            font.bold: true
                            anchors.centerIn: parent
                        }
                        Component.onCompleted: {
                            // Check if this column should be shown
                            // according to settings
                            var toShow = false
                            var list = settings.getSetting("hours")
                            for(var n = 0; n < list.length; n++) {
                                // Always add the empty shape
                                if(modelData == undefined) {
                                    toShow = true
                                    break
                                }
                                toShow = false
                                if(list[n] == modelData) {
                                    toShow = true
                                    break
                                }
                            }
                            visible = toShow
                        }
                    }
                }
            }

            // Other columns
            Repeater {
                model: Utils.getWeekDays()
                delegate: DayColumn {
                    //clip: true
                    title: modelData
                    Component.onCompleted: {
                        // Check if this column should be shown
                        // according to settings
                        var toShow = false
                        var list = settings.getSetting("weekdays")
                        for(var n = 0; n < list.length; n++) {
                            toShow = false
                            if(list[n] == title) {
                                toShow = true
                                break
                            }
                        }
                        visible = toShow
                    }
                }
            }
        }
    }

    // Toolbar
    tools: ToolbarItems {
        ToolbarButton {
            id: settingsButton
            action: Action {
                text: i18n.tr("Settings")
                iconSource: Utils.getIcon("settings")
                onTriggered: stack.push(settingsPage)
            }
        }

        ToolbarButton {
            id: addButton
            action: Action {
                text: i18n.tr("New Lesson")
                iconSource: Utils.getIcon("add")
                onTriggered: PopupUtils.open(Qt.resolvedUrl("../Dialogs/CreateCourseDialog.qml"), root)
            }
        }
    }
}
