// Used as exam management helper library
function calculareWeightedAverage(exams) {
    var totalWeight = 0
    var tot = 0
    var list = []
    list = exams
    for(var i = 0; i < list.length; i++) {
        tot += list[i].vote * list[i].ects
        totalWeight += list[i].ects
    }

    return tot / totalWeight
}

function getWeightedAverage(exams) {
    return { "name": i18n.tr("Weighted Average:"),
        "value": calculareWeightedAverage(exams) }
}

function getArithmenticMean(exams) {
    var tot = 0
    var list = []
    list = exams
    for(var i = 0; i < list.length; i++)
        tot += list[i].vote

    return { "name": i18n.tr("Arithmetic Mean:"),
        "value": tot/list.length }
}

function getPointsToDesiredVote(exams, vote) {
    return { "name": i18n.tr("Points To Desired Vote:"),
        "value": vote - calculareWeightedAverage(exams) }
}

function getChartData(exams) {

}
