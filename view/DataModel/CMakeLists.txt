
set_source_files_properties(
    CarColorProperties.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(
    CarModelProperties.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(
    Constants.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

set_source_files_properties(
    EnvironmentProperties.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE true
)

qt_add_library(DataModel STATIC)

set(QML_FILES
    "CarColorProperties.qml"
    "CarModelProperties.qml"
    "Constants.qml"
    "EnvironmentProperties.qml"
)

qt6_add_qml_module(
    DataModel
    URI "DataModel"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        ${QML_FILES}
)
