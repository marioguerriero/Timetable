import QtQuick 2.0
import Ubuntu.Components 0.1

QtObject {
    property string name
    property var color
    property var weekday
    property var hour
    property var location
    property var instructor
    property var note

    // Used when storing lessons into database
    function toJSON() {
        return {
            name: name,
            color: color,
            weekday: weekday,
            hour: hour,
            location: location,
            instructor: instructor,
            note: note
        }
    }

    function equals(lesson) {
        return (lesson.name == name && lesson.color == color)
    }

    // It compares all lesson's parameters
    function equalsComplete(lesson) {
        return (lesson.name == name && lesson.color == color &&
                lesson.weekday == weekday && lesson.hour == hour)
    }
}
