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

    if (itemName == "Back"){
        goToMainmenu();

    } else {

        // Check if item is from main or sub menu

        if (firstLevelMenu.contains(itemName)) {
            // Main menu. Go to sub menu
            QList<Demo> demoList = modelDemo->demoData();
            secondLevelMenuFiltered.clear();
            secondLevelMenuFiltered.append("Back");
            foreach(Demo demo, demoList){

                if (demo.firstmenu() == itemName) {
                    qDebug() << demo.name();
                    secondLevelMenuFiltered.append(demo.secondmenu());
                }
            }

            secondLevelMenuFiltered.removeDuplicates();

            engineMain->rootContext()->setContextProperty("pageModel", QVariant::fromValue(secondLevelMenuFiltered));

        } else {
            //Sub menu. Go to demos
            QMetaObject::invokeMethod(stackView, "push",
                Q_ARG(QVariant, QVariant(QUrl("qrc:/content/submenu.qml"))));

        }
    }
}


void Mainwindow::loadJsonData()
{
    QFile jsonFile;
    QJsonParseError jsonError1;
    QJsonArray ja, ja1;
    QJsonValue jv, jv1, jv2, jv3;
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

            firstLevel = jv[i].toObject().keys().takeFirst();
            firstLevelMenu.append(firstLevel);

            jo1 = jv1.toObject();
            jv2 = jo1.value(firstLevel);
            jo2 = jv2[0].toObject();

            for(int j = 0; j < jo2.count(); j++){
                secondLevel = jo2.keys().takeAt(j);
                secondLevelMenu.append(secondLevel);

                jv3 = jo2.value(secondLevel);
                ja1 = jv3.toArray();

                for(int k = 0; k < ja1.count(); k++){
                    // Register the demo as demo object
                    modelDemo->addDemo(Demo(ja1[k].toObject()["name"].toString(), firstLevel,
                    secondLevel, ja1[k].toObject()["executable"].toString(), ja1[k].toObject()["source"].toString(),
                    ja1[k].toObject()["icon"].toString(), ja1[k].toObject()["screenshot"].toString(), ja1[k].toObject()["compatible"].toString(),
                    ja1[k].toObject()["description"].toString()));

                }

            }

        }

}
