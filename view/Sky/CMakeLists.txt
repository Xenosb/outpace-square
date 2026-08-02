qt_add_library(Sky STATIC)

target_link_libraries(
    Sky
    PRIVATE
        Qt::Quick3D
)

# SkyMaterial (and the physically-based AdvancedSky built on top of it) only
# exists from Qt 6.12 onward. Earlier Qt versions fall back to a static HDRI
# skybox image in legacy/SkyEnvironment.qml. Both variants are aliased to the
# same resource path, "SkyEnvironment.qml", so qmldir and CarView.ui.qml
# never need to know which one is active.
if(Qt6_VERSION VERSION_GREATER_EQUAL 6.12.0)
    message("Sky: building AdvancedSky (SkyMaterial, Qt >= 6.12)")

    target_link_libraries(
        Sky
        PRIVATE
            Qt::Concurrent
    )

    target_include_directories(
        Sky
        PRIVATE
            modern
    )

    set_source_files_properties(
        modern/SkyEnvironment.qml
        PROPERTIES
            QT_RESOURCE_ALIAS "SkyEnvironment.qml"
    )

    qt6_add_qml_module(
        Sky
        URI "Sky"
        VERSION 1.0
        RESOURCE_PREFIX "/qt/qml"
        QML_FILES
            "modern/SkyEnvironment.qml"
            "modern/AdvancedSky.qml"
        SOURCES
            "modern/cloudnoisetexturedata.h"
            "modern/cloudnoisetexturedata.cpp"
        RESOURCES
            "modern/advancedsky.frag"
            "modern/skytexture.frag"
            "modern/transmittance.frag"
    )
else()
    message("Sky: building HDRI skybox fallback (Qt < 6.12)")

    set_source_files_properties(
        legacy/SkyEnvironment.qml
        PROPERTIES
            QT_RESOURCE_ALIAS "SkyEnvironment.qml"
    )

    qt6_add_qml_module(
        Sky
        URI "Sky"
        VERSION 1.0
        RESOURCE_PREFIX "/qt/qml"
        QML_FILES
            "legacy/SkyEnvironment.qml"
        RESOURCES
            "legacy/maps/MorningSkyHDRI014B_2K_TONEMAPPED.jpg"
    )
endif()
