import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0
import Ubuntu.Components.Popups 1.0

import "../../../js/Utils.js" as Utils

import "../"

Page {
    id: root
    title: i18n.tr("Exams")

    ListView {
        id: list
        anchors.fill: parent
        delegate: ExamItemDelegate {
            exam: modelData
            text: exam.name + " - " + exam.vote + " - " + exam.ects + " ECTS"
            color: exam.color
        }
    }

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
                onTriggered: PopupUtils.open(Qt.resolvedUrl("../Dialogs/CreateExamDialog.qml"), root)
            }
        }
    }

    function load() {
        dbExam.load()
        list.model = dbExam.content
    }

    function update() {
        list.model = dbExam.getAll()
    }

    Component.onCompleted: {
        // Load exams from database
        load()
        console.log("Loaded exams: " + dbExam.content.length)
    }
}
