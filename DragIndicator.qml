import QtQuick 2.0

 Rectangle {
    id:dragIndicator
    property var draggedData
    property var draggedDataType

    property alias text:rectangleText.text

    function turnOnRestrictedStateIndicator()
    {
        restrictedStateRectangleId.visible = true;
        allowedStateRectangleId.visible = false;
        draggingStateRectangleId.visible = false;
    }

    function turnOnAllowedStateIndicator()
    {
        restrictedStateRectangleId.visible = false;
        allowedStateRectangleId.visible = true;
        draggingStateRectangleId.visible = false;
    }

    function turnOnDraggingStateIndicator()
    {
        restrictedStateRectangleId.visible = false;
        allowedStateRectangleId.visible = false;
        draggingStateRectangleId.visible = true;
    }

    Rectangle
    {
        id:restrictedStateRectangleId
        width:32
        height: 32
        color: '#610B21'
        visible: false
    }

    Rectangle
    {
        id:allowedStateRectangleId
        width:32
        height: 32
        color: '#58FA58'
        visible: false
    }

    Rectangle
    {
        id:draggingStateRectangleId
        width:32
        height: 32
        color: '#D8D8D8'
        visible: false
    }

    Text {
        id:rectangleText
        anchors.centerIn: parent
        color:"black"
        font.pointSize: 12
        font.bold: true
    }
    Component.onCompleted: {
        if(draggedData !== undefined)
            text = JSON.stringify(draggedData);
    }
 }
