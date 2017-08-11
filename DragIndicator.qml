import QtQuick 2.0

 Rectangle {
    id:dragIndicator
    property var draggedData
    property var draggedDataType
    property alias text:rectangleText.text
    property alias restricted:restrictedId.visible
    width:30
    height:40
    color:'brown'
    Rectangle
    {
       id:restrictedId
     width:10
     height: 10
     color: 'green'
     visible: false
    }
        Text {
            id:rectangleText
            x:4
            y:5
            anchors.fill: parent
            text:""
            color:"black"
            font.pointSize: 12; font.bold: true
        }
    Component.onCompleted: {
        if(draggedData !== undefined)
            text = JSON.stringify(draggedData);
    }
 }
