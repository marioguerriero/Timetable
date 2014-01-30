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

            property alias text: label.text

            MouseArea {
                anchors.fill: parent
                onClicked: PopupUtils.open(Qt.resolvedUrl("./CreateDialog.qml"), item);
            }

            Label {
                id: label
                anchors.centerIn: parent
            }
        }
    }
}