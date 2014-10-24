import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1

import "../../js/Utils.js" as Utils

Column {
    id: root

    property string title // The weekday eg Monday, ...

    spacing: units.gu(1)

    UbuntuShape {
        height: units.gu(5)
        width: units.gu(12)
        Label {
            font.bold: true
            text: title
            anchors.centerIn: parent
        }
    }

    Repeater {
        model: Utils.getHourModel()

        delegate: UbuntuShape {
            id: item
            height: units.gu(5)
            width: units.gu(12)

            property var lesson
            onLessonChanged: {
                if(lesson != undefined) {
                    lesson.weekday = Utils.getWeekDayIndex(root.title)
                    lesson.hour = Utils.getHourIndex(modelData)
                }
            }

            color: lesson ? lesson.color : "transparent"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(lesson == undefined)
                        PopupUtils.open(Qt.resolvedUrl("./Dialogs/LessonSelectDialog.qml"), item);
                    else
                        PopupUtils.open(Qt.resolvedUrl("./LessonDialog.qml"), item);
                }
                onPressAndHold: {
                    if(lesson != undefined) {
                        dbLesson.del(lesson)
                        lesson = undefined
                    }
                }
//                drag {
//                    target: lesson ? item : undefined
//                    axis: Drag.XandYAxis
//                }
            }

            Label {
                id: label
                text: lesson ? lesson.name : ""
                anchors.centerIn: parent
            }

            Component.onCompleted: {
                var weekday = Utils.getWeekDayIndex(root.title)
                var hour = Utils.getHourIndex(modelData)
                dbLesson.load()
                var lesson = dbLesson.getLesson(weekday, hour)
                if(lesson != undefined) {
                    item.lesson = lesson
                }
                // Hide shapes according to settings
                var toShow = false
                var list = settings.getSetting("hours")
                for(var n = 0; n < list.length; n++) {
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
