import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

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
}
