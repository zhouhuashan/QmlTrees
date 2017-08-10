#include "testtreemodel.h"
#include <set>
#include <iterator>
#include <QMimeData>

int ColumnCount = 1;

TestTreeModel::TestTreeModel(std::multimap<QString, QString> data, QObject *parent)
    : QAbstractItemModel(parent), m_rootItem(nullptr), m_data(data)
{
    m_rootItem = new TreeItem();
    setupModel();
}

TestTreeModel::~TestTreeModel()
{
    delete m_rootItem;
}

QModelIndex TestTreeModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!m_rootItem || row < 0 || column < 0 || column >= ColumnCount
    || (parent.isValid() && parent.column() != 0))
    {
        return QModelIndex();
    }

    TreeItem *parentItem = itemForIndex(parent);
    Q_ASSERT(parentItem);
    if (TreeItem *item = parentItem->childAt(row))
    return createIndex(row, column, item);
    return QModelIndex();
}

QModelIndex TestTreeModel::parent(const QModelIndex &index) const
{
    if (!index.isValid())
        return QModelIndex();

    if (TreeItem *item = itemForIndex(index))
    {
        if (TreeItem *parentItem = item->getParent())
        {
            if (parentItem == m_rootItem)
                return QModelIndex();
            if (TreeItem *grandParentItem = parentItem->getParent())
            {
                int row = grandParentItem->rowOfChild(parentItem);
                return createIndex(row, 0, parentItem);
            }
        }
    }
    return QModelIndex();
}

int TestTreeModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid() && parent.column() != 0)
    {
        return 0;
    }
    TreeItem *parentItem = itemForIndex(parent);
    return parentItem ? parentItem->childCount() : 0;
}

QStringList TestTreeModel::mimeTypes() const
 {
     QStringList types;
     types << "text/plain";
     return types;
 }

bool TestTreeModel::dropMimeData(const QMimeData *data, Qt::DropAction action, int row, int column, const QModelIndex &parent)
{
    if (action == Qt::IgnoreAction)
        return true;

    if (!data->hasFormat("text/plain"))
        return false;

    if (column > 0)
        return false;


    int beginRow;

    if (row != -1)
        beginRow = row;

    else if (parent.isValid())
        beginRow = parent.row();

    else
        beginRow = rowCount(QModelIndex());
}

QMimeData *TestTreeModel::mimeData(const QModelIndexList &indexes) const
{
    QMimeData *mimeData = new QMimeData();
    QByteArray encodedData;

    QDataStream stream(&encodedData, QIODevice::WriteOnly);

    foreach (QModelIndex index, indexes) {
        if (index.isValid()) {
            QString text = data(index, Qt::DisplayRole).toString();
            stream << text;
        }
    }

    mimeData->setData("application/vnd.text.list", encodedData);
    return mimeData;
}

TreeItem *TestTreeModel::itemForIndex(const QModelIndex &index) const
{
    if (index.isValid())
    {
        if (TreeItem *item = static_cast<TreeItem*>(
            index.internalPointer()))
        return item;
    }
    return m_rootItem;
}

Qt::ItemFlags TestTreeModel::flags(const QModelIndex &index) const
{
    Qt::ItemFlags theFlags = QAbstractItemModel::flags(index);
    if (index.isValid())
    {
        theFlags |= Qt::ItemIsSelectable|Qt::ItemIsEnabled;
        Qt::ItemIsDragEnabled|Qt::ItemIsDropEnabled;
    }
    return theFlags;
}

int TestTreeModel::columnCount(const QModelIndex &parent) const
{
    return parent.isValid() && parent.column() != 0 ? 0 : ColumnCount;
}

QHash<int,QByteArray> TestTreeModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "ItemSummary";
    return roles;
}

QVariant TestTreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
            return QVariant();

    if (role != Qt::DisplayRole)
        return QVariant();

    TreeItem *item = static_cast<TreeItem*>(index.internalPointer());

    return item->data();//item->data(index.column());
}


void TestTreeModel::setupModel()
{
    std::set<QString> uniqueParentNames;
    for( std::multimap<QString, QString>::iterator it = m_data.begin(); it != m_data.end(); it = m_data.upper_bound(it->first))
    {
        uniqueParentNames.emplace(it->first);
    }

    for (auto& u : uniqueParentNames)
    {
        TreeItem *item = new TreeItem(u);
        std::pair<std::multimap<QString, QString>::iterator, std::multimap<QString, QString>::iterator> range = m_data.equal_range(u);
        for (auto i = range.first; i != range.second; ++i)
        {
            item->appendChild(new TreeItem(i->second));
        }
        m_rootItem->appendChild(item);
    }
}
