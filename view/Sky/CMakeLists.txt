qt_add_library(Sky STATIC)

option(ADVANCED_SKY "Use dynamic sky" TRUE)

target_link_libraries(
    Sky
    PRIVATE
        Qt::Quick3D
)

if(ADVANCED_SKY AND Qt6_VERSION VERSION_GREATER_EQUAL 6.12.0)
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

    qt6_add_qml_module(
        Sky
        URI "Sky"
        VERSION 1.0
        RESOURCE_PREFIX "/qt/qml"
        QML_FILES
            "legacy/SkyEnvironment.qml"
        RESOURCES
            "legacy/maps/morning_sky.jpg"
    )
endif()
