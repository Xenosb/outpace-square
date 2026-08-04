import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import DataModel

Pane {
    id: root

    opacity: 0.85

    ColumnLayout {
        spacing: 0

        RowLayout {
            Layout.fillWidth: true

            Label {
                text: "Reflection"
                font.bold: true
                Layout.fillWidth: true
            }

            Switch {
                checked: EnvironmentProperties.reflectionVisible
                onToggled: EnvironmentProperties.reflectionVisible = checked
            }
        }

        Label {
            text: "Transmission: " + EnvironmentProperties.reflectionGroundTransmission.toFixed(2)
        }

        Slider {
            Layout.fillWidth: true

            from: 0
            to: 1
            value: EnvironmentProperties.reflectionGroundTransmission
            onMoved: EnvironmentProperties.reflectionGroundTransmission = value
        }

        Label {
            text: "Fade end Y: " + EnvironmentProperties.reflectionFadeEndY.toFixed(0)
        }

        Slider {
            Layout.fillWidth: true

            from: -400
            to: EnvironmentProperties.reflectionPlaneY - 1
            value: EnvironmentProperties.reflectionFadeEndY
            onMoved: EnvironmentProperties.reflectionFadeEndY = value
        }

        Label {
            text: "Plane Y: " + EnvironmentProperties.reflectionPlaneY.toFixed(1)
        }

        Slider {
            Layout.fillWidth: true

            from: -100
            to: -30
            value: EnvironmentProperties.reflectionPlaneY
            onMoved: EnvironmentProperties.reflectionPlaneY = value
        }

        Label {
            text: "Highlight strength: " + EnvironmentProperties.reflectionFloorHighlightStrength.toFixed(2)
        }

        Slider {
            Layout.fillWidth: true

            from: 0
            to: 2
            value: EnvironmentProperties.reflectionFloorHighlightStrength
            onMoved: EnvironmentProperties.reflectionFloorHighlightStrength = value
        }

        Label {
            text: "Highlight radius: " + EnvironmentProperties.reflectionFloorHighlightOuterRadius.toFixed(0)
        }

        Slider {
            Layout.fillWidth: true

            from: 200
            to: 2500
            value: EnvironmentProperties.reflectionFloorHighlightOuterRadius
            onMoved: EnvironmentProperties.reflectionFloorHighlightOuterRadius = value
        }

        Label {
            text: "Sky reflection: " + EnvironmentProperties.reflectionFloorSkyStrength.toFixed(2)
        }

        Slider {
            Layout.fillWidth: true

            from: 0
            to: 1.5
            value: EnvironmentProperties.reflectionFloorSkyStrength
            onMoved: EnvironmentProperties.reflectionFloorSkyStrength = value
        }

        Label {
            text: "Emissive falloff: " + EnvironmentProperties.reflectionEmissiveFalloff.toFixed(2)
        }

        Slider {
            Layout.fillWidth: true

            from: 0.5
            to: 6
            value: EnvironmentProperties.reflectionEmissiveFalloff
            onMoved: EnvironmentProperties.reflectionEmissiveFalloff = value
        }
    }
}
