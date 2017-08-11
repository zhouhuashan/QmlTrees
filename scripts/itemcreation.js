var itemComponent = null;
var draggedItem = null;
var clickedComponentMousePosition;
var positionInParent;

function startDrag(mouse, parentItem, clickedComponent, mimeData)
{
    itemComponent = null;
    clickedComponentMousePosition = { x: mouse.x, y: mouse.y }
    console.debug("Clicked at: "+ clickedComponentMousePosition.x + " " + clickedComponentMousePosition.y);
    positionInParent = clickedComponent.mapToItem(parentItem, 0, 0);
    console.debug("Position In Parent: "+ positionInParent.x + " " + positionInParent.y);

    loadComponent(parentItem, mimeData);
}

//Creation is split into two functions due to an asynchronous wait while possible external files are loaded.
function loadComponent(parentItem, mimeData)
{
    if (itemComponent != null)
    {
        // component has been previously loaded
        createItem();
        return;
    }

    itemComponent = Qt.createComponent("../DragIndicator.qml");

    //Depending on the content, it can be ready or error immediately
    if (itemComponent.status === Component.Loading)
    {
        component.statusChanged.connect(createItem);
    }
    else
    {
        createItem(parentItem, mimeData);
    }
}

function createItem(parentItem, mimeData)
{
    if (itemComponent.status === Component.Ready && draggedItem == null)
    {
        draggedItem = itemComponent.createObject(
            parentItem,
            {
                x: positionInParent.x - 4,
                y: positionInParent.y - 4,
                text: mimeData[0]
            }
        );

        draggedItem.Drag.dragType = Drag.Internal
        draggedItem.Drag.supportedActions = Qt.CopyAction
        draggedItem.Drag.hotSpot.x = draggedItem.width / 2;
        draggedItem.Drag.hotSpot.y = draggedItem.height / 2;
        draggedItem.draggedData = mimeData[0];
        draggedItem.draggedDataType = mimeData[1]
        draggedItem.Drag.supportedActions = Qt.CopyAction;
        draggedItem.Drag.active = true;
        draggedItem.Drag.start();
    }
    else if (itemComponent.status === Component.Error) {
        draggedItem = null;
        console.log("error creating component");
        console.log(itemComponent.errorString());
    }
}

function continueDrag(mouse)
{
    if (draggedItem == null) return;

    draggedItem.x = mouse.x + positionInParent.x - clickedComponentMousePosition.x;
    draggedItem.y = mouse.y + positionInParent.y - clickedComponentMousePosition.y;
    console.debug("mouse: "+ mouse.x + " " + mouse.y);
}

function endDrag(mouse)
{
  if (draggedItem == null) return;

    draggedItem.Drag.drop();
    console.log("Dragging ended at " + draggedItem.x + " " + draggedItem.y);
    draggedItem.destroy();
    draggedItem = null;
}
