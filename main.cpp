/****************************************************************************
**
** Copyright 2020 NXP
**
** SPDX-License-Identifier: BSD-2-Clause
**
****************************************************************************/

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include "engine/DemoPage.h"
#include <sys/utsname.h>
#include "engine/DemoManager.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<DemoPage>("com.nxp.demopage", 1, 0, "DemoQmlModule");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    DemoManager pm;
    engine.rootContext()->setContextProperty("processManager", &pm);
    struct utsname* buff = (struct utsname*)malloc(sizeof (struct utsname));
    uname(buff);
    free(buff);
    return app.exec();
}
