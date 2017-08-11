var itemComponent = null;
var draggedItem = null;
var clickedComponentMousePosition;
var positionInParent;

function startDrag(mouse, parentItem, clickedComponent)
{
    itemComponent = null;
    clickedComponentMousePosition = { x: mouse.x, y: mouse.y }
    console.debug("Clicked at: "+ clickedComponentMousePosition.x + " " + clickedComponentMousePosition.y);
    positionInParent = clickedComponent.mapToItem(parentItem, 0, 0);
    console.debug("Position In Parent: "+ positionInParent.x + " " + positionInParent.y);

    loadComponent(parentItem, dragArea, clickedComponent);
}

//Creation is split into two functions due to an asynchronous wait while possible external files are loaded.
function loadComponent(parentItem)
{
    if (itemComponent != null)
    {
        // component has been previously loaded
        createItem();
        return;
    }

    itemComponent = Qt.createComponent("../DraggableMouseArea.qml");
    //Depending on the content, it can be ready or error immediately
    if (itemComponent.status === Component.Loading)
    {
        component.statusChanged.connect(createItem);
    }
    else
    {
        createItem(parentItem);
    }
}

function createItem(parentItem)
{
    if (itemComponent.status === Component.Ready && draggedItem == null)
    {
        draggedItem = itemComponent.createObject(
            parentItem,
            {
                "x": positionInParent.x,
                "y": positionInParent.y,
                "color":Qt.lighter("red", 1.5),
                "isDraggable":true,

                visible: true
            }
        );

        var l = draggedItem.children.length;
        var ch0 = draggedItem.children[0];
        var ch1 = ch0.children[0];
        //for(var i = 0; i < draggedItem.children.length; ++i)
           //      console.log(draggedItem.childAt[i].type);
        draggedItem.width = 100;
        draggedItem.height = 40;
        draggedItem.contentBackroungColor = Qt.lighter("violet", 1.5);
        draggedItem.Drag.formats = "text/plain";
        draggedItem.Drag.mimeData = { "text/plain": "Hello Drag!" };
        draggedItem.Drag.supportedActions = Qt.CopyAction;
        draggedItem.Drag.dragType = Drag.Internal;
        //draggedItem.mouseArea.drag.target = draggedItem.rectangle;
        draggedItem.Drag.active = true;// draggedItem.mouseArea.drag.active;
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
    if (draggedItem == null)
        return;


    draggedItem.x = mouse.x + positionInParent.x - clickedComponentMousePosition.x;
    draggedItem.y = mouse.y + positionInParent.y - clickedComponentMousePosition.y;
    console.debug("mouse: "+ mouse.x + " " + mouse.y);
    //console.debug("coordinatesChanged: "+ draggedItem.x + " " + draggedItem.y);
    //console.debug("coordinatesChanged: "+ draggedItem.x + " " + draggedItem.y);
    //console.debug("mouse: "+ mouse.x + " " + mouse.y);
    //console.debug("posnInWindow: "+ posnInWindow.x + " " + posnInWindow.y);
    //console.debug("clickedComponentMousePosition: "+ clickedComponentMousePosition.x + " " + clickedComponentMousePosition.y);
    //console.debug("draggedItem: "+ draggedItem.x + " " + draggedItem.y);
}

function endDrag(mouse)
{
  if (draggedItem == null)
        return;

    var childRect = draggedItem.children[0];
    childRect.Drag.drop();
    //draggedItem.InternalRectangle.Drag.drop()
    console.log("Dragging ended at " + draggedItem.x + " " + draggedItem.y);
    draggedItem.destroy();
    draggedItem = null;

}
