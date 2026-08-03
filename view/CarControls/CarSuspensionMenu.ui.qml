import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
    id: root

    enabled: opacity > 0
    property alias selectedIndex: selector.currentIndex
    property bool open: false
    property alias offsetX: translate.x
    property alias offsetY: translate.y

    CarControlIcon {
        id: icon
        anchors.centerIn: parent

        iconType: CarControlIcon.IconType.Suspension

        visible: opacity > 0
        opacity: root.open ? 0 : 1
        z: root.open ? -1 : 0
        onClicked: root.open = true

        transform: [
            Scale {
                origin {
                    x: icon.width / 2
                    y: icon.height / 2
                }
                xScale: 1.5 - 0.5 * icon.opacity
                yScale: 1.5 - 0.5 * icon.opacity
            }
        ]
    }

    CarControlIcon {
        id: backButton
        anchors.centerIn: icon
        iconType: CarControlIcon.IconType.Back
        visible: opacity > 0
        opacity: !root.open ? 0 : 1
        z: !root.open ? -1 : 0
        onClicked: root.open = false

        transform: [
            Scale {
                origin {
                    x: backButton.width / 2
                    y: backButton.height / 2
                }
                xScale: 1.5 - 0.5 * backButton.opacity
                yScale: 1.5 - 0.5 * backButton.opacity
            }
        ]
    }

    ScrollBar {
        id: selector

        padding: 0
        bottomInset: 0
        leftInset: 0
        topInset: 0
        rightInset: 0

        anchors.right: icon.left
        anchors.bottom: icon.bottom
        anchors.rightMargin: icon.width / 2

        width: 300

        height: 400
        property var labels : ["High", "Normal", "Access"]

        policy: ScrollBar.AlwaysOn
        snapMode: ScrollBar.SnapOnRelease
        minimumSize: 1.0 / repeater.count
        stepSize: 1.0 / (repeater.count - 1)
        property int currentIndex : 0
        opacity: backButton.opacity
        position: 1

        Connections {
            function onPositionChanged() {
                Qt.callLater(() => selector.currentIndex =  Math.round((repeater.count - 1) * selector.position))
            }
        }

        background: CarControlBackground {
            radius: 32

                ColumnLayout {
                    anchors.fill: parent
                Repeater {
                        id: repeater
                        model: selector.labels

                        CarControlIcon{
                            background: null
                            text: modelData
                            icon.source:
                                "data:image/svg+xml;utf8," +
                                "<svg xmlns='http://www.w3.org/2000/svg' width='56' height='56' viewBox='0 0 56 56'>" +
                                "<line x1='4' y1='28' x2='52' y2='28' stroke='white' stroke-width='8' stroke-linecap='round'/>" +
                                "</svg>"
                            Layout.fillWidth: true
                        }
                }
            }
        }

        contentItem:  Item {
                id: selectedPosition
        }

        Item {
                x: selectedPosition.x
                y: selectedPosition.y
                width: selectedPosition.width
                height: selectedPosition.height
                Behavior on y {
                           SmoothedAnimation { velocity: selectedPosition.height * 2}
                }

                RectangularShadow {
                    width: 56
                    height: 12
                    radius: 6
                    spread: 6
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: width / 2
                    color: '#f6ceb9'
                }
        }

        transform: [
            Rotation {
                origin {
                    x: selector.width / 2
                    y: selector.height
                }
                axis {
                    x: 1
                    y: 0
                    z: 0
                }
                angle: (backButton.opacity - 1) * 90
            },
            Translate {
                x: (backButton.opacity - 1) * icon.width
            },
            Scale {
                xScale: 0.5 + backButton.opacity / 2
            }
        ]
    }

    component Anim : NumberAnimation {
        duration: 1000
        easing.type: Easing.InOutQuad
    }

    transform: [
        Translate {
            id: translate
            Behavior on x {
                Anim { }
            }
            Behavior on y {
                Anim { }
            }
        }
    ]

    Behavior on opacity {
        Anim { }
    }
}
