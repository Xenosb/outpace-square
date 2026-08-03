import QtQuick
import QtQuick.Effects

Item {
    id: root
    opacity: 0.75
    property alias radius: rectangle.radius

    Item {
        anchors.fill: parent
        anchors.margins: -shadow.blur
        layer.enabled: true

        RectangularShadow {
            id: shadow
            anchors.fill: parent
            anchors.margins: blur
            color: 'white'
            blur: 15
            radius: height
        }

        Rectangle {
            id: rectangle
            anchors.fill: shadow
            color: 'black'
            radius: height
            border.width: 1
            border.color: '#88FFFFFF'
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCirc
        }
    }
}
