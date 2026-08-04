pragma Singleton

import QtQuick

import DataModel

Item {
    property bool dayNightMode: true

    property int cameraPosition: EnvironmentProperties.CameraPositionsEnum.Settings

    enum CameraPositionsEnum {
        Start,
        Main,
        Seats,
        Settings,
        Charging,
        AirConditioning,
        AmbientLight,
        ADAS,
        Headlights,
        LeftDoor,
        RightDoor,
        Rear,
        LeftWindow,
        RightWindow,
        Suspension
    }

    readonly property var cameraPositionModel: [
        "Start",
        "Main",
        "Seats",
        "Settings",
        "Charging",
        "AirConditioning",
        "AmbientLight",
        "ADAS",
        "Headlights",
        "LeftDoor",
        "RightDoor",
        "Rear",
        "LeftWindow",
        "RightWindow",
        "Suspension"
    ]

    property bool aiAssistantVisible: true
    property bool bambooVisible: true
    property bool carVisible: true
    property bool garageVisible: true
    property bool glassWallVisible: true
    property bool mountainsVisible: true
    property bool cloudsVisible: true
    property bool lakeVisible: true
    property bool reflectionVisible: true

    // Mirrored-car ground reflection
    property real reflectionPlaneY: -63
    property real reflectionGroundTransmission: 0.7
    property real reflectionFadeEndY: -170
    // How much deeper than the body fade the lamp reflections reach.
    property real reflectionEmissiveFalloff: 0.66

    // Standalone analytic floor: a radial highlight at the mirror plane plus
    // a fresnel sky-image reflection, shared by the floor shader and the
    // reflection's dissolve target.
    property color reflectionFloorHighlightColor: "#3d4554"
    property color reflectionFloorOuterColor: "#0c0f16"
    property real reflectionFloorHighlightStrength: 1.0
    property real reflectionFloorHighlightInnerRadius: 0
    property real reflectionFloorHighlightOuterRadius: 1400
    property real reflectionFloorSkyStrength: 0.6
    property real reflectionFloorSkyBlur: 2.5
}
