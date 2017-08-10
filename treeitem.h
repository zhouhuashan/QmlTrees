#ifndef TREEITEM_H
#define TREEITEM_H

#include <QList>
#include <QVariant>

class TreeItem
{
    QList<TreeItem*> m_childItems;
    QString m_itemData;
    TreeItem *m_parentItem;
public:
    TreeItem(const QString &data=QString(), TreeItem *parent = nullptr);
    ~TreeItem();
    void appendChild(TreeItem *child);

    TreeItem* getParent() const { return m_parentItem; }
    TreeItem* childAt(int row) const;

    int childCount() const;
    int columnCount() const;
    int rowOfChild(TreeItem *child) const;

    QString data() const;
    int row() const;
    TreeItem* parentItem();
};

#endif // TREENODE_H
