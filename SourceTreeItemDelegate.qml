import QtQuick 2.0
import "scripts/itemcreation.js" as Code
Item {
    property color baseColor:'orange'

    property Item parentWhenItemBeingDragged


    id: item
    objectName: "draggableItem"

    MouseArea {
        id:dragArea
            property bool held: false
        objectName: "dragArea"
        anchors { left: parent.left; right: parent.right }
        height: content.height
        drag.target: held ? content : undefined

        Rectangle {
            id: content
            objectName: "content"
            color: dragArea.held ? "lightsteelblue" : baseColor
            border.width: 1
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            width: dragArea.width
            height:40
            Drag.active: dragArea.drag.active

            Text {
                text: styleData.value
            }
            Drag.mimeData: { "text/plain": "Hello" }
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
            // Code.endDrag(mouse)
            //parent.Drag.drop()
            parent = content.Drag.target !== null ? content.Drag.target : item
            content.Drag.drop()
        }
        onPressAndHold: {
            held = true
            console.log("held:", held)
        }
        onPressed: {
        }

        onPositionChanged: {
                //Code.continueDrag(mouse);
        }

    }

    states: [
        State {
            when: dragArea.held
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
