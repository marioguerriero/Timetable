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

            // The following types are used to implement drag n drop of lessons
            //property bool dragging: false
            //property var draggingLesson: undefined
            //property var destHour: -1
            //property var destWeekday: -1
            signal lessonDropped(var lesson, var weekday, var hour)

            onLessonDropped: {
                //lesson.weekday = weekday
                //lesson.hour = hour
                //dbLesson.update(lesson)
                //draw()
                //console.log(lesson.weekday + " " + lesson.hour)
            }

            UbuntuShape {
                id: lessonItem
                height: parent.height
                width: parent.width

                color: lesson ? lesson.color : "transparent"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if(lesson == undefined)
                            PopupUtils.open(Qt.resolvedUrl("./Dialogs/LessonSelectDialog.qml"), item);
                        else
                            PopupUtils.open(Qt.resolvedUrl("./LessonDialog.qml"), item);
                    }
                    onPressAndHold: {
                        if(lesson != undefined) {
                            // TODO: show a popover for advanced actions
                        }
                    }
                    onEntered: {
                        //item.destHour = item.modelData
                        //item.destWeekday = root.title
                    }
                    onReleased: {
                        //if(item.dragging) {
                            // TODO: implement drag n drop
                        //}
                    }

                    drag {
                        target: item.lesson ? lessonItem : undefined
                        axis: Drag.XandYAxis
                        onActiveChanged: {
                            //item.dragging = true
                            //item.draggingLesson = item.lesson
                        }
                    }
                }

                Label {
                    id: label
                    text: item.lesson ? item.lesson.name : ""
                    anchors.centerIn: parent
                }
            }

            Component.onCompleted: {
                draw()
            }

            function draw() {
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
