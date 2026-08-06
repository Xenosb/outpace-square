import QtQuick
import QtQuick.Effects

Item {
    id: root

    property alias color: colorize.colorizationColor
    property bool mirrored: false

    signal clicked()

    rotation: mirrored ? 180 : 0

    implicitWidth: 32
    implicitHeight: 32

    opacity: mouseArea.pressed ? 0.6 : (mouseArea.containsMouse ? 0.85 : 1.0)

    Behavior on opacity {
        NumberAnimation { duration: 100 }
    }

    Image {
        id: icon
        anchors.fill: parent
        source: "images/chevron.svg"
        sourceSize: Qt.size(width, height)
        visible: false
    }

    MultiEffect {
        id: colorize
        anchors.fill: icon
        source: icon
        colorization: 1.0
        colorizationColor: "#4a94e3"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
