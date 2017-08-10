#include "treeitem.h"

TreeItem::TreeItem(const QString &data, TreeItem *parent)
{
    m_parentItem = parent;
    if (m_parentItem)
    {
        m_parentItem->appendChild(this);
    }
    m_itemData = data;
}

TreeItem::~TreeItem()
{
    qDeleteAll(m_childItems);
}

void TreeItem::appendChild(TreeItem *item)
{
    m_childItems.append(item);
}

int TreeItem::rowOfChild(TreeItem *child) const
{
    return m_childItems.indexOf(child);
}

TreeItem *TreeItem::childAt(int row) const
{
    return m_childItems.value(row);
}

int TreeItem::childCount() const
{
    return m_childItems.count();
}

int TreeItem::columnCount() const
{
    return m_itemData.count();
}

QString TreeItem::data() const
{
    return m_itemData;
}

TreeItem *TreeItem::parentItem()
{
    return m_parentItem;
}

int TreeItem::row() const
{
    if (m_parentItem)
        return m_parentItem->m_childItems.indexOf(const_cast<TreeItem*>(this));

    return 0;
}
