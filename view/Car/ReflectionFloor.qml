import QtQuick
import QtQuick3D

import DataModel

Model {
    id: floor

    source: "#Cylinder"

    y: EnvironmentProperties.reflectionPlaneY - 260

    scale.x: 40
    scale.y: 0
    scale.z: 40

    materials: CustomMaterial {
        objectName: "reflection_floor"

        sourceBlend: CustomMaterial.NoBlend
        destinationBlend: CustomMaterial.NoBlend
        sourceAlphaBlend: CustomMaterial.NoBlend
        destinationAlphaBlend: CustomMaterial.NoBlend
        cullMode: Material.BackFaceCulling
        shadingMode: CustomMaterial.Shaded
        vertexShader: "shaders/reflectioncar.vert"
        fragmentShader: "shaders/reflectionfloor.frag"

        property real groundPlaneY: EnvironmentProperties.reflectionPlaneY
        property color floorHighlightColor: EnvironmentProperties.reflectionFloorHighlightColor
        property color floorOuterColor: EnvironmentProperties.reflectionFloorOuterColor
        property real floorHighlightStrength: EnvironmentProperties.reflectionFloorHighlightStrength
        property real floorHighlightInnerRadius: EnvironmentProperties.reflectionFloorHighlightInnerRadius
        property real floorHighlightOuterRadius: EnvironmentProperties.reflectionFloorHighlightOuterRadius
        property real skyReflectionStrength: EnvironmentProperties.reflectionFloorSkyStrength
        property real skyReflectionBlur: EnvironmentProperties.reflectionFloorSkyBlur
        property TextureInput skyTexture: TextureInput {
            texture: Texture {
                source: "qrc:/qt/qml/Sky/legacy/maps/morning_sky.jpg"
                generateMipmaps: true
                mipFilter: Texture.Linear
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.ClampToEdge
            }
        }
    }
}
