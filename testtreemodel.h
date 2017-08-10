#ifndef TESTTREEMODEL_H
#define TESTTREEMODEL_H

#include <QAbstractItemModel>
#include <map>
#include "treeitem.h"

class TestTreeModel: public QAbstractItemModel
{
    Q_OBJECT

    TreeItem *m_rootItem;
    std::multimap<QString, QString> m_data;

    void setupModel();
public:
    explicit TestTreeModel(std::multimap<QString, QString> data, QObject *parent = nullptr);
    ~TestTreeModel();

    Q_INVOKABLE virtual QModelIndex index(int row, int column,
                              const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE virtual QModelIndex parent(const QModelIndex &index) const override;

    Q_INVOKABLE virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE virtual int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    Q_INVOKABLE virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int,QByteArray> roleNames() const override;

    TreeItem *itemForIndex(const QModelIndex &index) const;

    Qt::ItemFlags flags(const QModelIndex &index) const;

    Qt::DropActions supportedDragActions() const
    { return Qt::MoveAction|Qt::CopyAction; }
    Qt::DropActions supportedDropActions() const
    { return Qt::MoveAction|Qt::CopyAction; }
};

#endif // TESTTREEMODEL_H
