// Used as an helper library

function getHourModel() {
    var list = []
    for(var n = 0; n<24; n++) {
        var i = n;
        list.push(n + "-" + (++i == 24 ? 0 : i))
    }
    return list
}

function getWeekDays() {
    return [ i18n.tr("Monday"), i18n.tr("Tuesday"), i18n.tr("Wednesday"),
            i18n.tr("Thursday"), i18n.tr("Friday"), i18n.tr("Saturday"),
            i18n.tr("Sunday")]
}

function getIcon(icon) {
    return "/usr/share/icons/ubuntu-mobile/actions/scalable/" + icon + ".svg"
}
