import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick3D.Helpers

import DataModel

ApplicationWindow {
    id: window

    width: Constants.widthScaled
    height: Constants.heightScaled

    visible: true
    title: "Outpace Square"

    Material.theme: EnvironmentProperties.dayNightMode ? Material.Dark : Material.Light

    CarView {
        id: mainScreen

        anchors.fill: parent
    }

    ReflectionControls {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 12

        width: 260

        visible: false
    }

    DebugView {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 12

        source: mainScreen.view

        visible: false
    }
}
