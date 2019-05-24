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

#include "mainwindow.h"
#include "demo.h"

Mainwindow::Mainwindow (QObject* parent) : QObject(parent)
{

    loadJsonData();

}

void Mainwindow::goToMainmenu()
{
    qDebug() << "Going to mainmenu";
    engineMain->rootContext()->setContextProperty("pageModel", QVariant::fromValue(firstLevelMenu));
}

void Mainwindow::goToSubmenu(QString itemName)
{

    qDebug() << "Going to submenu: " + itemName;
    // Check if item is from main or sub menu

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


void Mainwindow::loadJsonData()
{
    QFile jsonFile;
    QJsonParseError jsonError1;
    QJsonArray ja, ja1, ja2;
    QJsonValue jv, jv1, jv2, jv3, jv4;
    QJsonObject jo, jo1, jo2;

    jsonFile.setFileName("demos/demos.json");
    jsonFile.open(QIODevice::ReadOnly | QIODevice::Text);
    QJsonDocument jsonDocument = QJsonDocument::fromJson(jsonFile.readAll(),&jsonError1);
    if (jsonError1.error != QJsonParseError::NoError)
        qDebug() << jsonError1.errorString();
    jsonFile.close();
    jo = jsonDocument.object();
    QString firstLevel, secondLevel, demoName;

    jv = jo.value("demos");
    ja = jv.toArray();

        for(int i = 0; i < ja.count(); i++){

            jv1 = ja.at(i);

            //firstLevel = jv[i].toObject().keys().takeFirst();
            firstLevel = jv1.toObject().keys().takeFirst();
            firstLevelMenu.append(firstLevel);

            jo1 = jv1.toObject();
            jv2 = jo1.value(firstLevel);
            ja1 = jv2.toArray();
            jv3 = ja1.at(0);
            jo2 = jv3.toObject();

            for(int j = 0; j < jo2.count(); j++){
                secondLevel = jo2.keys().takeAt(j);
                secondLevelMenu.append(secondLevel);

                jv4 = jo2.value(secondLevel);
                ja2 = jv4.toArray();

                for(int k = 0; k < ja2.count(); k++){
                    // Register the demo as demo object
                    modelDemo->addDemo(Demo(ja2[k].toObject()["name"].toString(), firstLevel,
                    secondLevel, ja2[k].toObject()["executable"].toString(), ja2[k].toObject()["source"].toString(),
                    ja2[k].toObject()["icon"].toString(), ja2[k].toObject()["screenshot"].toString(), ja2[k].toObject()["compatible"].toString(),
                    ja2[k].toObject()["description"].toString()));

                }

            }

        }

}
