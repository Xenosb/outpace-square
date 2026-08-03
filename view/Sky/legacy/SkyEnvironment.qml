import QtQuick3D
import QtQuick3D.Helpers

ExtendedSceneEnvironment {
    id: root

    property Node skyLight

    backgroundMode: SceneEnvironment.SkyBox

    lightProbe: Texture {
        source: "maps/morning_sky.jpg"
        mappingMode: Texture.Environment
    }
}
