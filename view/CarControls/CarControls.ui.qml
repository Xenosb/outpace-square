import QtQuick
import QtQuick3D
import DataModel


Item {
    id: root

    required property View3D view3D_Car
    required property Node mainCar
    required property Node hitbox
    property bool open : false

    anchors.fill: parent
    parent: view3D_Car
    opacity: open ? 1 : 0
    enabled: open


    IconMapper {
        id: iconMapper
        view: root.view3D_Car
        nodesItemsMap: [
            [root.mainCar.windowsLeft, windowIconLeft],
            [root.mainCar.windowsRight, windowIconRight],
            [root.mainCar.door_FL, doorFLIcon],
            [root.mainCar.door_RL, doorRLIcon],
            [root.mainCar.door_FR, doorFRIcon],
            [root.mainCar.door_RR, doorRRIcon],
        ]
        hitbox: root.hitbox.model
    }


    CarControlIcon {
        id: doorFLIcon
        iconType: CarControlIcon.IconType.Door
        onClicked: CarModelProperties.doorFrontLeftOpen = !CarModelProperties.doorFrontLeftOpen
        transform: Translate { x: -doorFLIcon.width / 2; y: -doorFLIcon.height / 2 }
    }

    CarControlIcon {
        id: doorRLIcon
        iconType: CarControlIcon.IconType.Door
        onClicked: CarModelProperties.doorRearLeftOpen = !CarModelProperties.doorRearLeftOpen
        transform: Translate { x: -doorRLIcon.width / 2; y: -doorRLIcon.height / 2 }
    }

    CarControlIcon {
        id: doorFRIcon
        iconType: CarControlIcon.IconType.Door
        onClicked: CarModelProperties.doorFrontRightOpen = !CarModelProperties.doorFrontRightOpen
        transform: Translate { x: -doorFRIcon.width / 2; y: -doorFRIcon.height / 2 }
    }

    CarControlIcon {
        id: doorRRIcon
        iconType: CarControlIcon.IconType.Door
        onClicked: CarModelProperties.doorRearRightOpen = !CarModelProperties.doorRearRightOpen
        transform: Translate { x: -doorRRIcon.width / 2; y: -doorRRIcon.height / 2 }
    }

    CarControlMenu {
        id: windowIconLeft

        menuType: CarControlMenu.MenuType.Windows
        offsetX: open ? -600 : 0
        offsetY: open ? 240 : 0

        Binding on selectedIndex {
            value: CarModelProperties.windowFrontLeftMode
        }

        Binding on open {
            when: EnvironmentProperties.cameraPosition !== EnvironmentProperties.CameraPositionsEnum.LeftWindow
            value: false
            restoreMode: Binding.RestoreNone
        }

        Binding {
            target: EnvironmentProperties
            when: windowIconLeft.open
            property: "cameraPosition"
            value: EnvironmentProperties.CameraPositionsEnum.LeftWindow
        }

        Connections {
            function onSelectedIndexChanged(){
                CarModelProperties.windowRearLeftMode =
                CarModelProperties.windowRearRightMode =
                CarModelProperties.windowFrontLeftMode =
                CarModelProperties.windowFrontRightMode = windowIconLeft.selectedIndex;
            }
        }
    }

    CarControlMenu {
        id: windowIconRight

        menuType: CarControlMenu.MenuType.Windows
        offsetX: open ? -600 : 0
        offsetY: open ? 240 : 0

        Binding on selectedIndex {
            value: CarModelProperties.windowFrontRightMode
        }

        Binding on open {
            when: EnvironmentProperties.cameraPosition !== EnvironmentProperties.CameraPositionsEnum.RightWindow
            value: false
            restoreMode: Binding.RestoreNone
        }

        Binding {
            target: EnvironmentProperties
            when: windowIconRight.open
            property: "cameraPosition"
            value: EnvironmentProperties.CameraPositionsEnum.RightWindow
        }

        Connections {
            function onSelectedIndexChanged(){
                CarModelProperties.windowRearLeftMode =
                CarModelProperties.windowRearRightMode =
                CarModelProperties.windowFrontLeftMode =
                CarModelProperties.windowFrontRightMode = windowIconRight.selectedIndex;
            }
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 500
            easing.type: Easing.OutCirc
        }
    }

    // To restore to Settings state when closing all menus, no matter the previous state
    states: [
        State {
            name: "intermediate"
            when: !(windowIconLeft.open || windowIconRight.open) &&
                  root.open &&
                  EnvironmentProperties.cameraPosition !== EnvironmentProperties.CameraPositionsEnum.Settings
        },
        State {
            name: "one_open"
            when: (windowIconLeft.open || windowIconRight.open) && root.open
        }
    ]

    transitions: [
        Transition {
            from: "one_open"
            to: "intermediate"
            ScriptAction {
                script: Qt.callLater(() => EnvironmentProperties.cameraPosition = EnvironmentProperties.CameraPositionsEnum.Settings)
            }
        }
    ]
}
