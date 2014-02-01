import QtQuick 2.0
import Ubuntu.Components 0.1

QtObject {
    property string name
    property var color
    property real weekday
    property real hour

    // Used when storing lessons into database
    function toJSON() {
        return {
            name: name,
            color: color,
            weekday: weekday,
            hour: hour
        }
    }
}
