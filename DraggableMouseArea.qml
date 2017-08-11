import QtQuick 2.4

import "scripts/itemcreation.js" as Code

MouseArea {
    id:dragArea
    property bool isDraggable:false
    property bool held: false
    property alias contentBackroungColor:content.color
    property alias internalRectangle:content
    objectName: "dragArea"
    anchors { left: parent.left; right: parent.right }
    height: content.height
    drag.target: (held && isDraggable) ? content : undefined

    Rectangle {
        id: content
        objectName: "content"
        color: (dragArea.held && dragArea.isDraggable) ? "lightsteelblue" : '#df3322'
        border.width: 1
        anchors {
            horizontalCenter: dragArea.horizontalCenter
            verticalCenter: dragArea.verticalCenter
        }
        width: dragArea.width
        height:40
        Drag.active: dragArea.drag.active
        Drag.mimeData: {"text/plain": "Copied text" }
        Text {
            text: styleData.value
        }

        Drag.dragType: Drag.Internal
        Drag.supportedActions: Qt.CopyAction
        Drag.hotSpot {
            x: content.width / 2
            y: content.height / 2
        }
    }
    onReleased: {
        held = false
        console.log("held:", held)
        Code.endDrag(mouse)
        //parent.Drag.drop()
        content.parent = content.Drag.target !== null ? content.Drag.target : parent
        content.Drag.drop()
    }
    onPressAndHold: {
        held = true
        //content.Drad.start();
        console.log("held:", held)
        Code.startDrag(mouse, parent.parentWhenItemBeingDragged, content)
    }
    onPressed: {
    }

    onPositionChanged: {
            Code.continueDrag(mouse);
    }

    states: [
        State {
            when: held && isDraggable
            name: "draggingState"

            ParentChange {
                target: content
                parent: parentWhenItemBeingDragged
            }
            PropertyChanges {
                target: content
                opacity: 0.3
            }

            AnchorChanges{
                target:content
                anchors.horizontalCenter: undefined;
                anchors.verticalCenter: undefined
            }
        }
    ]
}
