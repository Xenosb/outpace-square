import QtQuick
import QtQuick3D

Node {
    id: node

    property alias model: car_body_hitbox

    Model {
        id: car_body_hitbox

        objectName: "Car_body_hitbox"

        scale.x: 100
        scale.y: 100
        scale.z: 100

        source: "meshes/car_body_hitbox_mesh_mesh.mesh"
        pickable: true
        layers: node.layers
    }
}
