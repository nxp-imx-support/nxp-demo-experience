#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine(QUrl("qrc:/main.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
