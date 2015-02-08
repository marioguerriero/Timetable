import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0
import Ubuntu.Components.Popups 1.0

import "../../../js/Utils.js" as Utils
import "../../../js/ExamUtils.js" as ExamUtils
import "../../../js/SettingsConst.js" as Keys

import "../"

Page {
    id: root
    title: i18n.tr("Exams")

    Row {
        anchors.fill: parent
        spacing: units.gu(2)

        Column {
            width: wideAspect ? parent.width * 0.2 : parent.width
            height: parent.height

            ExamsInfoBar {
                id: sidebar
                height: parent.height * 0.3

                function update() {
                    clear()
                    var exams = dbExam.getAll()
                    sidebar.append(ExamUtils.getArithmenticMean(exams))
                    sidebar.append(ExamUtils.getWeightedAverage(exams))
                    sidebar.append(ExamUtils.getPointsToDesiredVote(exams, settings.getSetting(Keys.DESIRED_VOTE)))
                }

                Component.onCompleted: update()
            }

            ListView {
                id: list
                height: parent.height * 0.7
                width: parent.width
                clip: true
                delegate: ExamItemDelegate {
                    exam: modelData
                    text: exam.name + " - " + exam.vote + " - " + exam.ects + " ECTS"
                    color: exam.color
                }
            }
        }

        Column {
            width: wideAspect ? parent.width * 0.8 : parent.width
            height: parent.height

            ExamCharts {
                id: charts
                width: parent.width / 1.05
                height: parent.height / 1.05
                visible: wideAspect
            }
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
        sidebar.update()
    }

    Component.onCompleted: {
        // Load exams from database
        load()
        console.log("Loaded exams: " + dbExam.content.length)
    }
}
