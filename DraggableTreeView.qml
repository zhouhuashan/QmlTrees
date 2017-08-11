import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.5

TreeView
{
    id: sourceTreeView
    height: parent.height

    TableViewColumn {
        title: "Drag items from here!"
        role: "ItemSummary"
    }

    rowDelegate: Rectangle {
        height: 40
        color: 'red'
    }

    itemDelegate: SourceTreeItemDelegate {
        baseColor: 'orange'
        parentWhenItemBeingDragged: rootRectangle
    }
}
