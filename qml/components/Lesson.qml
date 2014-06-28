import QtQuick 2.0
import Ubuntu.Components 1.1

import "../../js/Utils.js" as Utils

QtObject {
    property string name
    property var color
    property var weekday
    property var hour
    property var location
    property var instructor
    property var note

    // Holds the alarm for this lesson
    property Alarm alarm: Alarm {
        id: alarm
        message: name + i18n.tr(" is at ") + Utils.getHourFromIndex(hour)
    }

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

    // Invoke this function when the alarm property of this
    // object is meant to be set
    function configureAlarm() {
        switch(weekday) {
            case 0:
                alarm.daysOfWeek = Alarm.Monday;
                break;
            case 1:
                alarm.daysOfWeek = Alarm.Tuesday;
                break;
            case 2:
                alarm.daysOfWeek = Alarm.Wednesday;
                break;
            case 3:
                alarm.daysOfWeek = Alarm.Thursday;
                break;
            case 4:
                alarm.daysOfWeek = Alarm.Friday;
                break;
            case 5:
                alarm.daysOfWeek = Alarm.Saturday;
                break;
            case 6:
                alarm.daysOfWeek = Alarm.Sunday;
                break;
        }
        alarm.enabled = settings.getSetting("notify")
    }
}
