QT += qml quick
TARGET = demolauncher

include(src/src.pri)

OTHER_FILES += \
    main.qml \
    content/videoPage.qml \
    content/gpuPage.qml \
    content/aimlPage.qml

RESOURCES += \
    resources.qrc

DISTFILES += \
    content/bottomDelegate.qml \
    content/modelPage.qml \
    content/submenu.qml \
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

