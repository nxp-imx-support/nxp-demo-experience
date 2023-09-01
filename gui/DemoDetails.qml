/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** Copyright 2021,2023 NXP
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/


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
            Text{
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
                width: convertDoubleToInt(appWindow.width * 0.32)
                wrapMode: Text.WordWrap
            }
            ScrollView{
                id:view
                clip: true
                anchors.top: titleinfo.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                TextArea{
                    id:desinfo
                    enabled: false
                    text: demoqmlmodule.listDemos[currentSel][8]
                    color: "Black"
                    font.family: "Nunito"
                    font.pointSize: convertDoubleToInt(appWindow.width * 0.012)
                    leftPadding: convertDoubleToInt(appWindow.width * 0.01)
                    anchors.right: appWindow.right
                    rightPadding: convertDoubleToInt(appWindow.width * 0.04)
                    width: convertDoubleToInt(appWindow.width * 0.35)
                    wrapMode: Text.WordWrap
                }
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
