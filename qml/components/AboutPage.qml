import QtQuick 2.0
import Ubuntu.Components 0.1

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
                // source:
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
                text: "."
            }

            Label {
                text: i18n.tr("Contact:")
            }

            Label {
                text: i18n.tr("<a href=\"mailto:marioguerriero33@gmail.com?subject=Timetable%20support\">mefrio.g@gmail.com</a>")
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: units.gu(2)

            Label {
                text: i18n.tr("<a href=\"https://www.paypal.com/us/cgi-bin/webscr?cmd=_flow&SESSION=hIBnlI0q1A447--JjCVws5rcYOB46jp11HElKYE15m4aqruLp77bJtcAJgS&dispatch=5885d80a13c0db1f8e263663d3faee8def8934b92a630e40b7fef61ab7e9fe63\">Donate</a>")
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Label {
                text: i18n.tr("<a href=\"https://github.com/Mefrio/Timetable/issues/\">Report a Bug</a>")
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }

        Label {
            text: i18n.tr("<a href=\"http://mefrio.github.io/Timetable/\">Website</a>")
            anchors.horizontalCenter: parent.horizontalCenter
            onLinkActivated: Qt.openUrlExternally(link)
        }

        Label {
            text: i18n.tr("Version <b>%1</b>").arg("1.0")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            text: i18n.tr("Copyright (C) 2014 Mario Guerriero")
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

