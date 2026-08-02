qt_add_executable(
    ${CMAKE_PROJECT_NAME}
    MANUAL_FINALIZATION
        "main.cpp"
)

set_source_files_properties(
    "${CMAKE_SOURCE_DIR}/view/qtquickcontrols2.conf"
    PROPERTIES
        QT_RESOURCE_ALIAS "qtquickcontrols2.conf"
)

qt_add_resources(
    ${CMAKE_PROJECT_NAME} "configuration"
    PREFIX "/"
    FILES
        "${CMAKE_SOURCE_DIR}/view/qtquickcontrols2.conf"
)

include("${CMAKE_SOURCE_DIR}/cmake/qmlcomponents.cmake")

target_link_libraries(
    ${CMAKE_PROJECT_NAME}
    PRIVATE
        Qt::Core
        Qt::Gui
        Qt::Widgets
        Qt::Quick
        Qt::Qml
        Viewplugin
        DataModelplugin
)

if(CMAKE_SYSTEM_NAME STREQUAL "Android")
    find_package(
        Qt6 REQUIRED COMPONENTS
            AndroidAutomotiveService
    )

    qt_import_plugins(
        ${CMAKE_PROJECT_NAME}
        INCLUDE
            Qt6::QAndroidRaaSIntegrationPlugin
    )

    target_link_libraries(
        ${CMAKE_PROJECT_NAME}
        PRIVATE
            Qt6::AndroidAutomotiveService
    )

    set_target_properties(
        ${PROJECT_NAME}
        PROPERTIES
            QT_ANDROID_PACKAGE_NAME io.qt.demo.outpace.square
            QT_ANDROID_APP_NAME "Outpace Square"
            QT_ANDROID_VERSION_CODE "1"
            QT_ANDROID_VERSION_NAME "1.0"
            QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_SOURCE_DIR}/android"
    )
endif()

qt_finalize_executable(${CMAKE_PROJECT_NAME})
