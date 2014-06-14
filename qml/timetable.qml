import QtQuick 2.0
import Ubuntu.Components 1.1
import "components"

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    id: mainView

    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.mefrio.lesson-timetable"

    headerColor: "#021332"
    backgroundColor: "#042b4d"
    footerColor: "#064166"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    automaticOrientation: true

    width: minimumWidth
    height: minimumHeight

    // Saving window state
    StateSaver.properties: "height, width"

    // New properties of this page
    readonly property real minimumWidth: units.gu(50)
    readonly property real minimumHeight: units.gu(75)

    property bool wideAspect: width >= units.gu(100)

    PageStack {
        id: stack

        MainPage {
            id: mainPage
        }

        SettingsPage {
            id: settingsPage
        }

        AboutPage {
            id: aboutPage
        }
    }

    Database {
        id: db
    }

    Component.onCompleted: {
        // Any init here
        // Load db content
        db.load()
        // Push the mainPage as a home page for the app
        stack.push(mainPage)
        // When root component is completed the StateSaver restore it to previous dimensions.
        // If it is too small, set height and width to a proper size.
        if((mainView.width < minimumWidth) || (mainView.height < minimumHeight)){
            mainView.width = minimumWidth
            mainView.height = minimumHeight
        }
    }
}
