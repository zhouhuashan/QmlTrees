import QtQuick 2.0

Item {
    id: draggableDelegateItem
    objectName: "draggableDelegateItem"

    property alias held:draggableMouseArea.held
    property alias isDraggable:draggableMouseArea.isDraggable

    property color baseColor:'orange'
    property Item parentWhenItemBeingDragged

    DraggableMouseArea
    {
        id:draggableMouseArea
    }
}
