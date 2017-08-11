import QtQuick 2.0

Item {
    id: draggableDelegateItem
    objectName: "draggableDelegateItem"

    property alias held:draggableMouseArea.held
    property color baseColor:'orange'
    property Item parentWhenItemBeingDragged

    DraggableMouseArea
    {
        id:draggableMouseArea
        pressedBackroundColor: '#0080FF'
        normalBackgroundColor: '#0040FF'
        parentWhenItemBeingDragged:draggableDelegateItem.parentWhenItemBeingDragged
    }
}
