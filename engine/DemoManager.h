/****************************************************************************
**
** Copyright 2021 NXP
**
** SPDX-License-Identifier: BSD-2-Clause
**
****************************************************************************/

#ifndef DEMOMANAGER_H
#define DEMOMANAGER_H

#include <QObject>
#include <QProcess>
#include <QMap>

class DemoManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString demoButtonText READ demoButtonText NOTIFY demoChanged)

public:
    Q_INVOKABLE void demoButtonClick(QString command);
    qint64 runProcess(QString command);
    QString demoButtonText();
    static qint64 demoRun;
    static QMap<qint64, QProcess *> processes;

public slots:
    void startDemo();
    int endDemo(int,QProcess::ExitStatus);

signals:
    void demoChanged();
};

#endif // DEMOMANAGER_H
