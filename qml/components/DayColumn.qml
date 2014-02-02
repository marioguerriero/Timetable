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
        width: units.gu(10)
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
            width: units.gu(10)

            property Lesson lesson
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
                    PopupUtils.open(Qt.resolvedUrl("./CreateDialog.qml"), item);
                }
            }

            Label {
                id: label
                text: lesson ? lesson.name : ""
                anchors.centerIn: parent
            }

            Component.onCompleted: {
                var weekday = Utils.getWeekDayIndex(root.title)
                var hour = Utils.getHourIndex(modelData)
                db.load()
                var lesson = db.getLesson(weekday, hour)
                if(lesson != undefined)
                    item.lesson = lesson
            }
        }
    }
}
