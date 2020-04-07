QT += qml quick
TARGET = demoexperience

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
    mainwindow.cpp

HEADERS += \
    mainwindow.h \
    src/qtquickcontrolsapplication.h

HEADERS += \
    demo.h

SOURCES += \
    demo.cpp

