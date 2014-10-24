import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0

import "../../js/Utils.js" as Utils

Page {
    id: root
    title: i18n.tr("Exams")

    // Toolbar
    tools: ToolbarItems {
        ToolbarButton {
            id: settingsButton
            action: Action {
                text: i18n.tr("Settings")
                iconSource: Utils.getIcon("settings")
                onTriggered: stack.push(settingsPage)
            }
        }

        ToolbarButton {
            id: addButton
            action: Action {
                text: i18n.tr("New Exam")
                iconSource: Utils.getIcon("add")
                onTriggered: PopupUtils.open(Qt.resolvedUrl("./CreateExamDialog.qml"), root)
            }
        }
    }
}
