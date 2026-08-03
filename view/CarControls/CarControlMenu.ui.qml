import QtQuick
import QtQuick.Controls

Item {
    id: root

    enum MenuType {
        Headlights,
        Trunk,
        Windows
    }

    enabled: opacity > 0
    property alias selectedIndex: selector.currentIndex
    property bool open: false
    property alias offsetX: translate.x
    property alias offsetY: translate.y

    property int menuType: CarControlMenu.MenuType.Headlights

    property var menus: ({
                             [CarControlMenu.MenuType.Headlights]: {
                                 "iconType": CarControlIcon.IconType.Headlight,
                                 "selector": [{
                                         "icon": Qt.resolvedUrl(
                                                     "images/CarControlIcons/IconOff.svg"),
                                         "label": ""
                                     }, {
                                         "icon": Qt.resolvedUrl(
                                                     "images/CarControlIcons/IconLightsLowBeam.svg"),
                                         "label": ""
                                     }, {
                                         "icon": Qt.resolvedUrl(
                                                     "images/CarControlIcons/IconLightsHighBeam.svg"),
                                         "label": ""
                                     }]
                             },
                             [CarControlMenu.MenuType.Trunk]: {
                                 "iconType": CarControlIcon.IconType.Trunk,
                                 "selector": [{
                                         "icon": Qt.resolvedUrl(
                                                     "images/CarControlIcons/IconTrunkClose.svg"),
                                         "label": "Close"
                                     }, {
                                         "icon": Qt.resolvedUrl(
                                                     "images/CarControlIcons/IconTrunkOpen.svg"),
                                         "label": "Open"
                                     }]
                             },
                             [CarControlMenu.MenuType.Windows]: {
                                 "iconType": CarControlIcon.IconType.Window,
                                 "selector": [{
                                         "icon": Qt.resolvedUrl(
                                                     "images/CarControlIcons/IconWindowClose.svg"),
                                         "label": "Close"
                                     }, {
                                         "icon": Qt.resolvedUrl("images/CarControlIcons/IconWindowVent.svg"),
                                         "label": "Vent"
                                     }, {
                                         "icon": Qt.resolvedUrl("images/CarControlIcons/IconWindowOpen.svg"),
                                         "label": "Open"
                                     }]
                             }
                         })

    CarControlIcon {
        id: icon
        anchors.centerIn: parent

        iconType: menus[root.menuType]["iconType"]

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

    CarControlSelector {
        id: selector

        anchors.left: icon.right
        anchors.verticalCenter: icon.verticalCenter
        anchors.leftMargin: icon.width / 2
        menuModel: menus[root.menuType]["selector"]

        opacity: backButton.opacity

        transform: [
            Rotation {
                origin {
                    x: selector.width / 2
                    y: selector.height / 2
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
