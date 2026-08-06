import QtQuick

Item {
    id: root

    property real temperature: 21.0

    signal decreaseClicked()
    signal increaseClicked()

    implicitWidth: 176
    implicitHeight: 46

    ChevronButton {
        id: leftChevron
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.verticalCenter: parent.verticalCenter
        color: "#4a94e3"
        onClicked: root.decreaseClicked()
    }

    Text {
        anchors.centerIn: parent
        text: root.temperature.toFixed(1) + " °"
        color: "#ffffff"
        font.family: "Urbanist"
        font.weight: Font.Medium
        font.pixelSize: 28
        font.letterSpacing: 4
        lineHeight: 32
        lineHeightMode: Text.FixedHeight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    ChevronButton {
        id: rightChevron
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.verticalCenter: parent.verticalCenter
        mirrored: true
        color: "#ff383c"
        onClicked: root.increaseClicked()
    }

    Connections {
        target: root

        function onDecreaseClicked() {
            console.log("decrease")
            root.temperature -= 0.5
        }

        function onIncreaseClicked() {
            console.log("increase")
            root.temperature += 0.5
        }
    }
}
