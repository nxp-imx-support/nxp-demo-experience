/****************************************************************************
**
** Copyright (C) 2019 NXP
**
****************************************************************************/

#ifndef UTILS_H
#define UTILS_H

#include <QObject>
#include <QProcess>

class Utils : public QObject
{

    Q_OBJECT

public:
    Q_INVOKABLE void callDemo();
    Q_INVOKABLE void callDemo2();
    QProcess demoProcess;

};

#endif // UTILS_H
