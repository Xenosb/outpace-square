import QtQuick
import QtQuick3D

import DataModel

Node {
    id: node

    property real wheelAngle: 0

    property alias windowsLeft: windowsLeft
    property alias windowsRight: windowsRight
    property alias trunk: trunk
    property alias headlights: headlights
    property alias suspension_Pos: suspensionPos
    property alias door_FL: door_FL_pos
    property alias door_FR: door_FR_pos
    property alias door_RL: door_RL_pos
    property alias door_RR: door_RR_pos

    property color carColor: CarColorProperties.carPaintColor

    // Texture map sources
    property url taillightBumpMap: "maps/taillight_bump.png"
    property url doorPanelColorMap: "maps/door_panel_color.png"
    property url seatColorMap: "maps/seat_color.png"
    property url tireColorMap: "maps/tire_color.png"
    property url tireNormalMap: "maps/tire_normal.png"
    property url brakeDiscNormalMap: "maps/brake_disc_normal.png"

    // Seats
    Node {
        id: group

        objectName: "Group"

        y: 25.335
        z: 86.04549

        eulerRotation.x: 90

        Model {
            objectName: "seats"

            y: -86.04551696777344
            z: 87.03453063964844

            source: "meshes/seats_mesh.mesh"
            materials: [basic_interior, basic_interior, seat2_material]
        }
    }

    // Anchor points for CarControls icon overlay placement / occlusion picking
    Node {
        id: staticPositions

        Node {
            id: windowsLeft
            x: -85
            y: 90
            z: 30
        }

        Node {
            id: windowsRight
            x: 85
            y: 90
            z: 30
        }

        Node {
            id: headlights
            x: 0
            y: 40
            z: -250
        }

        Node {
            id: trunk
            x: 0
            y: 50
            z: 280
        }

        Node {
            id: door_FL_pos
            x: -100
            y: 20
            z: -30
        }

        Node {
            id: door_RL_pos
            x: -100
            y: 20
            z: 60
        }

        Node {
            id: door_FR_pos
            x: 100
            y: 20
            z: -30
        }

        Node {
            id: door_RR_pos
            x: 100
            y: 20
            z: 60
        }

        Node {
            id: suspensionPos
            x: -100
            y: -40
            z: -250
        }
    }

    component DoorAnimation : NumberAnimation {
        duration: 1500
        easing.type: Easing.InOutQuad
    }

    Node {
        id: car

        objectName: "Car"

        y: 0.6232303977012634

        scale.x: 0.1
        scale.y: 0.1
        scale.z: 0.1

        Node {
            Behavior on y {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.InOutQuad
                }
            }

            // Front-left door
            Node {
                objectName: "door_FL"

                x: -936.0574340820312
                y: 267.5298156738281
                z: -898.8701171875

                eulerRotation.y: CarModelProperties.doorFrontLeftMinZ + (CarModelProperties.doorFrontLeftMaxZ - CarModelProperties.doorFrontLeftMinZ) * CarModelProperties.doorFrontLeftCurrentPosition

                Behavior on eulerRotation.y {
                    DoorAnimation {}
                }

                Model {
                    objectName: "door_front_left"

                    x: 936.0574951171875
                    y: -890.7601928710938
                    z: 898.8699951171875

                    rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                    scale.x: 10
                    scale.y: 10
                    scale.z: 10

                    source: "meshes/door_front_left_mesh.mesh"
                    materials: [plasticGlossy_material,glass_dark_material,m_carpaint1_material,m_chrome_material,m_plasticblack_rough_material,turnSignal_Left_material,basic_interior]
                }

                Model {
                    objectName: "window_front_left"

                    x: CarModelProperties.windowFrontLeftMinX + (CarModelProperties.windowFrontLeftMaxX - CarModelProperties.windowFrontLeftMinX) * CarModelProperties.windowFrontLeftCurrentPosition
                    y: CarModelProperties.windowFrontLeftMinY + (CarModelProperties.windowFrontLeftMaxY - CarModelProperties.windowFrontLeftMinY) * CarModelProperties.windowFrontLeftCurrentPosition
                    z: CarModelProperties.windowFrontLeftMinZ + (CarModelProperties.windowFrontLeftMaxZ - CarModelProperties.windowFrontLeftMinZ) * CarModelProperties.windowFrontLeftCurrentPosition

                    eulerRotation.z: CarModelProperties.windowFrontLeftMinRotationZ +(CarModelProperties.windowFrontLeftMaxRotationZ - CarModelProperties.windowFrontLeftMinRotationZ)* CarModelProperties.windowFrontLeftCurrentPosition

                    scale.z: 1.1
                    scale.y: 1.1
                    scale.x: 1.1

                    source: "meshes/window_front_left_mesh.mesh"

                    materials: [
                        glass_dark_material
                    ]

                    Behavior on x {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on y {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on z {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on eulerRotation.z {
                        NumberAnimation {
                            duration: 400
                            easing.bezierCurve: [0.2,0.2,0.8,0.8,1,1]
                        }
                    }
                }
            }

            // Front-right door
            Node {
                objectName: "door_FR"

                x: 936.056640625
                y: 267.5296936035156
                z: -898.870361328125

                eulerRotation.y: CarModelProperties.doorFrontRightMinZ + (CarModelProperties.doorFrontRightMaxZ - CarModelProperties.doorFrontRightMinZ) * CarModelProperties.doorFrontRightCurrentPosition

                Behavior on eulerRotation.y {
                    DoorAnimation {}
                }

                Model {
                    objectName: "door_front_right"

                    x: -936.0567016601562
                    y: -890.7600708007812
                    z: 898.8702392578125

                    rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                    scale.x: 10
                    scale.y: 10
                    scale.z: 10

                    source: "meshes/door_front_right_mesh.mesh"
                    materials: [m_chrome_material,plasticGlossy_material,m_plasticblack_rough_material,glass_dark_material,m_carpaint1_material,turnSignal_Right_material,basic_interior]
                }

                Node {
                    x: CarModelProperties.windowFrontRightMinX + (CarModelProperties.windowFrontRightMaxX - CarModelProperties.windowFrontRightMinX) * CarModelProperties.windowFrontRightCurrentPosition
                    y: CarModelProperties.windowFrontRightMinY + (CarModelProperties.windowFrontRightMaxY - CarModelProperties.windowFrontRightMinY) * CarModelProperties.windowFrontRightCurrentPosition
                    z: CarModelProperties.windowFrontRightMinZ + (CarModelProperties.windowFrontRightMaxZ - CarModelProperties.windowFrontRightMinZ) * CarModelProperties.windowFrontRightCurrentPosition

                    eulerRotation.z: CarModelProperties.windowFrontRightMinRotationZ +(CarModelProperties.windowFrontRightMaxRotationZ - CarModelProperties.windowFrontRightMinRotationZ)* CarModelProperties.windowFrontRightCurrentPosition

                    Behavior on z {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on x {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on y {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on eulerRotation.z {
                        NumberAnimation {
                            easing.bezierCurve: [0.2,0.2,0.8,0.8,1,1]
                            duration: 400

                        }
                    }

                    Model {
                        objectName: "window_front_right"

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

            // Rear-left door
            Node {
                objectName: "door_RL"

                x: -953.5493774414062
                y: 268.074951171875
                z: 227.20556640625

                eulerRotation.y: CarModelProperties.doorRearLeftMinZ + (CarModelProperties.doorRearLeftMaxZ - CarModelProperties.doorRearLeftMinZ) * CarModelProperties.doorRearLeftCurrentPosition

                Behavior on eulerRotation.y {
                    DoorAnimation {}
                }

                Model {
                    objectName: "door_rear_left"

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
                    objectName: "window_rear_left"

                    x: CarModelProperties.windowRearLeftMinX + (CarModelProperties.windowRearLeftMaxX - CarModelProperties.windowRearLeftMinX) * CarModelProperties.windowRearLeftCurrentPosition
                    y: CarModelProperties.windowRearLeftMinY + (CarModelProperties.windowRearLeftMaxY - CarModelProperties.windowRearLeftMinY) * CarModelProperties.windowRearLeftCurrentPosition
                    z: CarModelProperties.windowRearLeftMinZ + (CarModelProperties.windowRearLeftMaxZ - CarModelProperties.windowRearLeftMinZ) * CarModelProperties.windowRearLeftCurrentPosition

                    eulerRotation.z: CarModelProperties.windowRearLeftMinRotationZ +(CarModelProperties.windowRearLeftMaxRotationZ - CarModelProperties.windowRearLeftMinRotationZ)* CarModelProperties.windowRearLeftCurrentPosition

                    scale.z: 1.1
                    scale.y: 1.1
                    scale.x: 1.1

                    source: "meshes/window_rear_left_mesh.mesh"

                    materials: [
                        glass_darkB_material
                    ]

                    Behavior on x {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on y {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on z {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on eulerRotation.z {
                        NumberAnimation {
                            duration: 400
                            easing.bezierCurve: [0.2,0.2,0.8,0.8,1,1]
                        }
                    }
                }
            }

            // Rear-right door
            Node {
                objectName: "door_RR"

                x: 953.548583984375
                y: 268.07470703125
                z: 227.20567321777344

                eulerRotation.y: CarModelProperties.doorRearRightMinZ + (CarModelProperties.doorRearRightMaxZ - CarModelProperties.doorRearRightMinZ) * CarModelProperties.doorRearRightCurrentPosition

                Behavior on eulerRotation.y {
                    DoorAnimation {}
                }

                Model {
                    objectName: "door_rear_right"

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
                    objectName: "window_rear_right"

                    x: CarModelProperties.windowRearRightMinX + (CarModelProperties.windowRearRightMaxX - CarModelProperties.windowRearRightMinX) * CarModelProperties.windowRearRightCurrentPosition
                    y: CarModelProperties.windowRearRightMinY + (CarModelProperties.windowRearRightMaxY - CarModelProperties.windowRearRightMinY) * CarModelProperties.windowRearRightCurrentPosition
                    z: CarModelProperties.windowRearRightMinZ + (CarModelProperties.windowRearRightMaxZ - CarModelProperties.windowRearRightMinZ) * CarModelProperties.windowRearRightCurrentPosition

                    eulerRotation.z: CarModelProperties.windowRearRightMinRotationZ +(CarModelProperties.windowRearRightMaxRotationZ - CarModelProperties.windowRearRightMinRotationZ)* CarModelProperties.windowRearRightCurrentPosition

                    source: "meshes/window_rear_right_mesh.mesh"

                    materials: [
                        glass_darkB_material
                    ]

                    Behavior on x {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on y {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on z {
                        NumberAnimation {
                            duration: 400
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on eulerRotation.z {
                        NumberAnimation {
                            duration: 400
                            easing.bezierCurve: [0.2,0.2,0.8,0.8,1,1]
                        }
                    }
                }
            }

            // Exterior body shell, glass and tailgate
            Node {
                objectName: "ext"

                y: -623.2304077148438

                rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)

                scale.x: 10
                scale.y: 10
                scale.z: 10

                Model {
                    objectName: "body_shell"

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
                    objectName: "exterior_glass"

                    source: "meshes/exterior_glass_mesh.mesh"
                    materials: [
                        m_glass_clear_material
                    ]
                }

                Node {
                    objectName: "tailgate_1"

                    y: 172.0910186767578
                    z: -174.06906127929688

                    eulerRotation.x: CarModelProperties.trunkMinX + (CarModelProperties.trunkMaxX - CarModelProperties.trunkMinX) * CarModelProperties.trunkCurrentPosition

                    Model {
                        objectName: "tailgate"

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
            objectName: "wheel_FL_wheelsLayer"

            x: -820.93359375
            y: -201.3382110595703
            z: -1626.65576171875

            Model {
                objectName: "brake_caliper_front_left"

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
                objectName: "tire_FL"

                x: -50.279296875
                y: 0
                z: 0

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
            objectName: "wheel_FR_wheelsLayer"

            x: 820.93359375
            y: -201.3382110595703
            z: -1626.65576171875

            Model {
                objectName: "brake_caliper_front_right"

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
                objectName: "tire_FR"

                x: 50.279296875
                y: 0
                z: 0

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
            objectName: "wheel_RL_wheelsLayer"

            x: -845.93359375
            y: -201.33837890625
            z: 1364.173095703125

            Model {
                objectName: "brake_caliper_rear_left"

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
                objectName: "tire_RL"

                x: 0
                y: 0
                z: 0

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
            objectName: "wheel_RR_wheelsLayer"

            x: 845.93359375
            y: -201.33837890625
            z: 1364.173095703125

            Model {
                objectName: "brake_caliper_rear_right"

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
                objectName: "tire_RR"

                x: 0
                y: 0
                z: 0

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

    // Textures and materials
    Node {
        id: __materialLibrary__

        Texture {
            id: doorPanelTexture
            pivotV: 1
            positionV: 1
            generateMipmaps: true
            mipFilter: Texture.Linear
            source: node.doorPanelColorMap
            objectName: "doorPanelTexture"
        }

        Texture {
            id: taillightBumpTexture
            pivotV: 1
            positionV: 19
            scaleU: 10
            scaleV: 10
            generateMipmaps: true
            mipFilter: Texture.Linear
            source: node.taillightBumpMap
            objectName: "taillightBumpTexture"
        }

        Texture {
            id: seatColorTexture
            pivotV: 1
            positionV: 1
            generateMipmaps: true
            mipFilter: Texture.Linear
            source: node.seatColorMap
            objectName: "seatColorTexture"
        }

        Texture {
            id: tireColorTexture
            pivotV: 1
            positionV: 1
            generateMipmaps: true
            mipFilter: Texture.Linear
            source: node.tireColorMap
            objectName: "tireColorTexture"
        }

        Texture {
            id: tireNormalTexture
            pivotV: 1
            positionV: 1
            generateMipmaps: true
            mipFilter: Texture.Linear
            source: node.tireNormalMap
            objectName: "tireNormalTexture"
        }

        Texture {
            id: brakeDiscNormalTexture
            pivotV: 1
            positionV: 1
            generateMipmaps: true
            mipFilter: Texture.Linear
            source: node.brakeDiscNormalMap
            objectName: "brakeDiscNormalTexture"
        }

        PrincipledMaterial {
            id: m_light_white_material
            roughness: 0.2
            metalness: 0.3
            objectName: "m_light_white"
            baseColor: "#4c4c4c"
            emissiveFactor.x: 10
            emissiveFactor.y: 10
            emissiveFactor.z: 10
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: m_glass_clear_material
            opacity: 0.283
            lighting: PrincipledMaterial.FragmentLighting
            clearcoatAmount: 0.95891
            objectName: "m_glass_clear"
            baseColor: "#000000"
            roughness: 1
            alphaMode: PrincipledMaterial.Blend
        }

        PrincipledMaterial {
            id: m_glass_red_material
            objectName: "m_glass_red"
            baseColor: "#30ff0100"
            roughness: 0.06798290610313416
            alphaMode: PrincipledMaterial.Blend
        }

        PrincipledMaterial {
            id: reflectBumpB_material
            objectName: "reflectBumpB"
            baseColor: "#ff9a9a9a"
            roughness: 0.4343145787715912
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: glassLed_bumpB_material
            objectName: "glassLed_bumpB"
            baseColor: "#ff828282"
            roughness: 0.23886002600193024
            normalMap: taillightBumpTexture
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: highbeams_material
            baseColor: "#303030"
            objectName: "Highbeams"
            roughness: 0.2
            emissiveFactor.x: CarModelProperties.lightsHighBeam ? 10 : 0
            emissiveFactor.y: CarModelProperties.lightsHighBeam ? 10 : 0
            emissiveFactor.z: CarModelProperties.lightsHighBeam ? 10 : 0
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: m_glass_red2_material
            objectName: "m_glass_red2"
            baseColor: "#2d0101"
            roughness: 0.4343145787715912
            emissiveFactor.x: CarModelProperties.lightsMain ? 1 : 0
            emissiveFactor.y: CarModelProperties.lightsMain ? 0.1 : 0
            emissiveFactor.z: CarModelProperties.lightsMain ? 0.1 : 0
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: glass_dark_material
            opacity: 0.9
            depthDrawMode: Material.AlwaysDepthDraw
            clearcoatAmount: 1
            objectName: "glass_dark"
            baseColor: "#fa000000"
            roughness: 0.01
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
        }

        PrincipledMaterial {
            id: m_carpaint1_material
            objectName: "m_carpaint1"
            property color carColor: node.carColor
            onCarColorChanged:
            {
                carColorAnim.to = carColor
                carColorAnim.restart()
            }
            baseColor: carColor
            normalStrength: 0.1
            clearcoatRoughnessAmount: 0.05
            clearcoatAmount: 0.8
            metalness: 0.03
            roughness: 0.4
            alphaMode: PrincipledMaterial.Opaque
            ColorAnimation {
                id: carColorAnim
                target: m_carpaint1_material
                property: "baseColor"
                duration: 1200
                easing.type: Easing.InOutQuad
            }
        }

        PrincipledMaterial {
            id: m_chrome_material
            objectName: "m_chrome"
            baseColor: "#2d2c2c"
            metalness: 1
            roughness: 0.91516
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: m_plasticblack_rough_material
            lighting: PrincipledMaterial.FragmentLighting
            objectName: "m_plasticblack_rough"
            baseColor: "#0d0d0d"
            roughness: 0.08273
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: turnSignal_Left_material
            objectName: "TurnSignal_Left"
            roughness: 0.5
            alphaMode: PrincipledMaterial.Opaque

            baseColor: "#5e4600"
            property real blinkStrength: 0.0
            emissiveFactor: Qt.vector3d(blinkStrength, blinkStrength, 0)
        }

        PrincipledMaterial {
            id: seat2_material
            objectName: "seat2"
            baseColorMap: seatColorTexture
            roughness: 0.7152813673019409
            alphaMode: PrincipledMaterial.Opaque
            baseColor: "#cbc6ba"
            depthDrawMode: Material.AlwaysDepthDraw
        }

        PrincipledMaterial {
            id: door2_material
            cullMode: Material.NoCulling
            baseColor: "#262626"
            objectName: "door2"
            baseColorMap: doorPanelTexture
            roughness: 0.671
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: plasticGlossy_material
            clearcoatAmount: 0
            metalness: 0.90153
            roughness: 0.31858
            objectName: "plasticGlossy"
            baseColor: "#000000"
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: brakelight_material
            objectName: "Brakelight"
            baseColor: "#210000"
            roughness: 0.5
            alphaMode: PrincipledMaterial.Opaque
            emissiveFactor.x: CarModelProperties.lightsBrakeLight ? 1 : 0
            emissiveFactor.y: CarModelProperties.lightsBrakeLight ? 0.15 : 0
            emissiveFactor.z: CarModelProperties.lightsBrakeLight ? 0.15 : 0
        }

        PrincipledMaterial {
            id: m_tyre_material
            lighting: PrincipledMaterial.FragmentLighting
            metalness: 0.35404
            baseColor: "#000000"
            objectName: "m_tyre"
            baseColorMap: tireColorTexture
            roughness: 0.96847
            normalMap: tireNormalTexture
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: turnSignal_Right_material
            objectName: "TurnSignal_Right"
            roughness: 0.5
            alphaMode: PrincipledMaterial.Opaque

            baseColor: "#5e4600"
            property real blinkStrength: 0.0
            emissiveFactor: Qt.vector3d(blinkStrength, blinkStrength, 0)
        }

        PrincipledMaterial {
            id: chrome_brushed_brakedisc_material
            roughness: 0.05984
            objectName: "chrome_brushed_brakedisc"
            baseColor: "#262626"
            metalness: 1
            normalMap: brakeDiscNormalTexture
            normalStrength: 0.4
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: glass_darkB_material
            opacity: 0.9
            depthDrawMode: Material.AlwaysDepthDraw
            clearcoatAmount: 1
            roughness: 0.01514
            objectName: "glass_darkB"
            baseColor: "#f7000000"
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Blend
        }

        PrincipledMaterial {
            id: m_metal_black_material
            metalness: 0.96449
            clearcoatAmount: 0
            objectName: "m_metal_black"
            baseColor: "#1c1c1c"
            roughness: 0.83242
            cullMode: PrincipledMaterial.NoCulling
            alphaMode: PrincipledMaterial.Opaque
        }

        PrincipledMaterial {
            id: basic_interior
            depthDrawMode: Material.OpaqueOnlyDepthDraw
            roughness: 0.46861
            baseColor: "#090909"
            objectName: "Basic_interior"
        }
    }
}
