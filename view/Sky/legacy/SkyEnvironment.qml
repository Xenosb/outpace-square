import QtQuick3D

SceneEnvironment {
    id: root

    property Node skyLight

    backgroundMode: SceneEnvironment.SkyBox

    lightProbe: Texture {
        source: "legacy/maps/MorningSkyHDRI014B_2K_TONEMAPPED.jpg"
        mappingMode: Texture.Environment
    }
}
