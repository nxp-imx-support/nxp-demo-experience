import QtQuick 2.12

Item {
    Rectangle{
        id: stripe1
        anchors.top: parent.top
        color: "#f9b500"
        anchors.left: parent.left
        width: convertDoubleToInt(appWindow.width * 0.28)
        height: convertDoubleToInt(appWindow.height * 0.010)
    }

    Rectangle{
        id: stripe2
        anchors.top: parent.top
        color: "#928647"
        anchors.left: stripe1.right
        width: convertDoubleToInt(appWindow.width * 0.08)
        height: convertDoubleToInt(appWindow.height * 0.010)
    }

    Rectangle{
        id: stripe3
        anchors.top: parent.top
        color: "#7bb1db"
        anchors.left: stripe2.right
        width: convertDoubleToInt(appWindow.width * 0.28)
        height: convertDoubleToInt(appWindow.height * 0.010)
    }

    Rectangle{
        id: stripe4
        anchors.top: parent.top
        color: "#6d9b46"
        anchors.left: stripe3.right
        width: convertDoubleToInt(appWindow.width * 0.08)
        height: convertDoubleToInt(appWindow.height * 0.010)
    }

    Rectangle{
        id: stripe5
        anchors.top: parent.top
        color: "#c9d200"
        anchors.left: stripe4.right
        width: convertDoubleToInt(appWindow.width * 0.28)
        height: convertDoubleToInt(appWindow.height * 0.010)
    }
}
