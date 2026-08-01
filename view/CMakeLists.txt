qt_add_library(View STATIC)

add_subdirectory(Car)
add_subdirectory(DataModel)

target_link_libraries(
    View
    PRIVATE
        Car
        DataModel
)

qt6_add_qml_module(
    View
    URI "View"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        "App.qml"
        "CarView.ui.qml"
        "Service.qml"
        "SelfieState.qml"
        "SelfieStick.qml"
)
