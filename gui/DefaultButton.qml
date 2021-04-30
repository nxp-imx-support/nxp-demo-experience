import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Button {
        property alias buttonContent: buttonContentId.text

        anchors.centerIn: parent
        anchors.topMargin: convertDoubleToInt(appWindow.height * 0.02)
        anchors.bottomMargin: convertDoubleToInt(appWindow.height * 0.02)
        anchors.leftMargin: convertDoubleToInt(appWindow.width * 0.02)
        anchors.rightMargin: convertDoubleToInt(appWindow.width * 0.02)
        width:  convertDoubleToInt(appWindow.width * 0.20)
        height:  convertDoubleToInt(appWindow.height * 0.05)

        PropertyAnimation{
            id:fadeIn3
            target: rec3
            properties: "color"
            to: "#50616E"
            duration: 200
        }

        PropertyAnimation{
            id:fadeOut3
            target: rec3
            properties: "color"
            to: "#333f48"
            duration: 200
        }

        onHoveredChanged:{
                if(hovered){
                    fadeIn3.start()
                }else{
                    fadeOut3.start()
                }
        }

        background: Rectangle {
            id: rec3
            color: {
                if(flashButton.pressed){
                    return "#70808c"
                }else{
                    return "#333f48"
                }
            }
            radius: 3
        }

        Text {
            id: buttonContentId
            objectName: "buttonText"
            font.family: "Nunito"
            font.bold: true;
            color: "#FFFFFF"
            text: "DefaultButton"
            font.pointSize: convertDoubleToInt(applicationWindow.width * 0.012)
            anchors.centerIn: parent
        }
        visible: true
}
