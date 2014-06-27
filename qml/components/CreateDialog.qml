import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0
import Ubuntu.Components.Popups 1.0

Dialog {
    id: root

    title: i18n.tr("Create New Lesson")

    TextField {
        id: titleField
        placeholderText: i18n.tr("Title")
    }

    ItemSelector {
        id: colorSelector
        expanded: true
        containerHeight: units.gu(16)
        model: customModel
        delegate: ColorSelectorDelegate { colorName: name; shapeColor: color }
    }

    ListModel {
        id: customModel
        ListElement { name: "Yellow";       color: "#ffbb33" }
        ListElement { name: "Red";          color: "#cc0000" }
        ListElement { name: "Orange";       color: "#dd4814" }
        ListElement { name: "Blue";         color: "#0099cc" }
        ListElement { name: "Violet";       color: "#aa66cc" }
        ListElement { name: "Green";        color: "#00ff00" }
        ListElement { name: "Grey";         color: "#a4a4a4" }
        ListElement { name: "Light Blue";   color: "#04b4ae" }
    }

    Button {
        text: i18n.tr("Cancel")
        gradient: UbuntuColors.greyGradient
        onClicked: PopupUtils.close(root)
    }

    Button {
        text: i18n.tr("Create")
        gradient: UbuntuColors.orangeGradient
        onClicked: {
            var color = customModel.get(colorSelector.selectedIndex).color
            var lesson = Qt.createQmlObject("import Ubuntu.Components 0.1; Lesson{name:\"" + titleField.text + "\";"
                                            + "color:\"" + color + "\""
                                            + "}", caller)
            db.save(lesson)
            db.reload()
            PopupUtils.close(root)
        }
    }

    // Focus the title entry when shown
    Component.onCompleted: titleField.forceActiveFocus()
}
