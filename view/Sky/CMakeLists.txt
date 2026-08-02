qt_add_library(Sky STATIC)

target_link_libraries(
    Sky
    PRIVATE
        Qt::Quick3D
        Qt::Concurrent
)

qt6_add_qml_module(
    Sky
    URI "Sky"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        "AdvancedSky.qml"
    SOURCES
        "cloudnoisetexturedata.h"
        "cloudnoisetexturedata.cpp"
    RESOURCES
        "advancedsky.frag"
        "skytexture.frag"
        "transmittance.frag"
)
