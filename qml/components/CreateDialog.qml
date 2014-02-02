import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1

Dialog {
    id: root

    title: i18n.tr("Create new lesson")

    TextField {
        id: titleField
        placeholderText: i18n.tr("Title")
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
            var lesson = Qt.createQmlObject("import Ubuntu.Components 0.1; Lesson{name:\"" + titleField.text + "\";"
                                               + "color:\"" + UbuntuColors.orange + "\""
                                               + "}", caller)
            caller.lesson = lesson
            db.save(lesson)
            PopupUtils.close(root)
        }
    }
}
