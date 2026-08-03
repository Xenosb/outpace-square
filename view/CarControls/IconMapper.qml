import QtQuick
import QtQuick3D

Node {
    id: root

    required property View3D view
    property var nodesItemsMap: []
    property Model hitbox

    Connections {
        target: view.camera
        ignoreUnknownSignals: true
        function onScenePositionChanged() {
            calcTimer.start();
        }
        function onSceneRotationChanged() {
            calcTimer.start();
        }
        function onFieldOfViewChanged() {
            calcTimer.start();
        }
    }

    Connections {
        target: hitbox
        ignoreUnknownSignals: true
        function onScenePositionChanged() {
            calcTimer.start();
        }
        function onSceneRotationChanged() {
            calcTimer.start();
        }
    }

    Timer {
        id: calcTimer
        interval: 0
        onTriggered: calculate()
    }

    Repeater3D {
        id: models
        model: root.nodesItemsMap.map(a => a[0])
        delegate: Model {
            source: "#Cube"
            scale: Qt.vector3d(0.5, 0.5, 0.5)
            parent: modelData.parent
            position: modelData.position
            layers: parent.layers
            pickable: true
        }
    }

    function calculate() {
        for (let i = 0; i < root.nodesItemsMap.length; ++i) {
            const node = root.nodesItemsMap[i][0];
            const item = root.nodesItemsMap[i][1];
            const pickResult = view.rayPick(view.camera.scenePosition, (node.scenePosition.minus(view.camera.scenePosition)).normalized());

            if (pickResult.objectHit === models.objectAt(i)) {
                const mapped = view.camera.mapToViewport(node.scenePosition);
                item.x = mapped.x * view.width;
                item.y = mapped.y * view.height;
                item.opacity = 1;
            } else {
                item.opacity = 0;
            }
        }
    }
}
