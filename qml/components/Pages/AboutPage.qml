import QtQuick 2.0
import Ubuntu.Components 1.1

import "../../../js/Utils.js" as Utils

Page {
    title: i18n.tr("About")
    visible: false

    Column {
        anchors {
            centerIn: parent
            margins: units.gu(3)
            topMargin: units.gu(8)
        }

        spacing: units.gu(3)

        UbuntuShape {
            image: Image {
                source: "../../../timetable.png"
            }

            width: 128
            height: width
            radius: "medium"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Grid {
            anchors.horizontalCenter: parent.horizontalCenter
            columns: 2
            spacing: units.gu(1)

            Label {
                text: i18n.tr("Author:          ")
            }

            Label {
                font.bold: true
                text: "Mario Guerriero"
            }

            Label {
                text: i18n.tr("Icon:")
            }

            Label {
                font.bold: true
                text: "Kleverson Royther"
            }

            Label {
                text: i18n.tr("Contact:")
            }

            Label {
                text: i18n.tr("<a href=\"mailto:marioguerriero33@gmail.com?subject=Timetable%20support\">marioguerriero33@gmail.com</a>")
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: units.gu(2)

            Label {
                text: i18n.tr("<a href=\"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=4RPVD3GG3EJ4U\">Donate</a>")
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Label {
                text: i18n.tr("<a href=\"https://github.com/marioguerriero/Timetable/issues/\">Report a Bug</a>")
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }

        Label {
            text: i18n.tr("<a href=\"http://marioguerriero.github.io/Timetable/\">Website</a>")
            anchors.horizontalCenter: parent.horizontalCenter
            onLinkActivated: Qt.openUrlExternally(link)
        }

        Label {
            text: i18n.tr("Version <b>%1</b>").arg("0.3")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            text: i18n.tr("Copyright (C) 2014 Mario Guerriero")
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
