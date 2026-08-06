import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick3D.Helpers

import DataModel
import Dock

ApplicationWindow {
    id: window

    width: Constants.widthScaled
    height: Constants.heightScaled

    visible: true
    title: "Outpace Square"

    Material.theme: EnvironmentProperties.dayNightMode ? Material.Dark : Material.Light

    CarView {
        id: carView

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

        source: carView.view

        visible: false
    }

    Dock {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Connections {
            function onCarSettingsClicked() {
                carView.controlsOpen = true
            }

            function onHomeClicked() {
                carView.controlsOpen = false
            }
        }
    }
}
