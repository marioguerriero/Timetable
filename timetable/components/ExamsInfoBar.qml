import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0

Sidebar {
    id: root
    expanded: true
    mode: "left"

    ListView {
        id: listView
        anchors.fill: parent
        clip: true
        delegate: SingleValue {
            text: modelData.name
            selected: false
            value: modelData.value.toFixed(3)
        }
    }

    property var model: []
    function append(data) {
        model.push(data)
        listView.model = model
    }

    function clear() {
        list.model = []
    }

}
