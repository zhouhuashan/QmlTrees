import QtQuick 2.0

 Rectangle {
    id:dragIndicator
    property var draggedData
    property var draggedDataType

    property alias text:rectangleText.text
    property alias backgroundImage: backroundImageId.source


    function turnOnRestrictedStateIndicator()
    {
        restrictedStateComponentId.visible = true;
        allowedStateComponentId.visible = false;
        draggingStateComponentId.visible = false;
    }

    function turnOnAllowedStateIndicator()
    {
        restrictedStateComponentId.visible = false;
        allowedStateComponentId.visible = true;
        draggingStateComponentId.visible = false;
    }

    function turnOnDraggingStateIndicator()
    {
        restrictedStateComponentId.visible = false;
        allowedStateComponentId.visible = false;
        draggingStateComponentId.visible = true;
    }

    Image {
        id: backroundImageId
        opacity: 0.9
    }
    RestrictedStateComponent
    {
        id:restrictedStateComponentId
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }

    DraggingStateComponent
    {
      id:draggingStateComponentId
      anchors.bottom: parent.bottom
      anchors.right: parent.right
    }

    AllowedStateComponent
    {
        id:allowedStateComponentId
        anchors.bottom: parent.bottom
        anchors.right: parent.right
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
