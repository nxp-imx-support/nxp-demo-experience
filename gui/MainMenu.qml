import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

ToolBar {
    id: toolBarBack
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: colorBar.bottom
    height: convertDoubleToInt(appWindow.height * 0.120)
    background: Rectangle {
        color: "white"
    }
    TabBar {
        id: tabBar
        width: convertDoubleToInt(appWindow.width * 1.00)
        height: convertDoubleToInt(appWindow.height * 0.06)
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        currentIndex: 0
        background: Rectangle {
            color: "white"
        }
        TabButton {
            id: rectLogo
            width: convertDoubleToInt(appWindow.width)
            height: tabBar.height * 0.7
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                color: "white"
            }
            Rectangle{
                id:spacer
                visible: true
                width: 20

            }

            Image {
                id: logo
                anchors.top: parent.top
                anchors.left: spacer.right
                anchors.right: textItem1.left
                anchors.verticalCenter: parent.verticalCenter
                source: "../assets/nxp.png"
                width: convertDoubleToInt(appWindow.width * 0.15)
                height: convertDoubleToInt(appWindow.height * 0.18)
                fillMode: Image.PreserveAspectFit

            }
            Text {
                id: textItem1
                font.pointSize: convertDoubleToInt(appWindow.height * 0.040)
                font.bold: true
                anchors.left: logo.right
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: "#20272D"
                text: "Demo Experience"
                font.family: "Nunito"
                padding: convertDoubleToInt(appWindow.height * 0.020)
            }
        }
    }
    Rectangle{
        id: bottomLine
        color: "#D9D9D9"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: appWindow.width
        height: convertDoubleToInt(appWindow.height * 0.0026)
    }
}
