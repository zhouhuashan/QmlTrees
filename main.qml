import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.5

ApplicationWindow {
    visible: true
    id:root
    width: 640
    height: 480
    title: qsTr("Dragging elements between trees example")
    color: 'black'
    Rectangle
    {
        objectName: "mainApplicationRectangle"
        width: parent.width - 10
        height: parent.height - 10
        anchors.centerIn: parent
        color: 'cyan'
        id: rootRectangle
        Row
        {
            height: parent.height - 10
            anchors.centerIn: parent
            width: parent.width - 10

            TreeView
            {
                id: sourceTreeView
                height: parent.height

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
                    baseColor: 'orange'
                    parentWhenItemBeingDragged: rootRectangle
                }
            }

                DropArea
                {
                    id:dropArea
                    objectName: "dropArea"
                    width: 300; height: 300
                    Rectangle{
                        color: 'blue'
                        anchors.fill: parent
                        id: dropRectangle
                        objectName: "dropRectangle"
                        width: 300
                        height: 300
                    }

                    onDropped: {
                        var txt = drop.source.draggedData;
                        var format = drop.source.draggedDataType;
                        if (format.localeCompare("plaint/text"))
                            drop.accept(Qt.IgnoreAction)


                        console.log("dropped into dest ", txt)
                    }
                    onEntered: {
                        console.log("entered dest")
                        var format = drag.source.draggedDataType;
                        var stringAreTheSame = format.localeCompare("text/plai3n") === 0;
                        drag.source.restricted = !stringAreTheSame;

                    }

                    onExited: {
                        drag.source.restricted = false
                    }
                    states: [
                        State {
                            when: dropArea.containsDrag
                            PropertyChanges {
                                target: dropRectangle
                                color: "grey"
                            }
                        }
                    ]
                }


        }


    }
}
