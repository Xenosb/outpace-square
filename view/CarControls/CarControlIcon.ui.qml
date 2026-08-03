import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Effects

Button {
    id: root

    property int iconType: CarControlIcon.IconType.Trunk
    enabled: opacity > 0

    enum IconType {
        Door,
        Window,
        Headlight,
        Trunk,
        Suspension,
        Back
    }

    readonly property var iconSources: [
        "images/CarControlIcons/IconDoor.svg",
        "images/CarControlIcons/IconWindow.svg",
        "images/CarControlIcons/IconLightsLowBeam.svg",
        "images/CarControlIcons/IconTrunkOpen.svg",
        "images/CarControlIcons/IconSuspension.svg",
        "images/CarControlIcons/IconBack.svg"
    ]


    padding: font.pixelSize * 0.618
    leftInset: 0
    rightInset: 0
    bottomInset: 0
    topInset: 0

    icon.source: root.iconSources[root.iconType]
    icon.width: font.pixelSize
    icon.height: font.pixelSize

    font.pixelSize: 32

    palette.active.buttonText: root.down ? "yellow" : "white"
    palette.disabled.buttonText: "grey"

    contentItem: RowLayout {
        spacing: root.font.pixelSize / 3

        Image {
            Layout.margins: 0
            Layout.preferredWidth: root.font.pixelSize
            Layout.preferredHeight: root.font.pixelSize
            source: root.icon.source
            sourceSize: Qt.size(root.font.pixelSize, root.font.pixelSize)
        }

        Text {
            visible: text.length > 0
            Layout.preferredHeight: root.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            padding: 0
            font: root.font
            text: root.text
            color: "white"
        }
    }

    background: CarControlBackground {
        opacity: root.down ? 1 : 0.6
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 500
            easing.type: Easing.OutCirc
        }
    }
}
