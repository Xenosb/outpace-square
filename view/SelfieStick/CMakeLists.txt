qt_add_library(SelfieStick STATIC)

qt6_add_qml_module(
    SelfieStick
    URI "SelfieStick"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        "SelfieStick.qml"
        "SelfieState.qml"
)
