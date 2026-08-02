import QtQuick3D
import QtQuick3D.Helpers

import Sky

ExtendedSceneEnvironment {
    id: root

    property Node skyLight

    backgroundMode: SceneEnvironment.SkyMaterial
    ssrEnabled: true
    ssrThickness: 100
    ssrMaxSteps: 100
    ditheringEnabled: true

    skyMaterial: AdvancedSky {
        skyLight: root.skyLight
    }
}
