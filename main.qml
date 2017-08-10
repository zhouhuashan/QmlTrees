import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.5

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Dragging elements between trees example")
    color: 'black'
    Rectangle
    {
        width:parent.width - 10
        height: parent.height - 10
        anchors.centerIn: parent
        color: 'cyan'
        id:root
        Row
        {
            height:parent.height - 10
            anchors.centerIn: parent
            width:parent.width - 10
            spacing:40
            TreeView
            {
                id: sourceTreeView
                height:parent.height

                TableViewColumn {
                        title: "Drag items from here!"
                        role: "ItemSummary"
                }

                model: MyTreeModel

                rowDelegate: Rectangle {
                   height: 40
                   color: 'red'
                }

                itemDelegate: SourceTreeItemDelegate {
                    baseColor:'orange'
                    draggedItemParent: root
                    height:40
                    width: 100
                    contentPresenterItem: Rectangle {
                        height: parent.height
                        width: parent.width - 10
                        color: "yellow"
                        Text{text:model?model.ItemSummary:""}
                    }
                }
            }
            Rectangle{
                color:'blue'
                width:300
                height:300
                DropArea
                {
                    id:dropArea
                    height:parent.height
                    width:parent.width
                    onDropped: {
                        drop.acceptProposedAction()
                        var txt = drop.text;
                        var fmts = JSON.stringify(drop.formats);
                        console.log("dropped into dest")
                    }
                    onEntered: {
                        console.log("entered dest")
                    }

                    property int dropIndex

//                    Rectangle {
//                        id: dropIndicator
//                        anchors {
//                            left: parent.left
//                            right: parent.right
//                            top: dropIndex === 0 ? parent.verticalCenter : undefined
//                            bottom: dropIndex === 0 ? undefined : parent.verticalCenter
//                        }
//                        height: 2
//                        opacity: dropArea.containsDrag ? 0.8 : 0.0
//                        color: "red"
//                    }
                }
            }

        }


    }
}
