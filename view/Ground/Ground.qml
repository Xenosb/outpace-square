import QtQuick3D

Model {
    id: root

    source: "#Cylinder"

    y: -63

    scale.x: 30
    scale.y: 0
    scale.z: 30

    materials: PrincipledMaterial {
        baseColor: "#d8d8d8"
        roughness: 0.9
    }
}
