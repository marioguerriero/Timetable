import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0

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

            x: mainView.width > container.width ? (mainView.width - container.width) / 2 : 0

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
            id: addButton
            text: i18n.tr("New Lesson")
            iconSource: Utils.getIcon("add")
            onTriggered: PopupUtils.open(Qt.resolvedUrl("./CreateDialog.qml"), root);
        }

        ToolbarButton {
            id: settingsButton
            text: i18n.tr("Settings")
            iconSource: Utils.getIcon("settings")
            onTriggered: stack.push(settingsPage)
        }
    }
}
