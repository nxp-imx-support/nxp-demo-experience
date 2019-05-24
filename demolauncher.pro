QT += qml quick
TARGET = demolauncher

include(src/src.pri)

OTHER_FILES += \
    main.qml

RESOURCES += \
    resources.qrc

DISTFILES += \
    content/bottomDelegate.qml \
    content/demoPage.qml \
    content/subMenuPage.qml \
    demo/video/videoPlayback.sh

SOURCES += \
    mainwindow.cpp \
    utils.cpp

HEADERS += \
    mainwindow.h \
    src/qtquickcontrolsapplication.h \
    utils.h

HEADERS += \
    demo.h

SOURCES += \
    demo.cpp

