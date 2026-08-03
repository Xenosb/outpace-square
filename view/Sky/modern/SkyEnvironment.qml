import QtQuick3D
import QtQuick3D.Helpers

import Sky

ExtendedSceneEnvironment {
    id: root

    property Node skyLight

    backgroundMode: SceneEnvironment.SkyMaterial

    skyMaterial: AdvancedSky {
        skyLight: root.skyLight
    }
}
