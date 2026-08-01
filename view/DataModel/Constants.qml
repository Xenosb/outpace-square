pragma Singleton

import QtQuick
import QtQuick.Studio.Application

QtObject {
    readonly property int width: 1280
    readonly property int height: 800

    property real resolutionScaler: 1

    readonly property int widthScaled: width * resolutionScaler
    readonly property int heightScaled: height * resolutionScaler

    property string relativeFontDirectory: "fonts"

    readonly property font font: Qt.font({
        family: Qt.application.font.family,
        pixelSize: Qt.application.font.pixelSize
    })

    readonly property font largeFont: Qt.font({
        family: Qt.application.font.family,
        pixelSize: Qt.application.font.pixelSize * 1.6
    })

    readonly property color backgroundColor: "#EAEAEA"


    property StudioApplication application: StudioApplication {
        fontPath: Qt.resolvedUrl("../OutpaceSquareContent/" + relativeFontDirectory)
    }
}
