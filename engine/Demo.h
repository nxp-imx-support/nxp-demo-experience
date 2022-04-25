/****************************************************************************
**
** Copyright 2019, 2021-2022 NXP
**
** SPDX-License-Identifier: BSD-2-Clause
**
****************************************************************************/

#ifndef DEMO_H
#define DEMO_H

#include <QObject>
#include <QAbstractListModel>
#include <QStringList>

class Demo
{
public:
    Demo(const QString &name, const QString &firstmenu, const QString &secondmenu, const QString &executable, const QString &source, const QString &icon,
         const QString &screenshot, const QString &compatible, const QString &description, const QString &id);

    QString name() const;
    QString firstmenu() const;
    QString secondmenu() const;
    QString executable() const;
    QString source() const;
    QString icon() const;
    QString screenshot() const;
    QString compatible() const;
    QString description() const;
    QString id() const;

private:

    QString m_name;
    QString m_firstmenu;
    QString m_secondmenu;
    QString m_executable;
    QString m_source;
    QString m_icon;
    QString m_screenshot;
    QString m_compatible;
    QString m_description;
    QString m_id;

};

class DemoModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum DemoRoles {
        NameRole = Qt::UserRole + 1,
        FirstmenuRole,
        SecondmenuRole,
        ExecutableRole,
        SourceRole,
        IconRole,
        ScreenshotRole,
        CompatibleRole,
        DescriptionRole
    };

    DemoModel(QObject *parent = nullptr);

    void addDemo(const Demo &demo);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    QList<Demo> demoData(const QModelIndex & parent = QModelIndex()) const;

    void remove();

signals:
    void countChanged(int count);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<Demo> m_demos;

};

#endif // DEMO_H
