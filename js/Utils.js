// Used as an helper library

// Hours helper functions

function getHourModel() {
    var list = []
    for(var n = 0; n<24; n++) {
        var i = n;
        list.push(n + ":00" + "-" + (++i == 24 ? 0 : i) + ":00")
    }
    return list
}

function getHourIndex(hour) {
    var list = getHourModel()
    for(var n = 0; n < list.length; n++)
        if(list[n] == hour)
            return n
    return -1 // ERROR
}

function getHourFromIndex(index) {
    var list = getHourModel()
    if(index > list.length)
        return undefined // ERROR
    return list[index]
}

// Weekdays helper functions

function getWeekDays() {
    return [ i18n.tr("Monday"), i18n.tr("Tuesday"), i18n.tr("Wednesday"),
            i18n.tr("Thursday"), i18n.tr("Friday"), i18n.tr("Saturday"),
            i18n.tr("Sunday")]
}

function getWeekDayIndex(weekday) {
    var list = getWeekDays()
    for(var n = 0; n < list.length; n++)
        if(list[n] == weekday)
            return n
    return -1 // ERROR
}

function getWeekDayFromIndex(index) {
    var list = getWeekDays()
    if(index > list.length)
        return undefined // ERROR
    return list[index]
}

// Generic helper functions

function getIcon(icon) {
    return "/usr/share/icons/ubuntu-mobile/actions/scalable/" + icon + ".svg"
}
