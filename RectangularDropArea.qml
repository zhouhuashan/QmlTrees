import QtQuick 2.0

DropArea
{
    property alias normalBackgroundColor: dropRectangle.color
    property color droppingBackgroundColor
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
        {
            drop.accept(Qt.IgnoreAction)
        }
        else
        {
            drop.accept(Qt.IgnoreAction)
        }
        console.log("onDropped")
    }
    onEntered: {
        console.log("entered droparea")
        var format = drag.source.draggedDataType;
        var mimeTypeSupported = accetableMimeTypes.some(function(mimetype){
            return format.localeCompare(mimetype) === 0;
        });

        if(!mimeTypeSupported)
        {
            drag.source.turnOnRestrictedStateIndicator();
        }
        else
        {
            drag.source.turnOnAllowedStateIndicator();
        }
    }

    onExited: {
        drag.source.turnOnDraggingStateIndicator();
    }

    states: [
        State {
            when: containsDrag
            PropertyChanges {
                target: dropRectangle
                color: droppingBackgroundColor
            }
        }
    ]
}
