/****************************************************************************
**
** Copyright 2021-2022 NXP
**
** SPDX-License-Identifier: BSD-2-Clause
**
****************************************************************************/

#include <QFile>
#include <QTextStream>
#include <QProcess>
#include <QEvent>
#include <QStandardItemModel>
#include <QStringList>
#include <QVariant>
#include <QQmlContext>
#include <QJsonParseError>
#include <QDebug>
#include <QJsonObject>
#include <QJsonArray>
#include <QMetaObject>
#include <QHostInfo>
#include <QDir>

#include "DemoPage.h"
#include "Demo.h"

DemoPage::DemoPage(QObject *parent) : QObject(parent)
{
    loadJsonData();

    QList<Demo> demoList = modelDemo->demoData();

    demosList.clear();
    commandList.clear();
    foreach(Demo demo, demoList){
        QStringList demoItem = {demo.name(), demo.firstmenu(), demo.secondmenu(), demo.executable(),
                                demo.source(), demo.icon(), demo.screenshot(), demo.compatible(), demo.description()};
        demosList.append(demoItem);
        if(demo.id() != ""){
            commandList.insert(demo.id(),demoItem);
        }
    }
}

QVariantList DemoPage::listAllData()
{
    return demosList;
}

QStringList DemoPage::listFirstMenu()
{
    return firstLevelMenu;
}

QStringList DemoPage::listSecondMenu()
{
    if (firstLevelMenu.contains(currentFirstMenuItem)) {
        QList<Demo> demoList = modelDemo->demoData();
        secondLevelMenuFiltered.clear();
        secondLevelMenuFiltered.append("Back");
        secondLevelMenuFiltered.append("All Demos");
        foreach(Demo demo, demoList){
            if (demo.firstmenu() == currentFirstMenuItem) {
                secondLevelMenuFiltered.append(demo.secondmenu());
            }
        }
        secondLevelMenuFiltered.removeDuplicates();
    }
    return secondLevelMenuFiltered;
}

QString DemoPage::firstMenuItem()
{
    return currentFirstMenuItem;
}

void DemoPage::setFirstMenuItem(QString firstMenuItem)
{
    currentFirstMenuItem = firstMenuItem;
    return;
}

QString DemoPage::secondMenuItem()
{
    return currentSecondMenuItem;
}

void DemoPage::setSecondMenuItem(QString secondMenuItem)
{
    currentSecondMenuItem = secondMenuItem;
    return;
}

QVariantList DemoPage::listDemos()
{

    QList<Demo> demoList = modelDemo->demoData();
    currentDemosList.clear();

    foreach(Demo demo, demoList){
        if ((demo.firstmenu() == currentFirstMenuItem) || (currentFirstMenuItem == "") || (currentFirstMenuItem == "Back") || (currentFirstMenuItem == "All Demos")){
            if ((demo.secondmenu() == currentSecondMenuItem) || (currentSecondMenuItem == "") || (currentSecondMenuItem == "Back") || (currentSecondMenuItem == "All Demos")){
                QStringList demoItem = {demo.name(), demo.firstmenu(), demo.secondmenu(), demo.executable(),
                                        demo.source(), demo.icon(), demo.screenshot(), demo.compatible(), demo.description()};
                currentDemosList.append(demoItem);
            }
        }
    }
    return currentDemosList;
}

void DemoPage::loadJsonData()
{
    QFile jsonFile, iconFile, screenshotFile;
    QJsonParseError jsonError1;
    QJsonArray ja, ja1, ja2;
    QJsonValue jv, jv1, jv2, jv3, jv4;
    QJsonObject jo, jo1, jo2;
    QString board = QHostInfo::localHostName().toLocal8Bit();
    // If Demo Launcher is not running on i.MX board, set it to 7ulp
    if (!board.contains("imx"))
        board = "imx7ulpevk";
    if (board.contains("-"))
        board = board.split("-")[0];
    else if (board.endsWith("evk"))
        board = board.remove("evk");
    jsonFile.setFileName(DEMOPATH + "/demos.json");
    jsonFile.open(QIODevice::ReadOnly | QIODevice::Text);
    QJsonDocument jsonDocument = QJsonDocument::fromJson(jsonFile.readAll(),&jsonError1);

    jsonFile.close();
    jo = jsonDocument.object();
    QString firstLevel, secondLevel, demoName, iconFileName, screenshotFileName;
    jv = jo.value("demos");
    ja = jv.toArray();

    firstLevelMenu.append("Back");
    firstLevelMenu.append("All Demos");

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
                    iconFileName = DEMOPATH + "/icon/" + ja2[k].toObject()["icon"].toString();
                    iconFile.setFileName(iconFileName);

                    if (!iconFile.exists() || ja2[k].toObject()["icon"].toString().isEmpty())
                        iconFileName = "";

                    // Check if screenshot file exists, if not leave it blank
                    screenshotFileName = DEMOPATH + "/screenshot/" + ja2[k].toObject()["screenshot"].toString();
                    screenshotFile.setFileName(screenshotFileName);

                    if (!screenshotFile.exists() || ja2[k].toObject()["screenshot"].toString().isEmpty())
                        screenshotFileName = "";


                    modelDemo->addDemo(Demo(ja2[k].toObject()["name"].toString(), firstLevel,
                    secondLevel, ja2[k].toObject()["executable"].toString(), ja2[k].toObject()["source"].toString(),
                    iconFileName, screenshotFileName, ja2[k].toObject()["compatible"].toString(),
                    ja2[k].toObject()["description"].toString(),ja2[k].toObject()["id"].toString()));
                }
            }
            firstLevelMenu.removeDuplicates();
            secondLevelMenu.removeDuplicates();
        }
    }
}
