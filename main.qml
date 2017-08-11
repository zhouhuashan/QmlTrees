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

            DraggableTreeView
            {
                model: MyTreeModel
            }

            RectangularDropArea
            {
                id:dropArea
                objectName: "dropArea"
                width: 300
                height: 300
                backgroundColor: '#30aa66'
                accetableMimeTypes: ["text/plain", "text/html"]
            }


        }


    }
}
