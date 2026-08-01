
cmake_minimum_required(VERSION 3.21.1)

project(OutpaceSquare LANGUAGES CXX)

option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)
set(QML_IMPORT_PATH ${QT_QML_OUTPUT_DIRECTORY}
    CACHE STRING "Import paths for Qt Creator's code model"
    FORCE
)

find_package(
    Qt6 6.12
    REQUIRED COMPONENTS
        Core
        Gui
        Qml
        Quick
        Quick3D
        QuickTimeline
        Widgets
)

qt_standard_project_setup()

qt_policy(SET QTP0001 NEW)

add_subdirectory(src)
add_subdirectory(View)

qt_add_resources(
    ${CMAKE_PROJECT_NAME} "configuration"
    PREFIX "/"
    FILES
        view/qtquickcontrols2.conf
)

include(cmake/qmlcomponents.cmake)

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
            QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
    )
endif()

qt_finalize_executable(${CMAKE_PROJECT_NAME})
