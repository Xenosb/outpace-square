pragma Singleton

import QtQuick
import QtQuick3D
import QtQuick3D.Helpers

Item {
    id: root

    // ======================================================
    // Door control
    // ======================================================

    property bool doorFrontLeftOpen: false
    property real doorFrontLeftCurrentPosition: 1
    property real doorFrontLeftMinZ: -45
    property real doorFrontLeftMaxZ: 0

    onDoorFrontLeftOpenChanged: {
        doorFrontLeftCurrentPosition = doorFrontLeftOpen ? 0 : 1
    }

    property bool doorFrontRightOpen: false
    property real doorFrontRightCurrentPosition: 1
    property real doorFrontRightMinZ: 45
    property real doorFrontRightMaxZ: 0

    onDoorFrontRightOpenChanged: {
        doorFrontRightCurrentPosition = doorFrontRightOpen ? 0 : 1
    }

    property bool doorRearLeftOpen: false
    property real doorRearLeftCurrentPosition: 1
    property real doorRearLeftMinZ: -45
    property real doorRearLeftMaxZ: 0

    onDoorRearLeftOpenChanged: {
        doorRearLeftCurrentPosition = doorRearLeftOpen ? 0 : 1
    }

    property bool doorRearRightOpen: false
    property real doorRearRightCurrentPosition: 1
    property real doorRearRightMinZ: 45
    property real doorRearRightMaxZ: 0

    onDoorRearRightOpenChanged: {
        doorRearRightCurrentPosition = doorRearRightOpen ? 0 : 1
    }

    // ======================================================
    // Window control
    // Max is when window is up and Min is window down
    // ======================================================

    property bool windowFrontLeftOpen: false
    property real windowFrontLeftVentFraction: 0.8
    property int windowFrontLeftMode: 0
    property real windowFrontLeftCurrentPosition: [
        1.0,                             // closed
        windowFrontLeftVentFraction,      // vent
        0.0                              // open
    ][windowFrontLeftMode]
    property real windowFrontLeftMinZ: 701.67
    property real windowFrontLeftMaxZ: 778.38
    property real windowFrontLeftMinX: 20.325
    property real windowFrontLeftMaxX: 145.42
    property real windowFrontLeftMinY: 145.684
    property real windowFrontLeftMaxY: 580.26
    property real windowFrontLeftMinRotationZ: 7
    property real windowFrontLeftMaxRotationZ: 0

    onWindowFrontLeftOpenChanged: {
        if (windowFrontLeftOpen)
            root.windowFrontLeftVent = false
    }

    property bool windowFrontRightOpen: false
    property real windowFrontRightVentFraction: 0.8
    property int windowFrontRightMode: 0
    property real windowFrontRightCurrentPosition: [
        1.0,                             // closed
        windowFrontRightVentFraction,      // vent
        0.0                              // open
    ][windowFrontRightMode]
    property real windowFrontRightMinZ: 747.67047
    property real windowFrontRightMaxZ: 747.67047
    property real windowFrontRightMinX: -60
    property real windowFrontRightMaxX: -167.937
    property real windowFrontRightMinY: 175.42
    property real windowFrontRightMaxY: 586.249
    property real windowFrontRightMinRotationZ: -8
    property real windowFrontRightMaxRotationZ: 0

    onWindowFrontRightOpenChanged: {
        if (windowFrontRightOpen)
            root.windowFrontRightVent = false

    }

    property bool windowRearRightOpen: false
    property real windowRearRightVentFraction: 0.8
    property int windowRearRightMode: 0
    property real windowRearRightCurrentPosition: [
        1.0,                             // closed
        windowRearRightVentFraction,      // vent
        0.0                              // open
    ][windowRearRightMode]
    property real windowRearRightMinZ: 500
    property real windowRearRightMaxZ: 527.49
    property real windowRearRightMinX: -47.377
    property real windowRearRightMaxX: -156.76
    property real windowRearRightMinY: 185.42
    property real windowRearRightMaxY: 596.00
    property real windowRearRightMinRotationZ: -7
    property real windowRearRightMaxRotationZ: 0

    onWindowRearRightOpenChanged: {
        if (windowRearRightOpen)
            root.windowRearRightVent = false
    }

    property bool windowRearLeftOpen: false
    property real windowRearLeftVentFraction: 0.8
    property int windowRearLeftMode: 0
    property real windowRearLeftCurrentPosition: [
        1.0,                             // closed
        windowRearLeftVentFraction,      // vent
        0.0                              // open
    ][windowRearLeftMode]
    property real windowRearLeftMinZ: 514.49
    property real windowRearLeftMaxZ: 527.49
    property real windowRearLeftMinX: 45
    property real windowRearLeftMaxX: 164.76
    property real windowRearLeftMinY: 189.00
    property real windowRearLeftMaxY: 596.005
    property real windowRearLeftMinRotationZ: 7
    property real windowRearLeftMaxRotationZ: 0

    onWindowRearLeftOpenChanged: {
        if (windowRearLeftOpen)
            root.windowRearLeftVent = false
    }

    // ======================================================
    // Trunk
    // ======================================================

    enum TrunkModeEnum {
        Closed,
        Partial,
        Open
    }

    // ----- Trunk Properties -----//
    property int trunkMode: CarModelProperties.TrunkModeEnum.Closed
    property real trunkPartialFraction: 0.5  // <-- Changeable partial amount
    readonly property bool trunkMoving: trunkAnim.running
    // 1.0 = closed, 0.0 = open
    property real trunkCurrentPosition: 1.0

    onTrunkPartialFractionChanged: {
        moveTrunk();
    }

    function pauseTrunkMovement() {
        trunkAnim.stop();
    }

    function moveTrunk() {
        const target = targetPositionForMode()
        trunkAnim.stop();
        trunkAnim.from = trunkCurrentPosition;
        trunkAnim.to = target;
        trunkAnim.duration = Math.abs(target - trunkCurrentPosition) * 2000
        trunkAnim.start();
    }

    function targetPositionForMode() {
        return [
            1.0,                   // closed
            trunkPartialFraction,  // partial
            0.0                    // open
        ][trunkMode];
    }


    NumberAnimation {
        id: trunkAnim
        duration: 1000
        target: root
        property: "trunkCurrentPosition"
        easing.type: Easing.InOutQuad
    }

    property bool trunkOpen: false
    property real trunkMinX: -50
    property real trunkMaxX: 0

    onTrunkOpenChanged: {
        trunkMode = trunkOpen ? CarModelProperties.TrunkModeEnum.Open : CarModelProperties.TrunkModeEnum.Closed
        moveTrunk();
    }

    // ======================================================
    // TurnSignals
    // ======================================================

    property bool turnSignalLeft
    property bool turnSignalRight
}

