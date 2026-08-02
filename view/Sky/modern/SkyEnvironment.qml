import QtQuick3D

import Sky

SceneEnvironment {
    id: root

    property Node skyLight

    backgroundMode: SceneEnvironment.SkyMaterial

    skyMaterial: AdvancedSky {
        skyLight: root.skyLight
    }
}
