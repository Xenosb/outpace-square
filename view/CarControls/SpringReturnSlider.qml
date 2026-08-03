import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

Item {
    id: root

    property real targetProgress: 0
    readonly property real currentProgress : interpolator.progress
    property alias slotWidth: curveShape.strokeWidth
    readonly property alias interacting : dragHandler.active
    readonly property alias progressSpringAnimation : progressAnim
    readonly property alias handleReturnSpringAnimation : handleReturnAnim
    property alias handleSize : handle.handleSize


    MultiEffect {
        id: eff
        anchors.fill: parent
        source: Rectangle {
            id: gradient
            width: root.width
            height: root.height
            gradient: LinearGradient {
                GradientStop {
                    position: Math.min(0.0,
                                       interpolator.horizontalProgress - 0.05)
                    color: "#11ffffff"
                }
                GradientStop {
                    position: interpolator.horizontalProgress - 0.05
                    color: "#55ffffff"
                }
                GradientStop {
                    position: interpolator.horizontalProgress
                    color: "white"
                }
                GradientStop {
                    position: interpolator.horizontalProgress + 0.05
                    color: "#55ffffff"
                }
                GradientStop {
                    position: Math.max(1.0,
                                       interpolator.horizontalProgress + 0.05)
                    color: "#11ffffff"
                }
                orientation: LinearGradient.Horizontal
            }
        }
        maskEnabled: true
        maskSource: innerContainer
    }

    Item {
        id: innerContainer
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4
        opacity: 0

        Shape {
            id: curve
            anchors.fill: parent
            anchors.margins: curveShape.strokeWidth / 2

            readonly property real h: Math.min(height, width / 2)
            readonly property real circleRadius: h / 2 + width * width / (8 * h)
            readonly property real minorAngle: 2 * Math.asin(
                                                   width / (2 * circleRadius)) * 180 / Math.PI

            ShapePath {
                id: curveShape
                strokeColor: "black"
                strokeWidth: 6
                fillColor: "transparent"

                startX: 0
                startY: curve.height

                PathArc {
                    x: curve.width
                    y: curve.height
                    radiusX: curve.circleRadius
                    radiusY: curve.circleRadius
                    direction: PathArc.Clockwise
                }
            }
        }
    }

    Item {
        anchors.fill: parent
        anchors.margins: curve.anchors.margins
        Item {
            id: handle
            property real handleSize : 40
            x: interpolator2.x
            y: interpolator2.y

            RectangularShadow {
                anchors.centerIn: parent
                blur: handle.handleSize / 3
                radius: handle.handleSize / 2
                width: handle.handleSize
                height: handle.handleSize
                color: 'white'
            }
            Rectangle {
                anchors.centerIn: parent
                width: handle.handleSize
                height: handle.handleSize
                color: 'white'
                radius: handle.handleSize / 2

                DragHandler {
                    id: dragHandler
                    margin: handle.handleSize / 2
                    target: dragItem
                    onActiveChanged: {
                        if (!active) {
                            root.targetProgress = interpolator.progress
                        }
                    }
                }
            }
        }

        Item {
            id: dragItem
            property real userProgress: nearestPointOnCircle(Qt.point(x, y)).z
            onUserProgressChanged: {
                if (dragHandler.active)
                    root.targetProgress = userProgress
            }
        }
    }

    PathInterpolator {
        id: interpolator
        progress: root.targetProgress
        readonly property real horizontalProgress: x / curve.width
        path: Path {

            startX: 0
            startY: curve.height

            PathArc {
                x: curve.width
                y: curve.height
                radiusX: curve.circleRadius
                radiusY: curve.circleRadius
                direction: PathArc.Clockwise
            }
        }

        Behavior on progress {
            SpringAnimation {id: progressAnim; spring: 3; damping: 0.9; velocity: 0.3 }
        }
    }


    PathInterpolator {
        id: interpolator2
        path: Path {
            startX: 0
            startY: curve.height
            PathArc {
                x: curve.width
                y: curve.height
                radiusX: curve.circleRadius
                radiusY: curve.circleRadius
                direction: PathArc.Clockwise
            }
        }

        Binding on progress {
            value: root.targetProgress
            delayed: true
        }
    }

    SpringAnimation {
        id: handleReturnAnim
        running: !dragHandler.active
        target: interpolator2
        to:  root.targetProgress
        property: "progress"
        spring: 12
        damping: 0.05
        velocity: 2.5
        mass: 0.1
    }

    function nearestPointOnCircle(point) {
        const circleX = curve.width / 2
        const circleY = (curve.height + curve.circleRadius) - curve.h

        point.y = Math.min(point.y, curve.height);

        const dx = point.x - circleX
        const dy = point.y - circleY
        const distance = Math.hypot(dx, dy)

        let retVal

        if (distance === 0) {
            retVal = Qt.vector3d(circleX + curve.circleRadius, circleY, 0)
        } else {
            const scale = curve.circleRadius / distance

            retVal = Qt.vector3d(circleX + dx * scale,
                              circleY + dy * scale, 0)
        }

        let angle = Math.atan2(circleY - retVal.y, circleX - retVal.x)
        const begin = (180 - curve.minorAngle) / 2;
        angle = 180 * angle / Math.PI;
        retVal.z = Math.max (0, Math.min(1, (angle - begin) / curve.minorAngle));
        return retVal
    }
}
