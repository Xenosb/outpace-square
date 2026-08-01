import QtQuick
import QtQuick3D

import DataModel

Model {
    id: root

    source: "#Cylinder"

    y: -63

    scale.x: 30
    scale.y: 0
    scale.z: 30

    materials: AsphaltMaterial {
        baseColor: EnvironmentProperties.dayNightMode ? "#141414" : "#2a2a2a"

        Behavior on baseColor {
            ColorAnimation { duration: 600 }
        }
    }
}
