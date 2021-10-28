/****************************************************************************
**
** Copyright 2021 NXP
**
** SPDX-License-Identifier: BSD-2-Clause
**
****************************************************************************/

#include "DemoManager.h"
qint64 DemoManager::demoRun = -1;
QMap<qint64, QProcess *> DemoManager::processes;

qint64 DemoManager::runProcess(QString command){
    QStringList args = command.split(" ");
    QString program = args.at(0);
    args.removeFirst();
    QProcess *runner = new QProcess();
    runner->setProgram(program);
    runner->setArguments(args);
    QObject::connect(runner, SIGNAL(started()), this, SLOT(startDemo()));
    QObject::connect(runner, SIGNAL(finished(int,QProcess::ExitStatus)), this, SLOT(endDemo(int,QProcess::ExitStatus)));
    runner->start();
    processes.insert(runner->processId(),runner);
    return runner->processId();
}

void DemoManager::demoButtonClick(QString command){
    if(demoRun == -1){
        demoRun = runProcess(command);
    }else{
        QProcess *proc = processes.find(demoRun).value();
        QProcess ckill;
        ckill.start("pkill", QStringList() << "-P" << QString::number(demoRun));
        ckill.waitForFinished();
        proc->kill();
    }
}

QString DemoManager::demoButtonText(){
    if(demoRun == -1){
        return "Launch Demo";
    }else{
        return "Stop Current Demo";
    }
}

void DemoManager::startDemo(){
    emit demoChanged();
}

int DemoManager::endDemo(int code,QProcess::ExitStatus status){
    demoRun = -1;
    emit demoChanged();
    return code;
}


