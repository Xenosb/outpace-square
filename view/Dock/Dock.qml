import QtQuick

Item {
    id: root

    signal carSettingsClicked()
    signal homeClicked()
    signal appsClicked()

    property alias leftTemperature: temperatureLeft.temperature
    property alias rightTemperature: temperatureRight.temperature

    implicitWidth: 1280
    implicitHeight: 58

    Row {
        id: menu
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 6
        spacing: 37

        DockIconButton {
            source: "images/icon_car.svg"
            onClicked: root.carSettingsClicked()
        }

        DockIconButton {
            source: "images/icon_home.svg"
            onClicked: root.homeClicked()
        }

        DockIconButton {
            source: "images/icon_apps.svg"
            onClicked: root.appsClicked()
        }
    }

    TemperatureDisplay {
        id: temperatureLeft
        anchors.left: parent.left
        anchors.leftMargin: 13
        anchors.top: parent.top
        anchors.topMargin: 6
    }

    TemperatureDisplay {
        id: temperatureRight
        anchors.right: parent.right
        anchors.rightMargin: 18
        anchors.top: parent.top
        anchors.topMargin: 6
    }
}
