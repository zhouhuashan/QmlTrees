import QtQuick 2.0

 Rectangle {
    id:dragIndicator
    property var draggedData
    property var draggedDataType

    property alias text:rectangleText.text
    property alias restricted:restrictedId.visible
    height:48
    width:190
    opacity:0.7
    color:'brown'
    border.color: '#ffffff80'
    border.width:2

    Rectangle
    {
        id:restrictedId
        width:32
        height: 32
        color: 'green'
        visible: false
    }
    Text {
        id:rectangleText
        anchors.centerIn: parent
        text:""
        color:"black"
        font.pointSize: 12
        font.bold: true
    }
    Component.onCompleted: {
        if(draggedData !== undefined)
            text = JSON.stringify(draggedData);
    }
 }
