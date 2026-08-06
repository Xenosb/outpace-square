qt_add_library(Dock STATIC)

qt6_add_qml_module(
    Dock
    URI "Dock"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        "Dock.qml"
        "DockIconButton.qml"
        "ChevronButton.qml"
        "TemperatureDisplay.qml"
    RESOURCES
        "images/chevron.svg"
        "images/icon_apps.svg"
        "images/icon_car.svg"
        "images/icon_home.svg"
)
