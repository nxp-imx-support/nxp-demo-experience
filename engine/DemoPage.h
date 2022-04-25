/****************************************************************************
**
** Copyright 2021-2022 NXP
**
** SPDX-License-Identifier: BSD-2-Clause
**
****************************************************************************/

#ifndef DEMOPAGE_H
#define DEMOPAGE_H

#include <QObject>
#include <QMap>
#include "Demo.h"

class DemoPage : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList listAllData READ listAllData CONSTANT)
    Q_PROPERTY(QVariantList listDemos READ listDemos CONSTANT)
    Q_PROPERTY(QStringList listFirstMenu READ listFirstMenu CONSTANT)
    Q_PROPERTY(QStringList listSecondMenu READ listSecondMenu CONSTANT)
    Q_PROPERTY(QString firstMenuItem READ firstMenuItem WRITE setFirstMenuItem(QString firstMenuItem))
    Q_PROPERTY(QString secondMenuItem READ secondMenuItem WRITE setSecondMenuItem(QString secondMenuItem))

public:
    explicit DemoPage(QObject *parent = nullptr);
    void loadJsonData();
    QVariantList listAllData();
    QVariantList listDemos();
    QStringList listFirstMenu();
    QStringList listSecondMenu();
    QString firstMenuItem();
    void setFirstMenuItem (QString firstMenuItem);
    QString secondMenuItem();
    void setSecondMenuItem (QString secondMenuItem);

    QVariantList demosList;
    QVariantList currentDemosList;
    QString currentFirstMenuItem;
    QString currentSecondMenuItem;
    QMap<QString, QStringList> commandList;

    QStringList firstLevelMenu;
    QStringList secondLevelMenu;
    QStringList secondLevelMenuFiltered;

private:
    DemoModel *modelDemo = new DemoModel;
    QString DEMOPATH = "/home/root/.nxp-demo-experience";

};

#endif // DEMOPAGE_H
