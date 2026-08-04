import QtQuick
import QtQuick3D

import DataModel

Node {
    id: node

    property real wheelAngle: 0

    component ReflectionMaterial : CustomMaterial {
        sourceBlend: CustomMaterial.NoBlend
        destinationBlend: CustomMaterial.NoBlend
        sourceAlphaBlend: CustomMaterial.NoBlend
        destinationAlphaBlend: CustomMaterial.NoBlend
        depthDrawMode: Material.AlwaysDepthDraw
        cullMode: Material.BackFaceCulling
        shadingMode: CustomMaterial.Shaded
        vertexShader: "shaders/reflectioncar.vert"
        fragmentShader: "shaders/reflectioncar.frag"

        property color baseColor: "#000000"
        property real metalness: 0.0
        property real roughness: 0.5
        property color emissiveColor: "#000000"
        property real emissiveStrength: 0.0
        property real coverAlpha: -1.0
        property real coverTint: -1.0
        property real emissiveFalloff: EnvironmentProperties.reflectionEmissiveFalloff
        property bool useBaseColorMap: false

        property TextureInput baseColorMap: TextureInput {
            texture: Texture {
                source: "maps/tire_color.png"
                generateMipmaps: true
                mipFilter: Texture.Linear
            }
        }

        property real reflectionGroundTransmission: EnvironmentProperties.reflectionGroundTransmission
        property real reflectionFadeEndY: EnvironmentProperties.reflectionFadeEndY
        property real groundPlaneY: EnvironmentProperties.reflectionPlaneY
        property color floorHighlightColor: EnvironmentProperties.reflectionFloorHighlightColor
        property color floorOuterColor: EnvironmentProperties.reflectionFloorOuterColor
        property real floorHighlightStrength: EnvironmentProperties.reflectionFloorHighlightStrength
        property real floorHighlightInnerRadius: EnvironmentProperties.reflectionFloorHighlightInnerRadius
        property real floorHighlightOuterRadius: EnvironmentProperties.reflectionFloorHighlightOuterRadius
        property real skyReflectionStrength: EnvironmentProperties.reflectionFloorSkyStrength
        property real skyReflectionBlur: EnvironmentProperties.reflectionFloorSkyBlur

        property TextureInput skyTexture: TextureInput {
            texture: Texture {
                source: "qrc:/qt/qml/Sky/legacy/maps/morning_sky.jpg"
                generateMipmaps: true
                mipFilter: Texture.Linear
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.ClampToEdge
            }
        }
    }

    component DoorAnimation : NumberAnimation {
        duration: 1500
        easing.type: Easing.InOutQuad
    }

    component WindowAnimation : NumberAnimation {
        duration: 400
        easing.type: Easing.InOutQuad
    }

    Node {
        id: car

        y: 0.6232303977012634

        scale.x: 0.1
        scale.y: 0.1
        scale.z: 0.1

        Node {
            // Front-left door position showing the mirrored front-right state
            Node {
                objectName: "ref_door_FL"

                x: -936.0574340820312
                y: 267.5298156738281
                z: -898.8701171875

                eulerRotation.y: CarModelProperties.doorFrontLeftMinZ + (CarModelProperties.doorFrontLeftMaxZ - CarModelProperties.doorFrontLeftMinZ) * CarModelProperties.doorFrontRightCurrentPosition

                Behavior on eulerRotation.y {
                    DoorAnimation {}
                }

                Model {
                    objectName: "ref_door_front_left"

                    x: 936.0574951171875
                    y: -890.7601928710938
                    z: 898.8699951171875

                    rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                    scale.x: 10
                    scale.y: 10
                    scale.z: 10

                    source: "meshes/door_front_left_mesh.mesh"
                    materials: [plasticGlossy_material, glass_dark_material, m_carpaint1_material, m_chrome_material, m_plasticblack_rough_material, turnSignal_Left_material, basic_interior]
                }

                Model {
                    objectName: "ref_window_front_left"

                    x: CarModelProperties.windowFrontLeftMinX + (CarModelProperties.windowFrontLeftMaxX - CarModelProperties.windowFrontLeftMinX) * CarModelProperties.windowFrontRightCurrentPosition
                    y: CarModelProperties.windowFrontLeftMinY + (CarModelProperties.windowFrontLeftMaxY - CarModelProperties.windowFrontLeftMinY) * CarModelProperties.windowFrontRightCurrentPosition
                    z: CarModelProperties.windowFrontLeftMinZ + (CarModelProperties.windowFrontLeftMaxZ - CarModelProperties.windowFrontLeftMinZ) * CarModelProperties.windowFrontRightCurrentPosition

                    eulerRotation.z: CarModelProperties.windowFrontLeftMinRotationZ + (CarModelProperties.windowFrontLeftMaxRotationZ - CarModelProperties.windowFrontLeftMinRotationZ) * CarModelProperties.windowFrontRightCurrentPosition

                    scale.z: 1.1
                    scale.y: 1.1
                    scale.x: 1.1

                    source: "meshes/window_front_left_mesh.mesh"

                    materials: [
                        glass_dark_material
                    ]

                    Behavior on x {
                        WindowAnimation {}
                    }

                    Behavior on y {
                        WindowAnimation {}
                    }

                    Behavior on z {
                        WindowAnimation {}
                    }

                    Behavior on eulerRotation.z {
                        NumberAnimation {
                            duration: 400
                            easing.bezierCurve: [0.2, 0.2, 0.8, 0.8, 1, 1]
                        }
                    }
                }
            }

            // Front-right door position showing the mirrored front-left state
            Node {
                objectName: "ref_door_FR"

                x: 936.056640625
                y: 267.5296936035156
                z: -898.870361328125

                eulerRotation.y: CarModelProperties.doorFrontRightMinZ + (CarModelProperties.doorFrontRightMaxZ - CarModelProperties.doorFrontRightMinZ) * CarModelProperties.doorFrontLeftCurrentPosition

                Behavior on eulerRotation.y {
                    DoorAnimation {}
                }

                Model {
                    objectName: "ref_door_front_right"

                    x: -936.0567016601562
                    y: -890.7600708007812
                    z: 898.8702392578125

                    rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                    scale.x: 10
                    scale.y: 10
                    scale.z: 10

                    source: "meshes/door_front_right_mesh.mesh"
                    materials: [m_chrome_material, plasticGlossy_material, m_plasticblack_rough_material, glass_dark_material, m_carpaint1_material, turnSignal_Right_material, basic_interior]
                }

                Node {
                    x: CarModelProperties.windowFrontRightMinX + (CarModelProperties.windowFrontRightMaxX - CarModelProperties.windowFrontRightMinX) * CarModelProperties.windowFrontLeftCurrentPosition
                    y: CarModelProperties.windowFrontRightMinY + (CarModelProperties.windowFrontRightMaxY - CarModelProperties.windowFrontRightMinY) * CarModelProperties.windowFrontLeftCurrentPosition
                    z: CarModelProperties.windowFrontRightMinZ + (CarModelProperties.windowFrontRightMaxZ - CarModelProperties.windowFrontRightMinZ) * CarModelProperties.windowFrontLeftCurrentPosition

                    eulerRotation.z: CarModelProperties.windowFrontRightMinRotationZ + (CarModelProperties.windowFrontRightMaxRotationZ - CarModelProperties.windowFrontRightMinRotationZ) * CarModelProperties.windowFrontLeftCurrentPosition

                    Behavior on x {
                        WindowAnimation {}
                    }

                    Behavior on y {
                        WindowAnimation {}
                    }

                    Behavior on z {
                        WindowAnimation {}
                    }

                    Behavior on eulerRotation.z {
                        NumberAnimation {
                            duration: 400
                            easing.bezierCurve: [0.2, 0.2, 0.8, 0.8, 1, 1]
                        }
                    }

                    Model {
                        objectName: "ref_window_front_right"

                        x: -770
                        y: -1475
                        z: 150

                        scale.x: 10
                        scale.y: 10
                        scale.z: 10

                        eulerRotation.x: 90

                        source: "meshes/window_front_right_mesh.mesh"
                        materials: [glass_dark_material]
                    }
                }
            }

            // Rear-left door position showing the mirrored rear-right state
            Node {
                objectName: "ref_door_RL"

                x: -953.5493774414062
                y: 268.074951171875
                z: 227.20556640625

                eulerRotation.y: CarModelProperties.doorRearLeftMinZ + (CarModelProperties.doorRearLeftMaxZ - CarModelProperties.doorRearLeftMinZ) * CarModelProperties.doorRearRightCurrentPosition

                Behavior on eulerRotation.y {
                    DoorAnimation {}
                }

                Model {
                    objectName: "ref_door_rear_left"

                    x: 953.5492553710938
                    y: -891.305419921875
                    z: -227.2054443359375

                    rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                    scale.x: 10
                    scale.y: 10
                    scale.z: 10

                    source: "meshes/door_rear_left_mesh.mesh"

                    materials: [
                        plasticGlossy_material,
                        m_carpaint1_material,
                        glass_darkB_material,
                        door2_material
                    ]
                }

                Model {
                    objectName: "ref_window_rear_left"

                    x: CarModelProperties.windowRearLeftMinX + (CarModelProperties.windowRearLeftMaxX - CarModelProperties.windowRearLeftMinX) * CarModelProperties.windowRearRightCurrentPosition
                    y: CarModelProperties.windowRearLeftMinY + (CarModelProperties.windowRearLeftMaxY - CarModelProperties.windowRearLeftMinY) * CarModelProperties.windowRearRightCurrentPosition
                    z: CarModelProperties.windowRearLeftMinZ + (CarModelProperties.windowRearLeftMaxZ - CarModelProperties.windowRearLeftMinZ) * CarModelProperties.windowRearRightCurrentPosition

                    eulerRotation.z: CarModelProperties.windowRearLeftMinRotationZ + (CarModelProperties.windowRearLeftMaxRotationZ - CarModelProperties.windowRearLeftMinRotationZ) * CarModelProperties.windowRearRightCurrentPosition

                    scale.z: 1.1
                    scale.y: 1.1
                    scale.x: 1.1

                    source: "meshes/window_rear_left_mesh.mesh"

                    materials: [
                        glass_darkB_material
                    ]

                    Behavior on x {
                        WindowAnimation {}
                    }

                    Behavior on y {
                        WindowAnimation {}
                    }

                    Behavior on z {
                        WindowAnimation {}
                    }

                    Behavior on eulerRotation.z {
                        NumberAnimation {
                            duration: 400
                            easing.bezierCurve: [0.2, 0.2, 0.8, 0.8, 1, 1]
                        }
                    }
                }
            }

            // Rear-right door position showing the mirrored rear-left state
            Node {
                objectName: "ref_door_RR"

                x: 953.548583984375
                y: 268.07470703125
                z: 227.20567321777344

                eulerRotation.y: CarModelProperties.doorRearRightMinZ + (CarModelProperties.doorRearRightMaxZ - CarModelProperties.doorRearRightMinZ) * CarModelProperties.doorRearLeftCurrentPosition

                Behavior on eulerRotation.y {
                    DoorAnimation {}
                }

                Model {
                    objectName: "ref_door_rear_right"

                    x: -953.5490112304688
                    y: -891.3045654296875
                    z: -227.20619201660156

                    rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                    scale.x: 10
                    scale.y: 10
                    scale.z: 10

                    source: "meshes/door_rear_right_mesh.mesh"

                    materials: [
                        m_carpaint1_material,
                        plasticGlossy_material,
                        glass_darkB_material,
                        door2_material
                    ]
                }

                Model {
                    objectName: "ref_window_rear_right"

                    x: CarModelProperties.windowRearRightMinX + (CarModelProperties.windowRearRightMaxX - CarModelProperties.windowRearRightMinX) * CarModelProperties.windowRearLeftCurrentPosition
                    y: CarModelProperties.windowRearRightMinY + (CarModelProperties.windowRearRightMaxY - CarModelProperties.windowRearRightMinY) * CarModelProperties.windowRearLeftCurrentPosition
                    z: CarModelProperties.windowRearRightMinZ + (CarModelProperties.windowRearRightMaxZ - CarModelProperties.windowRearRightMinZ) * CarModelProperties.windowRearLeftCurrentPosition

                    eulerRotation.z: CarModelProperties.windowRearRightMinRotationZ + (CarModelProperties.windowRearRightMaxRotationZ - CarModelProperties.windowRearRightMinRotationZ) * CarModelProperties.windowRearLeftCurrentPosition

                    source: "meshes/window_rear_right_mesh.mesh"

                    materials: [
                        glass_darkB_material
                    ]

                    Behavior on x {
                        WindowAnimation {}
                    }

                    Behavior on y {
                        WindowAnimation {}
                    }

                    Behavior on z {
                        WindowAnimation {}
                    }

                    Behavior on eulerRotation.z {
                        NumberAnimation {
                            duration: 400
                            easing.bezierCurve: [0.2, 0.2, 0.8, 0.8, 1, 1]
                        }
                    }
                }
            }

            // Exterior body shell, glass and tailgate
            Node {
                objectName: "ref_ext"

                y: -623.2304077148438

                rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                scale.x: 10
                scale.y: 10
                scale.z: 10

                Model {
                    objectName: "ref_body_shell"

                    source: "meshes/body_shell_mesh.mesh"

                    materials: [
                        plasticGlossy_material,
                        m_light_white_material,
                        m_glass_clear_material,
                        m_chrome_material,
                        m_glass_red_material,
                        glass_darkB_material,
                        reflectBumpB_material,
                        m_plasticblack_rough_material,
                        glass_dark_material,
                        m_carpaint1_material,
                        m_glass_red2_material,
                        glassLed_bumpB_material,
                        turnSignal_Left_material,
                        turnSignal_Right_material,
                        highbeams_material,
                        m_tyre_material
                    ]
                }

                Model {
                    objectName: "ref_exterior_glass"

                    source: "meshes/exterior_glass_mesh.mesh"
                    materials: [
                        m_glass_clear_material
                    ]
                }

                Node {
                    objectName: "ref_tailgate_1"

                    y: 172.0910186767578
                    z: -174.06906127929688

                    eulerRotation.x: CarModelProperties.trunkMinX + (CarModelProperties.trunkMaxX - CarModelProperties.trunkMinX) * CarModelProperties.trunkCurrentPosition

                    Model {
                        objectName: "ref_tailgate"

                        y: -172.09103393554688
                        z: 174.06906127929688

                        source: "meshes/tailgate_mesh.mesh"
                        materials: [
                            plasticGlossy_material,
                            m_plasticblack_rough_material,
                            glass_darkB_material,
                            m_chrome_material,
                            m_carpaint1_material,
                            m_glass_red2_material,
                            m_glass_red_material,
                            glassLed_bumpB_material,
                            brakelight_material
                        ]
                    }
                }
            }
        }

        // Wheels
        Node {
            objectName: "ref_wheel_FL"

            x: -820.93359375
            y: -201.3382110595703
            z: -1626.65576171875

            Model {
                objectName: "ref_brake_caliper_front_left"

                x: 820.9335327148438
                y: -421.8929443359375
                z: 1626.6553955078125

                rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                scale.x: 10
                scale.y: 10
                scale.z: 10

                source: "meshes/brake_caliper_front_left_mesh.mesh"
                materials: [
                    m_chrome_material
                ]
            }

            Model {
                objectName: "ref_tire_FL"

                x: -50.279296875

                eulerRotation.x: node.wheelAngle

                rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                scale.x: 10
                scale.y: 10
                scale.z: 10

                source: "meshes/tire_front_mesh.mesh"
                materials: [
                    m_tyre_material,
                    chrome_brushed_brakedisc_material,
                    m_metal_black_material,
                    m_plasticblack_rough_material,
                    m_chrome_material,
                    plasticGlossy_material
                ]
            }
        }

        Node {
            objectName: "ref_wheel_FR"

            x: 820.93359375
            y: -201.3382110595703
            z: -1626.65576171875

            Model {
                objectName: "ref_brake_caliper_front_right"

                x: -820.9335327148438
                y: -421.8929443359375
                z: 1626.6553955078125

                rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                scale.x: 10
                scale.y: 10
                scale.z: 10

                source: "meshes/brake_caliper_front_right_mesh.mesh"
                materials: [
                    m_chrome_material
                ]
            }

            Model {
                objectName: "ref_tire_FR"

                x: 50.279296875

                eulerRotation.y: -180
                eulerRotation.x: -node.wheelAngle

                scale.x: 10
                scale.y: 10
                scale.z: 10

                source: "meshes/tire_front_mesh.mesh"
                materials: [
                    m_tyre_material,
                    chrome_brushed_brakedisc_material,
                    m_metal_black_material,
                    m_plasticblack_rough_material,
                    m_chrome_material,
                    plasticGlossy_material
                ]
            }
        }

        Node {
            objectName: "ref_wheel_RL"

            x: -845.93359375
            y: -201.33837890625
            z: 1364.173095703125

            Model {
                objectName: "ref_brake_caliper_rear_left"

                x: 845.9335327148438
                y: -421.8914489746094
                z: -1364.1732177734375

                rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                scale.x: 10
                scale.y: 10
                scale.z: 10

                source: "meshes/brake_caliper_rear_left_mesh.mesh"
                materials: [
                    m_chrome_material,
                    m_metal_black_material
                ]
            }

            Model {
                objectName: "ref_tire_RL"

                eulerRotation.x: node.wheelAngle

                rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                scale.x: 10
                scale.y: 10
                scale.z: 10

                source: "meshes/tire_rear_mesh.mesh"
                materials: [
                    m_tyre_material,
                    chrome_brushed_brakedisc_material,
                    m_plasticblack_rough_material,
                    m_metal_black_material,
                    m_chrome_material,
                    plasticGlossy_material
                ]
            }
        }

        Node {
            objectName: "ref_wheel_RR"

            x: 845.93359375
            y: -201.33837890625
            z: 1364.173095703125

            Model {
                objectName: "ref_brake_caliper_rear_right"

                x: -845.9335327148438
                y: -421.8914489746094
                z: -1364.1732177734375

                rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                scale.x: 10
                scale.y: 10
                scale.z: 10

                source: "meshes/brake_caliper_rear_right_mesh.mesh"
                materials: [
                    m_chrome_material,
                    m_metal_black_material
                ]
            }

            Model {
                objectName: "ref_tire_RR"

                eulerRotation.y: -180
                eulerRotation.x: -node.wheelAngle

                scale.x: 10
                scale.y: 10
                scale.z: 10

                source: "meshes/tire_rear_mesh.mesh"
                materials: [
                    m_tyre_material,
                    chrome_brushed_brakedisc_material,
                    m_plasticblack_rough_material,
                    m_metal_black_material,
                    m_chrome_material,
                    plasticGlossy_material
                ]
            }
        }
    }

    // Opaque fade counterparts of the Car.qml materials
    Node {
        id: __materialLibrary__

        ReflectionMaterial {
            id: m_light_white_material
            objectName: "ref_m_light_white"
            baseColor: "#4c4c4c"
            metalness: 0.3
            roughness: 0.2
            emissiveColor: "#ffffff"
            emissiveStrength: 10
        }

        // Lamp covers are removed from the reflection entirely (alpha 0) so
        // the emitters behind them stay fully visible.
        ReflectionMaterial {
            id: m_glass_clear_material
            objectName: "ref_m_glass_clear"
            sourceBlend: CustomMaterial.SrcAlpha
            destinationBlend: CustomMaterial.OneMinusSrcAlpha
            depthDrawMode: Material.NeverDepthDraw
            coverAlpha: 0.0
            baseColor: "#000000"
            roughness: 0.05
        }

        // The red lamp cover tints the emitter behind it red without hiding
        // it (multiplicative blend).
        ReflectionMaterial {
            id: m_glass_red_material
            objectName: "ref_m_glass_red"
            sourceBlend: CustomMaterial.DstColor
            destinationBlend: CustomMaterial.Zero
            depthDrawMode: Material.NeverDepthDraw
            coverTint: 0.9
            baseColor: "#ff0d0d"
            roughness: 0.068
        }

        ReflectionMaterial {
            id: reflectBumpB_material
            objectName: "ref_reflectBumpB"
            baseColor: "#9a9a9a"
            roughness: 0.4343145787715912
        }

        ReflectionMaterial {
            id: glassLed_bumpB_material
            objectName: "ref_glassLed_bumpB"
            baseColor: "#828282"
            roughness: 0.23886002600193024
        }

        ReflectionMaterial {
            id: highbeams_material
            objectName: "ref_Highbeams"
            baseColor: "#303030"
            roughness: 0.2
            emissiveColor: "#ffffff"
            emissiveStrength: CarModelProperties.lightsHighBeam ? 10 : 0
        }

        ReflectionMaterial {
            id: m_glass_red2_material
            objectName: "ref_m_glass_red2"
            baseColor: "#2d0101"
            roughness: 0.4343145787715912
            emissiveColor: "#ff1a1a"
            emissiveStrength: CarModelProperties.lightsMain ? 1 : 0
        }

        ReflectionMaterial {
            id: glass_dark_material
            objectName: "ref_glass_dark"
            baseColor: "#000000"
            roughness: 0.01
        }

        ReflectionMaterial {
            id: m_carpaint1_material
            objectName: "ref_m_carpaint1"
            property color carColor: CarColorProperties.carPaintColor
            onCarColorChanged: {
                carColorAnim.to = carColor
                carColorAnim.restart()
            }
            baseColor: carColor
            metalness: 0.03
            roughness: 0.4

            ColorAnimation {
                id: carColorAnim
                target: m_carpaint1_material
                property: "baseColor"
                duration: 1200
                easing.type: Easing.InOutQuad
            }
        }

        ReflectionMaterial {
            id: m_chrome_material
            objectName: "ref_m_chrome"
            baseColor: "#2d2c2c"
            metalness: 1
            roughness: 0.91516
        }

        ReflectionMaterial {
            id: m_plasticblack_rough_material
            objectName: "ref_m_plasticblack_rough"
            baseColor: "#0d0d0d"
            roughness: 0.08273
        }

        ReflectionMaterial {
            id: turnSignal_Left_material
            objectName: "ref_TurnSignal_Left"
            baseColor: "#5e4600"
            roughness: 0.5
        }

        ReflectionMaterial {
            id: turnSignal_Right_material
            objectName: "ref_TurnSignal_Right"
            baseColor: "#5e4600"
            roughness: 0.5
        }

        ReflectionMaterial {
            id: door2_material
            objectName: "ref_door2"
            baseColor: "#262626"
            roughness: 0.671
        }

        ReflectionMaterial {
            id: plasticGlossy_material
            objectName: "ref_plasticGlossy"
            baseColor: "#000000"
            metalness: 0.90153
            roughness: 0.31858
        }

        ReflectionMaterial {
            id: brakelight_material
            objectName: "ref_Brakelight"
            baseColor: "#210000"
            roughness: 0.5
            emissiveColor: "#ff2626"
            emissiveStrength: CarModelProperties.lightsBrakeLight ? 1 : 0
        }

        ReflectionMaterial {
            id: m_tyre_material
            objectName: "ref_m_tyre"
            baseColor: "#000000"
            useBaseColorMap: true
            metalness: 0.35404
            roughness: 0.96847
        }

        ReflectionMaterial {
            id: chrome_brushed_brakedisc_material
            objectName: "ref_chrome_brushed_brakedisc"
            baseColor: "#262626"
            metalness: 1
            roughness: 0.05984
        }

        ReflectionMaterial {
            id: glass_darkB_material
            objectName: "ref_glass_darkB"
            baseColor: "#000000"
            roughness: 0.01514
        }

        ReflectionMaterial {
            id: m_metal_black_material
            objectName: "ref_m_metal_black"
            baseColor: "#1c1c1c"
            metalness: 0.96449
            roughness: 0.83242
        }

        ReflectionMaterial {
            id: basic_interior
            objectName: "ref_Basic_interior"
            baseColor: "#090909"
            roughness: 0.46861
        }
    }
}
