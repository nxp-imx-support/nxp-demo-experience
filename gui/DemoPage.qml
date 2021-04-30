import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Rectangle {
    id:homeBkgnd
    anchors.bottom: parent.bottom
    anchors.top: parent.top
    anchors.topMargin: convertDoubleToInt(appWindow.height * 0.02)
    anchors.left: parent.left
    width: convertDoubleToInt(appWindow.width)

    Drawer {
        id: drawer
        width: convertDoubleToInt(appWindow.width * 0.30)
        LeftMenu {
            id: leftMenu
        }
    }

    Rectangle {
        id: rectList
        color: "white"
        width: convertDoubleToInt(appWindow.height * 0.08)
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: convertDoubleToInt(appWindow.width * 0.0139)
        anchors.left: parent.left

        ToolButton {
            id: button1
            height: convertDoubleToInt(appWindow.height * 0.08)
            anchors.left: parent.left
            anchors.right: parent.right
            Rectangle {
                id: rect1
                height: convertDoubleToInt(appWindow.height * 0.08)
                width: convertDoubleToInt(appWindow.height * 0.08)

                Image {
                    id: imageIcon1
                    anchors.fill: parent
                    source: "../assets/bars-solid.svg"
                    visible: true
                    fillMode: Image.PreserveAspectFit
                    antialiasing: true
                }
            }

            onClicked:
                function f() {
                    var cords = homeBkgnd.mapToItem(null, 0, 0)
                    drawer.topMargin = cords.y;
                    drawer.height = homeBkgnd.height;
                    drawer.open();
                }
        }
    }

    DemoGrid {
        id: demolistmain
        width: convertDoubleToInt(appWindow.width * 0.6)
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: rectList.right
        transform: Translate {
            x: drawer.position * demolistmain.width * 0.38
        }
    }

    DemoDetails {
        id: demodetailsmain
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: demolistmain.right
        anchors.right: homeBkgnd.right
        currentSel: demolistmain.currentSel
        demos: demoqmlmodule.listDemos
        transform: Translate {
            x: drawer.position * demolistmain.width * 0.33
        }
    }
}
