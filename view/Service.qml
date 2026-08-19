import QtQuick

import DataModel

Item {
    id: root

    CarView {
        id: carView

        anchors.fill: parent
    }


    // -------------------------------------------------------
    // CarColorProperties — colors sent as "#AARRGGBB" strings
    // -------------------------------------------------------

    property string carPaintColor: ""
    onCarPaintColorChanged: {
        if (root.carPaintColor !== "")
            CarColorProperties.carPaintColor = root.carPaintColor
    }
}
