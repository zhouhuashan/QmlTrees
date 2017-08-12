import QtQuick 2.0

Item
{
    id: draggableDelegateItem
    objectName: "draggableDelegateItem"

    property alias held:draggableMouseArea.held
    property int borderWidth
    property alias parentWhenItemBeingDragged:draggableMouseArea.parentWhenItemBeingDragged
    property alias pressedBackgroundColor:draggableMouseArea.pressedBackgroundColor
    property color normalBackgroundColor:draggableMouseArea.normalBackgroundColor
    property alias borderColor:draggableMouseArea.borderColor

    DraggableMouseArea
    {
        id:draggableMouseArea
        normalBackgroundColor: draggableDelegateItem.normalBackgroundColor
        borderWidth: draggableDelegateItem.borderWidth
    }
}
