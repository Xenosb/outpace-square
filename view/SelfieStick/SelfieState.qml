import QtQml
import QtQuick
import QtQuick3D

QtObject {
    property vector3d rotation
    property real distance : 100
    property real fov : 13

    property real yawMarginLeft: Number.MAX_SAFE_INTEGER
    property real yawMarginRight: Number.MAX_SAFE_INTEGER
    property real yawMaxOvershoot: 0

    property real rollMarginTop: 89
    property real rollMarginBottom: 89
    property real rollMaxOvershoot: 0

    required property Node lookAtNode
}
