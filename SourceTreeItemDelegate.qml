import QtQuick 2.0
import "scripts/itemcreation.js" as Code
Item {
    property color baseColor:'orange'
    property bool copyable:true
    property alias mouseArea: itemMouseArea
    property alias rectangle: contentItemWrapper
    property Rectangle draggedItemParent
    property Item contentPresenterItem
    id: item

    width:contentItem.width
    height:contentItem.height

    onContentPresenterItemChanged: {
        contentPresenterItem.parent = contentItemWrapper;
    }


    Rectangle {
            id: contentItemWrapper
            color:baseColor
            anchors.fill: parent
            Drag.active: itemMouseArea.drag.active
            Drag.hotSpot {
                x: contentPresenterItem.width / 2
                y: contentPresenterItem.height / 2
            }
            MouseArea {
                id:itemMouseArea
                anchors.fill: parent
                drag.target: contentItemWrapper
            }
    }
//    Rectangle{
//        id: itemRectangle
//        color:baseColor
//        width:parent.width - 10
//        height: parent.height - 2
//        anchors.fill: parent
//        Drag.active: itemMouseArea.drag.active
//        Drag.hotSpot {
//            x: 0
//            y: 0
//        }
//        Text {
//            anchors.verticalCenter: parent.verticalCenter
//            color: styleData.textColor
//            elide: styleData.elideMode
//            text: styleData.value
//        }
//        onPressed: {
//            if (copyable)
//            {

//                //Code.startDrag(mouse, root, item);
//            }
//        }

//        onReleased: {
//            if (copyable)
//            {
//                //Code.endDrag(mouse);
//            }
//        }
//        onPositionChanged: {
//            if (copyable)
//            {
//                //Code.continueDrag(mouse);
//            }
//        }
    //}

    states: [
            State {
                when: itemMouseArea.drag.active
                name: "dragging"

                ParentChange {
                    target: contentItemWrapper
                    parent: draggedItemParent
                }
                PropertyChanges {
                    target: contentItemWrapper
                    opacity: 0.5
                    anchors.fill: undefined
                    width: 14
                    height: 14
                }


            }
    ]
}
