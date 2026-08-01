import QtQuick

import OutpaceSquare

Item {
    id: root

    CarView {
        id: carView

        anchors.fill: parent
    }

    // -------------------------------------------------------
    // EnvironmentProperties
    // -------------------------------------------------------

    property bool dayNightMode: true
    onDayNightModeChanged: EnvironmentProperties.dayNightMode = root.dayNightMode

    property bool bambooVisible: true
    onBambooVisibleChanged: EnvironmentProperties.bambooVisible = root.bambooVisible

    property bool carVisible: true
    onCarVisibleChanged: EnvironmentProperties.carVisible = root.carVisible

    property bool garageVisible: true
    onGarageVisibleChanged: EnvironmentProperties.garageVisible = root.garageVisible

    property bool glassWallVisible: true
    onGlassWallVisibleChanged: EnvironmentProperties.glassWallVisible = root.glassWallVisible

    property bool mountainsVisible: true
    onMountainsVisibleChanged: EnvironmentProperties.mountainsVisible = root.mountainsVisible

    property bool reflectionVisible: true
    onReflectionVisibleChanged: EnvironmentProperties.reflectionVisible = root.reflectionVisible

    // -------------------------------------------------------
    // CarModelProperties
    // -------------------------------------------------------

    property bool doorFrontLeftOpen: false
    onDoorFrontLeftOpenChanged: CarModelProperties.doorFrontLeftOpen = root.doorFrontLeftOpen

    property bool doorFrontRightOpen: false
    onDoorFrontRightOpenChanged: CarModelProperties.doorFrontRightOpen = root.doorFrontRightOpen

    property bool doorRearLeftOpen: false
    onDoorRearLeftOpenChanged: CarModelProperties.doorRearLeftOpen = root.doorRearLeftOpen

    property bool doorRearRightOpen: false
    onDoorRearRightOpenChanged: CarModelProperties.doorRearRightOpen = root.doorRearRightOpen

    property bool windowFrontLeftOpen: false
    onWindowFrontLeftOpenChanged: CarModelProperties.windowFrontLeftOpen = root.windowFrontLeftOpen

    property bool windowFrontRightOpen: false
    onWindowFrontRightOpenChanged: CarModelProperties.windowFrontRightOpen = root.windowFrontRightOpen

    property bool windowRearLeftOpen: false
    onWindowRearLeftOpenChanged: CarModelProperties.windowRearLeftOpen = root.windowRearLeftOpen

    property bool windowRearRightOpen: false
    onWindowRearRightOpenChanged: CarModelProperties.windowRearRightOpen = root.windowRearRightOpen

    property bool trunkOpen: false
    onTrunkOpenChanged: CarModelProperties.trunkOpen = root.trunkOpen

    // -------------------------------------------------------
    // CarColorProperties — colors sent as "#AARRGGBB" strings
    // -------------------------------------------------------

    property string carPaintColor: ""
    onCarPaintColorChanged: {
        if (root.carPaintColor !== "")
            CarColorProperties.carPaintColor = root.carPaintColor
    }
}
