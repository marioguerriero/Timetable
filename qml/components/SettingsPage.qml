import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1

Page {
    id: root
    visible: false
    title: i18n.tr("Settings")

    Column {
        width: parent.width
        height:parent.height

        Standard {
            text: i18n.tr("Scroll weekday row and hour column")
            control: Switch {
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Standard {
            text: i18n.tr("Cut off unused rows/columns")
            control: Switch {
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Standard {
            text: i18n.tr("About")
            onClicked: stack.push(aboutPage)
        }
    }
}
