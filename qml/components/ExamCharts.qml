import QtQuick 2.0

import "QCharts"

Column {
    id: root
    spacing: units.gu(4)

    Chart {
        id: chartLine
        width: parent.width
        height: parent.height / 2
        chartAnimated: true
        chartAnimationEasing: Easing.InOutElastic
        chartAnimationDuration: 2000
        chartType: Charts.ChartType.LINE
        Component.onCompleted: {
            chartData = {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
                datasets: [
                    {
                        label: "My First dataset",
                        fillColor: "rgba(220,220,220,0.2)",
                        strokeColor: "rgba(220,220,220,1)",
                        pointColor: "rgba(220,220,220,1)",
                        pointStrokeColor: "#fff",
                        pointHighlightFill: "#fff",
                        pointHighlightStroke: "rgba(220,220,220,1)",
                        data: [65, 59, 80, 81, 56, 55, 40]
                    },
                    {
                        label: "My Second dataset",
                        fillColor: "rgba(151,187,205,0.2)",
                        strokeColor: "rgba(151,187,205,1)",
                        pointColor: "rgba(151,187,205,1)",
                        pointStrokeColor: "#fff",
                        pointHighlightFill: "#fff",
                        pointHighlightStroke: "rgba(151,187,205,1)",
                        data: [28, 48, 40, 19, 86, 27, 90]
                    }
                ]
            }
        }
    }

    Chart {
        id: chartPie
        width: parent.width
        height: parent.height / 2
        chartAnimated: true
        chartAnimationEasing: Easing.InOutElastic
        chartAnimationDuration: 2000
        chartType: Charts.ChartType.PIE
        Component.onCompleted: {
            chartData = [
                        {
                            value: 300,
                            color:"#F7464A",
                            highlight: "#FF5A5E",
                            label: "Red"
                        },
                        {
                            value: 50,
                            color: "#46BFBD",
                            highlight: "#5AD3D1",
                            label: "Green"
                        },
                        {
                            value: 100,
                            color: "#FDB45C",
                            highlight: "#FFC870",
                            label: "Yellow"
                        }
                    ]
        }
    }
}
