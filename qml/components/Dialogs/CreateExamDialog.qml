import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0
import Ubuntu.Components.Popups 1.0
import Ubuntu.Components.Pickers 1.0

import "../"

Dialog {
    id: root

    title: i18n.tr("Add Exam")


    ItemSelector {
        id: lessonSelector
        expanded: true
        containerHeight: units.gu(16)
        model: customModel
        delegate: ColorSelectorDelegate { colorName: name; shapeColor: color }
    }

    ListModel {
        id: customModel
    }

    Row {
        id: row
        spacing: units.gu(2)

        Column {

            Label {
                text: i18n.tr("Vote:")
            }

            Picker {
                id: votePicker
                width: ((lessonSelector.width / 2) - (row.spacing / 2))
                delegate: PickerDelegate {
                    Label {
                        anchors.centerIn: parent
                        text: modelData
                    }
                }
                onSelectedIndexChanged: {
                    print("Vote: " + selectedIndex + 1);
                }
            }
        }

        Column {
            Label {
                text: i18n.tr("ECTS:")
            }

            Picker {
                id: creditsPicker
                width: ((lessonSelector.width / 2) - (row.spacing / 2))
                delegate: PickerDelegate {
                    Label {
                        anchors.centerIn: parent
                        text: modelData
                    }
                }
                onSelectedIndexChanged: {
                    print("ECS: " + selectedIndex + 1);
                }
            }
        }
    }

    Button {
        id: cancelBtn
        text: i18n.tr("Cancel")
        gradient: UbuntuColors.greyGradient
        onClicked: PopupUtils.close(root)
    }

    Button {
        id: addBtn
        text: i18n.tr("Add")
        gradient: UbuntuColors.orangeGradient
        onClicked: {
            var lesson = customModel.get(lessonSelector.selectedIndex).lesson
            var exam = Qt.createQmlObject("import \"../Database\";"
                                          + "Exam{vote:" + (votePicker.selectedIndex+1) + ";"
                                          + "ects:" + (creditsPicker.selectedIndex+1) + ";"
                                          + "name:\"" + lesson.name + "\";"
                                          + "color:\"" + lesson.color+ "\";"
                                          + "date:\"" + "date" + "\";"
                                          + "}", caller)

            dbExam.save(exam)
            caller.update()
            PopupUtils.close(root)
        }
    }

    Component.onCompleted: {
        // Update Dialog's label
        var list = list = dbLesson.getAll()
        if(list.length > 0) {
            title = i18n.tr("Add New Exam")
            addBtn.visible = true
            fillPickers()
        }
        else {
            title = i18n.tr("No Lessons Found")
            text = i18n.tr("You need to add a lesson first")
            addBtn.visible = false
        }
    }

    function fillPickers() {
        // Vote picker
        var list = []
        for(var n = 1; n <= 33; n++)
            list.push(n)
        votePicker.model = list
        votePicker.selectedIndex = 17
        // Credits picker
        list = []
        for(var n = 1; n <= 20; n++)
            list.push(n)
        creditsPicker.model = list
        creditsPicker.selectedIndex = 5
        // Courses picker
        list = dbLesson.getAll()
        for(var n = 0; n < list.length; n++) {
            var item = list[n]
            customModel.append({ "lesson": item, "name": item.name, "color": item.color })
        }
    }
}
