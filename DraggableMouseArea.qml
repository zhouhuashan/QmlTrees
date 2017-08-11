import QtQuick 2.4

import "scripts/itemcreation.js" as Code

MouseArea {
    id:dragArea
    objectName: "dragArea"

    property bool held: false
    property color pressedBackroundColor:'lightsteelblue'
    property color normalBackgroundColor:'#df3322'

    property alias internalRectangle:content
    property Item parentWhenItemBeingDragged

    anchors { left: parent.left; right: parent.right }
    height: content.height
    //drag.target: held ? content : undefined

    Rectangle {
        id: content
        objectName: "content"

        color: dragArea.held ? dragArea.pressedBackroundColor:dragArea.normalBackgroundColor
        border.width: 1
        anchors {
            horizontalCenter: dragArea.horizontalCenter
            verticalCenter: dragArea.verticalCenter
        }
        width: dragArea.width
        height:40
        Drag.active: dragArea.drag.active
        Text {
            id:rectangleText
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
        console.log("Released")
        Code.endDrag(mouse)
        content.parent = content.Drag.target !== null ? content.Drag.target : parent
        content.Drag.drop()
    }

    onPressed: {
        held = true
        console.log("Pressed")
        Code.startDrag(mouse,
                       parentWhenItemBeingDragged,
                       content,
                       [styleData.value, "text/plain"])
    }

    onPositionChanged: {
        Code.continueDrag(mouse);
    }

    states: [
        State {
            when: held
            name: "draggingState"

            ParentChange {
               // target: content
               // parent: parentWhenItemBeingDragged
            }

            PropertyChanges {
                target: content
                color:pressedBackroundColor
            }

            AnchorChanges{
                target:content
                anchors.horizontalCenter: undefined;
                anchors.verticalCenter: undefined
            }
        }
    ]
}
