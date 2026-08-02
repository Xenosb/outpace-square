import QtQuick
import QtQuick3D

import Car
import DataModel
import Ground
import SelfieStick
import Sky

Item {
    id: carView

    SkyEnvironment {
        id: sceneEnvironment

        skyLight: sun

        probeExposure: 0.45
        tonemapMode: SceneEnvironment.TonemapModeAces

        antialiasingMode: SceneEnvironment.MSAA
        antialiasingQuality: SceneEnvironment.High
    }

    Node {
        id: scene3d

        Car {
            id: mainCar
        }

        Ground {
            id: ground
        }

        DirectionalLight {
            id: keyLight

            eulerRotation.x: -35
            eulerRotation.y: -55

            brightness: 2.0
            color: "#ffffff"
        }

        DirectionalLight {
            id: fillLight

            eulerRotation.x: -20
            eulerRotation.y: 135

            brightness: 1.0
            color: "#ffffff"
        }

        DirectionalLight {
            id: rimLight

            eulerRotation.x: -55
            eulerRotation.y: 20

            brightness: 1.2
            color: "#eaf2ff"
        }
    }

    View3D {
        id: view3D_Main

        anchors.fill: parent

        environment: sceneEnvironment
        importScene: scene3d
        camera: cameraMain

        Node {
            id: orbitOrigin
            y: 100
        }

        PerspectiveCamera {
            id: cameraMain
        }

        Node {
            id: sun

            eulerRotation.x: -80 // EnvironmentProperties.dayNightMode ? -180 : -80
            eulerRotation.y: -55

            Behavior on eulerRotation.x {
                NumberAnimation { duration: 2000; easing.type: Easing.InOutQuad }
            }
        }

        SelfieStick {
            id: cameraController

            anchors.fill: parent

            camera: cameraMain
            origin: orbitOrigin
            view3d: view3D_Main

            selfieState: ssMain

            selfieStates: [
                SelfieState {
                    id: ssMain

                    rotation: Qt.vector3d(1.9, 225, 0)
                    distance: 1511
                    fov: 25

                    lookAtNode: mainCar

                    rollMarginTop: 0
                    rollMarginBottom: 0
                }
            ]
        }
    }
}

/*##^##
Designer {
    D{i:0}D{i:2;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}D{i:6;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/

