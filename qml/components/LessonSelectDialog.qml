import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0
import Ubuntu.Components.Popups 1.0

Dialog {
    id: root

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

    Button {
        id: cancelBtn
        text: i18n.tr("Cancel")
        gradient: UbuntuColors.greyGradient
        onClicked: PopupUtils.close(root)
    }

    Button {
        id: selectBtn
        text: i18n.tr("Select")
        gradient: UbuntuColors.orangeGradient
        onClicked: {
            var lesson = customModel.get(lessonSelector.selectedIndex).lesson
            caller.lesson = lesson
            db.save(lesson)
            PopupUtils.close(root)
        }
    }

    Component.onCompleted: {
        var list = db.getAll()
        for(var n = 0; n < list.length; n++) {
            var item = list[n]
            customModel.append({ "lesson": item, "name": item.name, "color": item.color })
        }
        // Update Dialog's label
        if(list.length > 0) {
            title = i18n.tr("Select Lesson")
            selectBtn.visible = true
        }
        else {
            title = i18n.tr("No Lessons Found")
            text = i18n.tr("You need to add a lesson first")
            selectBtn.visible = false
        }
    }
}
