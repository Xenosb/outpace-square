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
}
