
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
    Qt6 6.8
    REQUIRED COMPONENTS
        Concurrent
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

add_subdirectory(View)
add_subdirectory(src)
