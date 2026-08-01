if (${BUILD_QDS_COMPONENTS})
    message("Building designer components")

    set(QT_QML_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/qml")

    include(FetchContent)

    FetchContent_Declare(
        designstudio-components
        GIT_TAG qds-4.7
        GIT_REPOSITORY https://code.qt.io/qt-labs/qtquickdesigner-components.git
    )

    FetchContent_GetProperties(designstudio-components)
    FetchContent_MakeAvailable(designstudio-components)

    add_library(QtQuickDesignerComponents INTERFACE)
    target_link_libraries(QtQuickDesignerComponents INTERFACE
        QuickStudioApplicationplugin
        QuickStudioComponentsplugin
        QuickStudioEffectsplugin
        QuickStudioDesignEffectsplugin
        QuickStudioEventSimulatorplugin
        QuickStudioEventSystemplugin
        QuickStudioLogicHelperplugin
        QuickStudioUtilsplugin
    )

    target_link_libraries(
        ${CMAKE_PROJECT_NAME}
        PRIVATE
            QtQuickDesignerComponents
    )

    target_compile_definitions(
        ${CMAKE_PROJECT_NAME}
        PRIVATE
            BUILD_QDS_COMPONENTS=true
    )

endif()
