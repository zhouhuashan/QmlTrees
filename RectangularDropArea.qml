import QtQuick 2.0

DropArea
{
    property alias backgroundColor: dropRectangle.color
    property var accetableMimeTypes:[]
    Rectangle{
        id: dropRectangle
        objectName: "dropRectangle"
        color: backgroundColor
        anchors.fill: parent
    }

    onDropped: {
        var format = drop.source.draggedDataType;
        var ar = accetableMimeTypes.filter(function(mimetype){
            return format.localeCompare(mimetype) === 0;
        });
        if (ar.length < 1)
            drop.accept(Qt.IgnoreAction)
        else
            drop.accept(Qt.IgnoreAction)
        console.log("onDropped")
    }
    onEntered: {
        console.log("entered droparea")
        var format = drag.source.draggedDataType;
        var mimeTypeSupported = accetableMimeTypes.some(function(mimetype){
            return format.localeCompare(mimetype) === 0;
        });

        drag.source.restricted = !mimeTypeSupported;

    }

    onExited: {
        drag.source.restricted = false
    }
    states: [
        State {
            when: containsDrag
            PropertyChanges {
                target: dropRectangle
                color: "grey"
            }
        }
    ]
}
