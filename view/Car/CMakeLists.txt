qt_add_library(Car STATIC)

qt6_add_qml_module(
    Car
    URI "Car"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        "Car.qml"
        "ReflectionCar.qml"
        "ReflectionFloor.qml"
    RESOURCES
        "_importdata.json"
        "shaders/reflectioncar.frag"
        "shaders/reflectioncar.vert"
        "shaders/reflectionfloor.frag"
        "maps/taillight_bump.png"
        "maps/door_panel_color.png"
        "maps/seat_color.png"
        "maps/tire_color.png"
        "maps/tire_normal.png"
        "maps/brake_disc_normal.png"
        "meshes/body_shell_mesh.mesh"
        "meshes/brake_caliper_front_left_mesh.mesh"
        "meshes/brake_caliper_front_right_mesh.mesh"
        "meshes/brake_caliper_rear_left_mesh.mesh"
        "meshes/brake_caliper_rear_right_mesh.mesh"
        "meshes/door_front_left_mesh.mesh"
        "meshes/door_front_right_mesh.mesh"
        "meshes/door_rear_left_mesh.mesh"
        "meshes/door_rear_right_mesh.mesh"
        "meshes/exterior_glass_mesh.mesh"
        "meshes/seats_mesh.mesh"
        "meshes/tailgate_mesh.mesh"
        "meshes/tire_front_mesh.mesh"
        "meshes/tire_rear_mesh.mesh"
        "meshes/window_front_left_mesh.mesh"
        "meshes/window_front_right_mesh.mesh"
        "meshes/window_rear_left_mesh.mesh"
        "meshes/window_rear_right_mesh.mesh"
)
