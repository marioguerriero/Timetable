import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0
import Ubuntu.Components.Popups 1.0

import "../../js/Utils.js" as Utils

Dialog {
    id: root
    title: lesson ? lesson.name : ""
    text: lesson ? Utils.getWeekDayFromIndex(lesson.weekday) + " " + Utils.getHourFromIndex(lesson.hour) : ""

    property var lesson: caller ? caller.lesson : undefined
onLessonChanged: console.log(lesson)
    Label {
        text: (lesson === undefined || lesson.location === undefined || lesson.location === "") ? i18n.tr("No Location") : lesson.location
        MouseArea {
            anchors.fill: parent
            onClicked: {
                locationField.visible = true
                locationField.forceActiveFocus()
                parent.visible = false
            }
        }
    }

    TextField {
        id: locationField
        visible: false
        text: (lesson === undefined || lesson.location === undefined || lesson.location === "") ? "" : lesson.location // To avoid runtime warnings
        placeholderText: i18n.tr("Location")
    }

    Label {
        text: (lesson === undefined || lesson.instructor === undefined || lesson.instructor === "") ? i18n.tr("No Instructor") : lesson.instructor
        MouseArea {
            anchors.fill: parent
            onClicked: {
                instructorField.visible = true
                instructorField.forceActiveFocus()
                parent.visible = false
            }
        }
    }

    TextField {
        id: instructorField
        visible: false
        text: (lesson === undefined || lesson.instructor === undefined || lesson.instructor === "") ? "" : lesson.instructor  // To avoid runtime warnings
        placeholderText: i18n.tr("Instructor")
    }

    TextArea {
        id: noteArea
        text: (lesson === undefined || lesson.note === undefined || lesson.note === "") ? "" : lesson.note // To avoid runtime warnings
        placeholderText: i18n.tr("Note")
    }

    Button {
        id: deleteBtn
        text: i18n.tr("Delete")
        gradient: UbuntuColors.greyGradient
        onClicked: {
            db.del(lesson)
            caller.lesson = undefined
            PopupUtils.close(root)
        }
    }

    Button {
        id: closeBtn
        text: i18n.tr("Close")
        gradient: UbuntuColors.orangeGradient
        onClicked: {
            lesson.location = (lesson === undefined || lesson.location === undefined || lesson.location === "") ? "" : locationField.text
            lesson.instructor = (lesson === undefined || lesson.instructor === undefined || lesson.instructor === "") ? "" : instructorField.text
            lesson.note = (lesson === undefined || lesson.note === undefined || lesson.note === "") ? "" : noteArea.text
            db.update(lesson)
            caller.lesson = lesson
            PopupUtils.close(root)
        }
    }
}
