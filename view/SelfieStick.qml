import QtQuick
import QtQuick3D
import QtQuick3D.Helpers

Item {
    id: root

    property SelfieState selfieState
    property list<SelfieState> selfieStates
    required property Camera camera
    required property Node origin
    required property View3D view3d

    property alias dragging: flickable.dragging
    property alias distanceAnimation: distanceAnimation
    property alias yawAnimation: rotationYAnim
    property alias pitchAnimation: rotationXAnim
    property alias rollAnimation: rotationZAnim
    property alias lookAtAnimation: lookAtAnimation
    property alias fovAnimation: fovAnim

    property alias horizontalSensitivity: flickable.sensitivityX
    property alias verticalSenitivity: flickable.sensitivityY

    onSelfieStateChanged: {
        flickable.contentX = 0;
        flickable.contentY = 0;
        rootNode.currentState.distance = root.selfieState.distance;
        rootNode.currentState.fov = root.selfieState.fov;
        rootNode.currentState.rotation = root.selfieState.rotation;
        rootNode.currentState.lookAtNode = root.selfieState.lookAtNode;

        rootNode.currentState.yawMarginLeft = root.selfieState.yawMarginLeft;
        rootNode.currentState.yawMarginRight = root.selfieState.yawMarginRight;
        rootNode.currentState.yawMaxOvershoot = Math.max(0.000001, root.selfieState.yawMaxOvershoot);

        rootNode.currentState.rollMarginTop = Math.min(root.selfieState.rollMarginTop, 89 + rootNode.currentState.rotation.x);
        rootNode.currentState.rollMarginBottom = Math.min(root.selfieState.rollMarginBottom, 89 - rootNode.currentState.rotation.x);
        rootNode.currentState.rollMaxOvershoot = Math.max(0.000001, root.selfieState.rollMaxOvershoot);

        rootNode.currentState.rotation.y = Qt.binding(() => flickable.yaw + root.selfieState.rotation.y);
        rootNode.currentState.rotation.x = Qt.binding(() => flickable.roll + root.selfieState.rotation.x);
    }

    Node {
        id: rootNode

        property SelfieState currentState: SelfieState {
            lookAtNode: Node {}
        }

        Node {
            id: cameraOrigin
            property real rX: rootNode.currentState.rotation.x
            property real rY: rootNode.currentState.rotation.y
            property real rZ: rootNode.currentState.rotation.z
            property real fov: rootNode.currentState.fov

            eulerRotation: ({
                    x: rX,
                    y: rY,
                    z: rZ
                })

            Node {
                id: cameraLocation
                position.z: rootNode.currentState.distance

                Behavior on position.z {
                    NumberAnimation {
                        id: distanceAnimation
                        duration: 1000
                        easing.type: Easing.OutCirc
                    }
                }
            }

            Behavior on rX {
                enabled: !flickable.movingVertically
                RotationAnimation {
                    id: rotationXAnim
                    duration: 1000
                    easing.type: Easing.OutCirc
                    direction: RotationAnimation.Shortest
                }
            }

            Behavior on rY {
                enabled: !flickable.movingHorizontally
                RotationAnimation {
                    id: rotationYAnim
                    duration: 1000
                    easing.type: Easing.OutCirc
                    direction: RotationAnimation.Shortest
                }
            }

            Behavior on rZ {
                id: rzBehavior
                RotationAnimation {
                    id: rotationZAnim
                    duration: 1000
                    easing.type: Easing.OutCirc
                    direction: RotationAnimation.Shortest
                }
            }

            Behavior on fov {
                id: fovBehavior
                NumberAnimation {
                    id: fovAnim
                    duration: 1000
                    easing.type: Easing.OutCirc
                }
            }
        }

        Node {
            id: lookAt
            position: rootNode.currentState.lookAtNode.position
            parent: rootNode.currentState.lookAtNode.parent

            Behavior on position {
                Vector3dAnimation {
                    id: lookAtAnimation
                    duration: 1000
                    easing.type: Easing.OutCirc
                }
            }
        }

        LookAtNode {
            id: lookAtNode
            target: lookAt
            position: cameraLocation.scenePosition
        }
    }

    Binding {
        target: cameraOrigin
        property: "parent"
        value: root.origin
    }

    Binding {
        target: camera
        property: "parent"
        value: root.view3d.scene
    }

    Binding {
        target: lookAtNode
        property: "parent"
        value: root.view3d.scene
    }

    Binding {
        target: camera
        property: "position"
        value: cameraLocation.scenePosition
    }

    Binding {
        target: camera
        property: "fieldOfView"
        value: cameraOrigin.fov
    }

    Binding {
        target: camera
        property: "rotation"
        value: lookAtNode.sceneRotation
    }

    Flickable {
        id: flickable
        anchors.fill: parent

        contentWidth: width + ((leftMargin + rightMargin > 0) ? 1 : 0)
        contentHeight: height + ((topMargin + bottomMargin > 0) ? 1 : 0)
        contentX: 0
        contentY: 0
        maximumFlickVelocity: 1000

        boundsBehavior: Flickable.DragAndOvershootBounds
        boundsMovement: Flickable.StopAtBounds

        leftMargin: rootNode.currentState.yawMarginRight / sensitivityX
        rightMargin: rootNode.currentState.yawMarginLeft / sensitivityX
        topMargin: rootNode.currentState.rollMarginBottom / sensitivityY
        bottomMargin: rootNode.currentState.rollMarginTop / sensitivityY

        property real sensitivityX: 180 / Math.max(1, width)
        property real sensitivityY: 90 / Math.max(1, height)

        readonly property real yawOvershoot: rootNode.currentState.yawMaxOvershoot * (Math.tanh((sensitivityX * horizontalOvershoot) / (rootNode.currentState.yawMaxOvershoot * 0.5)))
        readonly property real rollOvershoot: rootNode.currentState.rollMaxOvershoot * (Math.tanh((sensitivityY * -verticalOvershoot) / (rootNode.currentState.rollMaxOvershoot * 0.5)))

        readonly property real yaw: ((contentX * sensitivityX)) % 360 + yawOvershoot
        readonly property real roll: (-contentY * sensitivityY) % 360 + rollOvershoot
    }
}
