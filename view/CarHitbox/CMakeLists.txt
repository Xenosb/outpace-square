qt_add_library(CarHitbox STATIC)

qt6_add_qml_module(
    CarHitbox
    URI "CarHitbox"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        "CarHitbox.qml"
    RESOURCES
        "meshes/car_body_hitbox_mesh_mesh.mesh"
)
