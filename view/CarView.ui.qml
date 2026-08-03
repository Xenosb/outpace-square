import QtQuick
import QtQuick3D

import Car
import CarControls
import CarHitbox
import DataModel
import SelfieStick
import Sky

Item {
    id: carView

    SkyEnvironment {
        id: sceneEnvironment

        skyLight: sun

        probeExposure: 0.45
        tonemapMode: SceneEnvironment.TonemapModeAces

        antialiasingMode: SceneEnvironment.ProgressiveAA
        antialiasingQuality: SceneEnvironment.VeryHigh
    }

    Node {
        id: scene3d

        Car {
            id: mainCar
        }

        CarHitbox {
            id: hitbox

            eulerRotation: mainCar.eulerRotation
            y: -60
            layers: mainCar.layers
        }

        Model {
            id: ground

            source: "#Cylinder"

            y: -63

            scale.x: 30
            scale.y: 0
            scale.z: 30

            materials: PrincipledMaterial {
                objectName: "glass_dark"

                roughness: 0.46
                clearcoatAmount: 1.2
                clearcoatFresnelScale: 1.7
                clearcoatRoughnessAmount: 0.2

                baseColor: "#000000"
            }
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

            x: -1074.696
            y: 209.282
            z: -1074.69641

            eulerRotation.z: 0
            eulerRotation.y: -135
            eulerRotation.x: -5.69067
        }

        Node {
            id: sun

            eulerRotation.x: -80 // EnvironmentProperties.dayNightMode ? -180 : -80
            eulerRotation.y: -55

            Behavior on eulerRotation.x {
                NumberAnimation {
                    duration: 2000
                    easing.type: Easing.InOutQuad
                }
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

                    rotation: Qt.vector3d(-4.113, 225, 0)
                    distance: 1523.77
                    fov: 25

                    lookAtNode: mainCar

                    rollMarginTop: 0
                    rollMarginBottom: 0
                }
            ]
        }

        CarControls {
            id: carControls

            view3D_Car: view3D_Main
            mainCar: mainCar
            hitbox: hitbox
            open: true
        }
    }

    Item {
        id: __materialLibrary__
    }
}

/*##^##
Designer {
    D{i:0;matPrevEnvDoc:"SkyBox";matPrevEnvValueDoc:"preview_landscape"}D{i:2;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
D{i:7;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}D{i:10;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/

