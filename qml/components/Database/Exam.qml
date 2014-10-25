import QtQuick 2.0

QtObject {
    property var vote
    property var ects
    property var name
    property var color
    property var date

    function equals(exam) {
        return (exam.vote === vote && exam.ects === ects
                && exam.name === name && exam.color === color
                && exam.date === date)
    }
}
