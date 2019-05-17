#include <QFile>
#include <QTextStream>
#include <QProcess>
#include <QEvent>
#include <QApplication>
#include <QStandardItemModel>
#include <QStringList>
#include "../utils.h"

void Utils::callDemo(){
    QString path = "~/demo/video/videoPlayback.sh";
    QString command = "sh -c " + path + " < /dev/null";
    //demoProcess.execute(command);
    demoProcess.execute("sh -c /home/root/demo-launcher/demo/video/videoPlayback.sh < /dev/null");
}

void Utils::callDemo2(){
    demoProcess.execute("sh -c /home/root/demo-launcher/demo/video/camera.sh < /dev/null");
}
