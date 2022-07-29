QT += qml quick core

CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        main.cpp \
        engine/Demo.cpp \
        engine/DemoManager.cpp \
        engine/DemoPage.cpp \
        tui/TUIWindow.cpp

RESOURCES += qml.qrc

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

OTHER_FILES += \
    assets/*

DISTFILES += \
    main.qml \
    gui/*.qml


HEADERS += \
    engine/Demo.h \
    engine/DemoManager.h \
    engine/DemoPage.h \
    tui/TUIWindow.h

LIBS += -lcurses -lmenu -lpanel
