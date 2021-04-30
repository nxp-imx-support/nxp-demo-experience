import QtQuick 2.12
import QtQuick.Controls 2.12

    Rectangle {
        id: rectDetails
        anchors.fill: parent.fill
        property int currentSel
        property ListModel demos: demoqmlmodule.listDemos

        function updateDetails(){
            catinfo.text = demoqmlmodule.listDemos[currentSel][1] + " - "+ demoqmlmodule.listDemos[currentSel][2]
            titleinfo.text = demoqmlmodule.listDemos[currentSel][0]
            desinfo.text = demoqmlmodule.listDemos[currentSel][8]
            return 1;
        }

        Rectangle{
            id: recHolder
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Text{
                text:"Select a demo from the table..."
                topPadding: convertDoubleToInt(appWindow.height * 0.01)
                leftPadding: convertDoubleToInt(appWindow.width * 0.01)
                color: "Black"
                font.family: "Nunito"
                font.pointSize: convertDoubleToInt(appWindow.width * 0.01)
                visible: {
                    if(titleinfo.text == "The Title Goes Here"){
                        return true;
                    }else{
                        return false;
                    }
                }
            }
            Label{
                id:catinfo
                text: demoqmlmodule.listDemos[currentSel][1] + " - "+ demoqmlmodule.listDemos[currentSel][2]


                color: "Black"
                font.family: "Nunito"
                font.pointSize: convertDoubleToInt(appWindow.width * 0.015)
                anchors.top: parent.top
                anchors.left: parent.left
                leftPadding: convertDoubleToInt(appWindow.width * 0.01)
                topPadding: convertDoubleToInt(appWindow.height * 0.01)
            }
            Label{
                id:titleinfo
                text: demoqmlmodule.listDemos[currentSel][0]
                color: "Black"
                font.family: "Nunito"
                font.pointSize: convertDoubleToInt(appWindow.width * 0.020)
                anchors.top: catinfo.bottom
                anchors.left: parent.left
                font.bold: true
                leftPadding: convertDoubleToInt(appWindow.width * 0.01)
                topPadding: convertDoubleToInt(appWindow.height * 0.0139)
                bottomPadding: convertDoubleToInt(appWindow.height * 0.0278)
            }
            Text{
                id:desinfo
                text: demoqmlmodule.listDemos[currentSel][8]
                color: "Black"
                font.family: "Nunito"
                font.pointSize: convertDoubleToInt(appWindow.width * 0.012)
                anchors.top: titleinfo.bottom
                leftPadding: convertDoubleToInt(appWindow.width * 0.01)
                anchors.right: appWindow.right
                rightPadding: convertDoubleToInt(appWindow.width * 0.04)
                width: convertDoubleToInt(appWindow.width * 0.35)
                wrapMode: Text.WordWrap
            }
        }

        Button {
            id: launchButton
            objectName: "launchButton"
            anchors.bottomMargin: convertDoubleToInt(appWindow.width * 0.03)
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: convertDoubleToInt(appWindow.width * 0.01)
            anchors.rightMargin: convertDoubleToInt(appWindow.width * 0.03)
            height:  convertDoubleToInt(appWindow.width * 0.03)
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
                    if(launchButton.pressed){
                        return "#70808c"
                    }else{
                        return "#333f48"
                    }
                }
                radius: 3
            }
            contentItem: Text {
                id: buttonText
                objectName: "buttonText"
                font.family: "Nunito"
                font.bold: true;
                color: "#FFFFFF"
                text: processManager.demoButtonText
                font.pointSize: convertDoubleToInt(appWindow.width * 0.012)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            visible: {
                if(titleinfo.text == "The Title Goes Here"){
                    return false;
                }else{
                    return true;
                }
            }
            onClicked: {
                processManager.demoButtonClick(demoqmlmodule.listDemos[currentSel][3]);
            }
        }
    }
