/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** Copyright 2019 NXP
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtGlobal>
#include <QFile>
#include <QScreen>
#include <QJsonParseError>
#include <QDebug>
#include <QJsonObject>
#include <QJsonArray>
#include <QVariant>
#include <QQmlContext>
#include <demo.h>
#include <QFontDatabase>
#include <QFont>
#include <QDir>
#include "mainwindow.h"

void loadFonts(){
    QFontDatabase::addApplicationFont(QStringLiteral(":/fonts/AvenirLTStd-Book.otf"));
    QFontDatabase::addApplicationFont(QStringLiteral(":/fonts/AvenirLTStd-Medium.otf"));
    QFontDatabase::addApplicationFont(QStringLiteral(":/fonts/AvenirLTStd-Roman.otf"));
}

void myMessageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    QByteArray localMsg = msg.toLocal8Bit();
    const char *file = context.file ? context.file : "";
    const char *function = context.function ? context.function : "";
    switch (type) {
    case QtDebugMsg:
        fprintf(stderr, "Debug: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function);
        break;
    case QtInfoMsg:
        fprintf(stderr, "Info: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function);
        break;
    case QtWarningMsg:
        fprintf(stderr, "Warning: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function);
        break;
    case QtCriticalMsg:
        fprintf(stderr, "Critical: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function);
        break;
    case QtFatalMsg:
        fprintf(stderr, "Fatal: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function);
        abort();
    }
    QFile outFile(QDir::homePath() + "/.nxp-demo-experience/log");
    outFile.open(QIODevice::WriteOnly | QIODevice::Append);
    QTextStream ts(&outFile);
    ts << localMsg << endl;
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qInstallMessageHandler(myMessageOutput);
    qmlRegisterType<Mainwindow>("Mainwindow", 1, 0, "Mainwindow");
    loadFonts();

    //Remove log file
    QFile outFile(QDir::homePath() + "/.nxp-demo-experience/log");
    outFile.remove();

    QQmlApplicationEngine engine(QUrl("qrc:/main.qml"));

    if (engine.rootObjects().isEmpty())
        return -1;

    QObject * root = engine.rootObjects().first();
    auto mainwindow = root->findChild<Mainwindow *>("mainwindow");

    QScreen *screen = app.primaryScreen();

    if (screen->geometry().width() < screen->geometry().height()){
        // Portrait orientation
        mainwindow->setWidth(int(screen->geometry().width()));
        mainwindow->setHeight(int(screen->geometry().width()/1.77)); //1.77 is 16:9 aspect ratio
    } else {
        // Landscape orientation
        if (screen->geometry().width() < 1280 || screen->geometry().height() < 720){
            mainwindow->setWidth(screen->geometry().width() - 6); //Discount 6 pixels for xwayland borders
            mainwindow->setHeight(screen->geometry().height() - 65); //Discount 65 pixels for xwayland header and borders
        }else{
            mainwindow->setWidth(int(screen->geometry().width()/1.5));
            mainwindow->setHeight(int(screen->geometry().height()/1.5));
        }
    }

    qDebug().noquote() << "Name               : " << screen->name();
    qDebug().noquote() << "DevicePixelRatio   : " << screen->devicePixelRatio();
    qDebug().noquote() << "Width              : " << screen->geometry().width();
    qDebug().noquote() << "Height             : " << screen->geometry().height();
    qDebug().noquote() << "Size               : " << screen->geometry().size();
    qDebug().noquote() << "Application Width  : " << mainwindow->getWidth();
    qDebug().noquote() << "Application Height : " << mainwindow->getHeight();

    mainwindow->root = root;
    mainwindow->engineMain = &engine;

    QObject * stackView = root->findChild<QObject *>("stackView");
    mainwindow->stackView = stackView;
    mainwindow->goToMainmenu();

    return app.exec();
}
