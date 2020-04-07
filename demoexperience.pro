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
    demo/video/videoPlayback.sh \
    imx-demo-launcher-demos-list/README.md \
    imx-demo-launcher-demos-list/demos.json \
    imx-demo-launcher-demos-list/icon/README.md \
    imx-demo-launcher-demos-list/icon/default-icon.png \
    imx-demo-launcher-demos-list/icon/icon_demo_launcher.png \
    imx-demo-launcher-demos-list/screenshot/README.md \
    imx-demo-launcher-demos-list/screenshot/bloom.jpg \
    imx-demo-launcher-demos-list/screenshot/blur.jpg \
    imx-demo-launcher-demos-list/screenshot/dfgraphicsbasic2d.jpg \
    imx-demo-launcher-demos-list/screenshot/dfsimpleui100.jpg \
    imx-demo-launcher-demos-list/screenshot/dfsimpleui101.jpg \
    imx-demo-launcher-demos-list/screenshot/eightlayerblend.jpg \
    imx-demo-launcher-demos-list/screenshot/fractalshader.jpg \
    imx-demo-launcher-demos-list/screenshot/linebuilder101.jpg \
    imx-demo-launcher-demos-list/screenshot/modelloaderbasics.jpg \
    imx-demo-launcher-demos-list/screenshot/qt5_opengl_cube.png \
    imx-demo-launcher-demos-list/screenshot/qt5_opengl_hellowindow.png \
    imx-demo-launcher-demos-list/screenshot/qt5_quick_clocks.png \
    imx-demo-launcher-demos-list/screenshot/qt5_quick_samegame.png \
    imx-demo-launcher-demos-list/screenshot/qt5everywhere.png \
    imx-demo-launcher-demos-list/screenshot/s03_transform.jpg \
    imx-demo-launcher-demos-list/screenshot/s04_projection.jpg \
    imx-demo-launcher-demos-list/screenshot/s06_texturing.jpg \
    imx-demo-launcher-demos-list/screenshot/s07_environmentmapping.jpg \
    imx-demo-launcher-demos-list/screenshot/s08_environmentmappingrefraction.jpg \
    imx-demo-launcher-demos-list/screenshot/vivante_cover_flow.png \
    imx-demo-launcher-demos-list/screenshot/vivante_tutorial7.png \
    imx-demo-launcher-demos-list/screenshot/vivante_vv_laucher.png \
    imx-demo-launcher-demos-list/scripts/audio/audio_playback/audio_play.sh \
    imx-demo-launcher-demos-list/scripts/audio/audio_playback/audio_record.sh \
    imx-demo-launcher-demos-list/scripts/multimedia/gstreamer/camerapreview.sh \
    imx-demo-launcher-demos-list/scripts/multimedia/gstreamer/smart.mp4 \
    imx-demo-launcher-demos-list/scripts/multimedia/gstreamer/smart_hd.mp4 \
    imx-demo-launcher-demos-list/scripts/opengl/vivante_cover_flow.sh \
    imx-demo-launcher-demos-list/scripts/opengl/vivante_tutorial7.sh

SOURCES += \
    mainwindow.cpp

HEADERS += \
    mainwindow.h \
    src/qtquickcontrolsapplication.h

HEADERS += \
    demo.h

SOURCES += \
    demo.cpp

