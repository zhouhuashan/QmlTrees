import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4

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
        anchors.topMargin: 7
    }

    style: TreeViewStyle {
        branchDelegate: Rectangle {
            width: 16
            height: 16
            color: styleData.isExpanded ? "green" : "#f38923"
        }
        frame: Rectangle {border {color: "blue"}}
    }

    itemDelegate: SourceTreeItemDelegate {
        parentWhenItemBeingDragged: rootRectangle
        pressedBackgroundColor: '#FAFAFA'
        normalBackgroundColor: '#E6E6E6'
        borderColor: '#A4A4A4'
        borderWidth:2
    }
}
