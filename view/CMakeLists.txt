qt_add_library(View STATIC)

add_subdirectory(Car)
add_subdirectory(CarControls)
add_subdirectory(CarHitbox)
add_subdirectory(DataModel)
add_subdirectory(Dock)
add_subdirectory(SelfieStick)
add_subdirectory(Sky)

target_link_libraries(
    View
    PRIVATE
        Car
        CarControls
        CarHitbox
        DataModel
        Dock
        SelfieStick
        Sky
)

qt6_add_qml_module(
    View
    URI "View"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        "App.qml"
        "CarView.ui.qml"
        "ReflectionControls.qml"
        "Service.qml"
)
