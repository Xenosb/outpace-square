import QtQuick

Item {
    id: root

    property alias source: icon.source

    signal clicked()

    implicitWidth: 46
    implicitHeight: 46

    opacity: mouseArea.pressed ? 0.6 : (mouseArea.containsMouse ? 0.85 : 1.0)

    Behavior on opacity {
        NumberAnimation { duration: 100 }
    }

    Image {
        id: icon
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        sourceSize: Qt.size(width, height)
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
