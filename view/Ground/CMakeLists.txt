qt_add_library(Ground STATIC)

qt6_add_qml_module(
    Ground
    URI "Ground"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        "Ground.qml"
)
