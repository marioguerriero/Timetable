import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0

Standard {
    id: option

    property var exam
    property string text: "undefined"
    property color color
    onColorChanged: {
        colorShape.color = color
    }

    removable: true
    confirmRemoval: true
    onItemRemoved: dbExam.del(exam)

    Row {
        spacing: units.gu(1)

        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            verticalCenter: parent.verticalCenter
        }

        Row {
            spacing: units.gu(1.5)
            UbuntuShape {
                id: colorShape
                color: option.color
                height: units.gu(3)
                width: height
            }
            Label {
                text: option.text
                elide: Text.ElideRight
                width: option.width / 1.5
                color: "white"
                Component.onCompleted: y = y + units.gu(0.2)
            }
        }
    }
}
