#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QObject>
#include "demo.h"

class Mainwindow : public QObject
{

    Q_OBJECT

public:
    explicit Mainwindow (QObject* parent = nullptr);

    QQmlApplicationEngine *engineMain;
    QObject *stackView;

    void loadJsonData();
    Q_INVOKABLE void goToSubmenu(QString);
    Q_INVOKABLE void goToMainmenu();

    QStringList firstLevelMenu;
    QStringList secondLevelMenu;
    QStringList secondLevelMenuFiltered;

private:

    DemoModel *modelDemo = new DemoModel;

};


#endif // MAINWINDOW_H
