import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Effects

Control {
    id: root

    property list<var> menuModel
    property alias currentIndex : listView.currentIndex

    leftPadding: height / 2
    rightPadding: height / 2
    topPadding: 0
    bottomPadding: 0
    bottomInset: 0

    background: CarControlBackground { }
    contentItem: ListView {
        id: listView

        implicitWidth: Math.max(1, contentItem.childrenRect.width)
        implicitHeight: contentItem.childrenRect.height

        orientation: ListView.Horizontal
        boundsBehavior: ListView.StopAtBounds
        spacing: root.height / 4

        model: root.menuModel

        delegate: CarControlIcon {
            icon.source: modelData.icon
            text: modelData.label
            background: null
            onClicked: listView.currentIndex = index
        }

        highlight : Item {
            Image {
                id: highlight
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                source: "images/CarControlIcons/MenuSelected.png"
            }
        }
    }
}
