/****************************************************************************
**
** Copyright 2019, 2021-2022 NXP
**
** SPDX-License-Identifier: BSD-2-Clause
**
****************************************************************************/

#include "Demo.h"

Demo::Demo(const QString &name, const QString &firstmenu, const QString &secondmenu, const QString &executable, const QString &source, const QString &icon, const QString &screenshot,const QString &compatible,
           const QString &description, const QString &id) : m_name(name), m_firstmenu(firstmenu), m_secondmenu(secondmenu), m_executable(executable), m_source(source), m_icon(icon), m_screenshot(screenshot), m_compatible(compatible), m_description(description), m_id(id)
{

}

QString Demo::name() const
{
    return m_name;
}

QString Demo::firstmenu() const
{
    return m_firstmenu;
}

QString Demo::secondmenu() const
{
    return m_secondmenu;
}

QString Demo::executable() const
{
    return m_executable;
}

QString Demo::source() const
{
    return m_source;
}

QString Demo::icon() const
{
    return m_icon;
}

QString Demo::screenshot() const
{
    return m_screenshot;
}

QString Demo::compatible() const
{
    return m_compatible;
}

QString Demo::description() const
{
    return m_description;
}

QString Demo::id() const
{
    return m_id;
}


DemoModel::DemoModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

void DemoModel::remove()
{
    int a = rowCount();
    if (rowCount() <= 0)
        return;

    for (int i = 0; i < a; i++){
        emit beginRemoveRows(QModelIndex(), 0, 0);
        m_demos.removeAt(0);
        emit endRemoveRows();
        emit countChanged(m_demos.count());
    }
}

void DemoModel::addDemo(const Demo &demo)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_demos << demo;
    endInsertRows();
}

int DemoModel::rowCount(const QModelIndex & parent) const
{
    Q_UNUSED(parent);
    return m_demos.count();
}

QList<Demo> DemoModel::demoData(const QModelIndex & parent) const
{
    Q_UNUSED(parent);
    return m_demos;
}

QVariant DemoModel::data(const QModelIndex & index, int role) const
{
    if (index.row() < 0 || index.row() >= m_demos.count())
        return QVariant();

    const Demo &demo = m_demos[index.row()];
    if (role == NameRole)
        return demo.name();
    else if (role == FirstmenuRole)
        return demo.firstmenu();
    else if (role == SecondmenuRole)
        return demo.secondmenu();
    else if (role == ExecutableRole)
        return demo.executable();
    else if (role == SourceRole)
        return demo.source();
    else if (role == IconRole)
        return demo.icon();
    else if (role == ScreenshotRole)
        return demo.screenshot();
    else if (role == CompatibleRole)
        return demo.compatible();
    else if (role == DescriptionRole)
        return demo.description();
    return QVariant();
}

QHash<int, QByteArray> DemoModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[FirstmenuRole] = "firstmenu";
    roles[SecondmenuRole] = "secondmenu";
    roles[ExecutableRole] = "executable";
    roles[SourceRole] = "source";
    roles[IconRole] = "icon";
    roles[ScreenshotRole] = "screenshot";
    roles[CompatibleRole] = "compatible";
    roles[DescriptionRole] = "description";
    return roles;
}
