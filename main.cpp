/****************************************************************************
**
** Copyright 2021 NXP
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
#include <QScreen>

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
    QScreen *screen = app.primaryScreen();
    if (screen->geometry().width() < screen->geometry().height()){
        // Portrait orientation
        engine.rootContext()->setContextProperty("swidth", int(screen->geometry().width()));
        engine.rootContext()->setContextProperty("sheight", int(screen->geometry().width()/1.77)); //1.77 is 16:9 aspect ratio
    } else {
        // Landscape orientation
        if (screen->geometry().width() < 1280 || screen->geometry().height() < 720){
            engine.rootContext()->setContextProperty("swidth", screen->geometry().width() - 6); //Discount 6 pixels for xwayland borders
            engine.rootContext()->setContextProperty("sheight", screen->geometry().height() - 65); //Discount 65 pixels for xwayland header and borders
        }else{
            engine.rootContext()->setContextProperty("swidth", int(screen->geometry().width()/1.5));
            engine.rootContext()->setContextProperty("sheight", int(screen->geometry().height()/1.5));
        }
    }
    DemoManager pm;
    engine.rootContext()->setContextProperty("processManager", &pm);
    engine.load(url);
    struct utsname* buff = (struct utsname*)malloc(sizeof (struct utsname));



    uname(buff);
    free(buff);
    return app.exec();
}
