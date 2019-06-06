/****************************************************************************
**
** Copyright (C) 2019 NXP
**
** SPDX-License-Identifier: BSD-2-Clause
**
****************************************************************************/

#include <QFile>
#include <QTextStream>
#include <QProcess>
#include <QEvent>
#include <QApplication>
#include <QStandardItemModel>
#include <QStringList>
#include <QVariant>
#include <QQmlContext>
#include <QFile>
#include <QJsonParseError>
#include <QDebug>
#include <QJsonObject>
#include <QJsonArray>
#include <QMetaObject>
#include <QHostInfo>

#include "mainwindow.h"
#include "demo.h"

Mainwindow::Mainwindow (QObject* parent) : QObject(parent)
{
    loadJsonData();
    launchDemo_process = new QProcess();
    launchButton = new QObject();
    QObject::connect(launchDemo_process, SIGNAL(started()), this, SLOT(startDemo()));
    QObject::connect(launchDemo_process, SIGNAL(finished(int,QProcess::ExitStatus)), this, SLOT(finishDemo(int,QProcess::ExitStatus)));

}

void Mainwindow::callDemo(QString command)
{
    launchButton = root->findChild<QObject *>("launchButton");

    if(launchDemo_process->state() == launchDemo_process->NotRunning) {
        launchDemo_process->start("setsid " + command);
        launchButton->setProperty("text", "FINISH");
    } else {
        QString temp = "kill -TERM -" + QString::number(launchDemo_process->pid());
        system(temp.toStdString().c_str());
    }
}

void Mainwindow::startDemo()
{
    qDebug() << "Loading Demo...";
}

void Mainwindow::finishDemo(int exitCode, QProcess::ExitStatus exitStatus)
{
    launchButton->setProperty("text", "LAUNCH");
}

void Mainwindow::goToMainmenu()
{
    engineMain->rootContext()->setContextProperty("pageModel", QVariant::fromValue(firstLevelMenu));
}

void Mainwindow::goToSubmenu(QString itemName)
{
    if (firstLevelMenu.contains(itemName)) {
        // Main menu. Go to sub menu
        QList<Demo> demoList = modelDemo->demoData();
        secondLevelMenuFiltered.clear();
        foreach(Demo demo, demoList){
            if (demo.firstmenu() == itemName) {
                qDebug() << demo.name();
                secondLevelMenuFiltered.append(demo.secondmenu());
            }
        }

        secondLevelMenuFiltered.removeDuplicates();
        engineMain->rootContext()->setContextProperty("subPageModel", QVariant::fromValue(secondLevelMenuFiltered));
    }
}

void Mainwindow::goToDemo(QString submenuItem)
{
    currentSubMenu = submenuItem;
    currentModelDemo->remove();

    QModelIndex index;
    QList<Demo> demoList = modelDemo->demoData(index);

    for(int i = 0; i < modelDemo->rowCount(); i++){
        index = modelDemo->index(i,0);
        if ((currentMainMenu == demoList[i].firstmenu()) || (currentSubMenu == demoList[i].secondmenu())){
            currentModelDemo->addDemo(Demo(demoList[i].name(), demoList[i].firstmenu(),
                                      demoList[i].secondmenu(), demoList[i].executable(), demoList[i].source(),
                                      demoList[i].icon(), demoList[i].screenshot(), demoList[i].compatible(),
                                      demoList[i].description()));
        }
    }

    engineMain->rootContext()->setContextProperty("demoModel", QVariant::fromValue(currentModelDemo));
}

int Mainwindow::getWidth()
{
    return _width;
}
int Mainwindow::getHeight()
{
    return _height;
}
void Mainwindow::setWidth(int width)
{
    _width = width;
}
void Mainwindow::setHeight(int height)
{
    _height = height;
}

void Mainwindow::loadJsonData()
{
    QFile jsonFile, iconFile;
    QJsonParseError jsonError1;
    QJsonArray ja, ja1, ja2;
    QJsonValue jv, jv1, jv2, jv3, jv4;
    QJsonObject jo, jo1, jo2;
    QString board = QHostInfo::localHostName().toLocal8Bit();

    // If Demo Launcher is not running on i.MX board, set it to 7ulp
    if (!board.contains("imx"))
        board = "imx7ulpevk";

    qDebug() << board;
    jsonFile.setFileName(".imx-launcher/demos.json");
    jsonFile.open(QIODevice::ReadOnly | QIODevice::Text);
    QJsonDocument jsonDocument = QJsonDocument::fromJson(jsonFile.readAll(),&jsonError1);

    if (jsonError1.error != QJsonParseError::NoError)
        qDebug() << jsonError1.errorString();

    jsonFile.close();
    jo = jsonDocument.object();
    QString firstLevel, secondLevel, demoName, iconFileName;
    jv = jo.value("demos");
    ja = jv.toArray();

    for(int i = 0; i < ja.count(); i++){
        jv1 = ja.at(i);
        firstLevel = jv1.toObject().keys().takeFirst();
        jo1 = jv1.toObject();
        jv2 = jo1.value(firstLevel);
        ja1 = jv2.toArray();
        jv3 = ja1.at(0);
        jo2 = jv3.toObject();

        for(int j = 0; j < jo2.count(); j++){
            secondLevel = jo2.keys().takeAt(j);
            jv4 = jo2.value(secondLevel);
            ja2 = jv4.toArray();

            for(int k = 0; k < ja2.count(); k++){
                if (ja2[k].toObject()["compatible"].toString().contains(board)){
                    // Register the demo as demo object
                    firstLevelMenu.append(firstLevel);
                    secondLevelMenu.append(secondLevel);

                    // Check if icon file exists, if not leave it blank to show default icon
                    iconFileName = ".imx-launcher/icon/" + ja2[k].toObject()["icon"].toString();
                    iconFile.setFileName(iconFileName);
                    qDebug() << iconFileName;

                    if (!iconFile.exists() || ja2[k].toObject()["icon"].toString().isEmpty())
                        iconFileName = "";

                    modelDemo->addDemo(Demo(ja2[k].toObject()["name"].toString(), firstLevel,
                    secondLevel, ja2[k].toObject()["executable"].toString(), ja2[k].toObject()["source"].toString(),
                    iconFileName, ja2[k].toObject()["screenshot"].toString(), ja2[k].toObject()["compatible"].toString(),
                    ja2[k].toObject()["description"].toString()));
                }
            }
            firstLevelMenu.removeDuplicates();
            secondLevelMenu.removeDuplicates();
        }
    }
}
