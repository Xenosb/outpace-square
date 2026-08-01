pragma Singleton

import QtQuick

Item {
    // ======================================================
    // Car Paint Color
    // ======================================================

    property color carPaintColor: carPaintColors[5] // AmethystGray

    enum CarPaintColorEnum {
        DiamantNoir,
        EigerGrey,
        NebulaGrey,
        BatumiGold,
        AmethystGrey,
        MidnightBlue,
        Count
    }

    readonly property var carPaintColorNames: [
        "DiamantNoir",
        "EigerGrey",
        "NebulaGrey",
        "BatumiGold",
        "AmethystGrey",
        "MidnightBlue"
    ]

    readonly property var carPaintColors: [
        "#000000",
        "#ffffff",
        "#9A9A9A",
        "#F4C589",
        "#A34624",
        "#3D4967"
    ]
}
