qt_add_library(CarControls STATIC)

target_link_libraries(
    CarControls
    PRIVATE
        DataModel
)

qt6_add_qml_module(
    CarControls
    URI "CarControls"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        "CarControls.ui.qml"
        "CarControlIcon.ui.qml"
        "CarControlSelector.ui.qml"
        "CarControlMenu.ui.qml"
        "CarControlBackground.ui.qml"
        "CarSuspensionMenu.ui.qml"
        "IconMapper.qml"
        "SpringReturnSlider.qml"
    RESOURCES
        "images/CarControlIcons/IconBack.svg"
        "images/CarControlIcons/IconDoor.svg"
        "images/CarControlIcons/IconLightsHighBeam.svg"
        "images/CarControlIcons/IconLightsLowBeam.svg"
        "images/CarControlIcons/IconOff.svg"
        "images/CarControlIcons/IconSuspension.svg"
        "images/CarControlIcons/IconTrunkClose.svg"
        "images/CarControlIcons/IconTrunkOpen.svg"
        "images/CarControlIcons/IconWindow.svg"
        "images/CarControlIcons/IconWindowClose.svg"
        "images/CarControlIcons/IconWindowOpen.svg"
        "images/CarControlIcons/IconWindowVent.svg"
        "images/CarControlIcons/MenuSelected.png"
)
