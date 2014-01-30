import QtQuick 2.0
import Ubuntu.Components 0.1

import "../../js/Utils.js" as Utils

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

        width: container.width
        height: container.height

        StateSaver.properties: "contentY, contentX"

        contentHeight: container.height
        contentWidth: container.width

        interactive: true

        Row {
            id: container
            spacing: units.gu(1.5)

            // Hours colum
            Column {
                spacing: units.gu(1)

                Repeater {
                    width: parent.width
                    model: {
                        var list = []
                        // Add an empty space at the top
                        list.push("")
                        list.concat(Utils.getHourModel())
                    }

                    delegate: UbuntuShape {
                        width: units.gu(5)
                        height: width
                        Label {
                            text: modelData
                            font.bold: true
                            anchors.centerIn: parent
                        }
                    }
                }
            }

            // Other columns

            Repeater {
                model: Utils.getWeekDays()
                delegate: DayColumn {
                    clip: true
                    title: modelData
                }
            }
        }
    }

    // Toolbar
    tools: ToolbarItems {
        locked: false
        opened: false

        ToolbarButton {
            id: settingsButton
            text: i18n.tr("Settings")
            iconSource: Utils.getIcon("settings")
            onTriggered: stack.push(settingsPage)
        }
    }
}
