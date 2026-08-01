qt_add_library(Ground STATIC)

target_link_libraries(
    Ground
    PRIVATE
        DataModel
)

qt6_add_qml_module(
    Ground
    URI "Ground"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        "Ground.qml"
        "AsphaltMaterial.qml"
    RESOURCES
        "maps/asphalt_normal.png"
        "maps/asphalt_roughness.png"
        "maps/asphalt_opacity.png"
)
