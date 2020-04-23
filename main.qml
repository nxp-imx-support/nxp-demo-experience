/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** Copyright (C) 2019 NXP
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

import QtQuick 2.2
import QtQuick.Controls 1.2
import "content"
import Mainwindow 1.0

ApplicationWindow {
    id: applicationWindow
    property int width_imp: mainwindow.getWidth()
    property int height_imp: mainwindow.getHeight()
    property alias stackView: stackView
    visible: true
    width: width_imp
    height: height_imp
    maximumWidth: width_imp
    maximumHeight: height_imp
    minimumWidth: width_imp
    minimumHeight: height_imp

    function convertDoubleToInt (x) {
        return x < 0 ? Math.ceil(x) : Math.floor(x);
    }

    Mainwindow {
        id: mainwindow
        objectName: "mainwindow"
    }

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top

        Image {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: convertDoubleToInt(parent.width * 0.42)
            scale: 0.8
            fillMode: Image.PreserveAspectFit
            visible: true
            source: "images/demo_launcher_logo.png"
            opacity: stackView.depth > 2 ? 0 : 1
            Behavior on opacity { NumberAnimation{} }
        }
    }

    Rectangle {
        id: backMenu
        anchors.rightMargin: convertDoubleToInt(parent.width * 0.58)
        anchors.leftMargin: 0
        anchors.topMargin: 0
        width: opacity ? convertDoubleToInt(applicationWindow.width * 0.047) : 0
        opacity: stackView.depth > 2 ? 0 : 1
        color: "#FFFFFF"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top
        Behavior on opacity { NumberAnimation{} }

        Rectangle {
            id: separator
            width: opacity ? convertDoubleToInt(applicationWindow.width * 0.005) : 0
            opacity: stackView.depth > 2 ? 0 : 1
            color: "#c8c9c7"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            Behavior on opacity { NumberAnimation{} }
        }
    }


    Rectangle {
        id: backtext
        anchors.rightMargin: 0
        anchors.leftMargin: convertDoubleToInt(parent.width * 0.734)
        anchors.topMargin: 0
        anchors.fill: parent
        width: opacity ? convertDoubleToInt(applicationWindow.width * 0.047) : 0
        opacity: stackView.depth > 2 ? 1 : 0
        color: "#ffffff"
        Behavior on opacity { NumberAnimation{} }
    }

    toolBar: BorderImage {
        width: applicationWindow.width
        height: applicationWindow.height/7

        Rectangle{
            id: stripe1
            anchors.top: parent.top
            color: "#f9b500"
            anchors.left: parent.left
            width: convertDoubleToInt(applicationWindow.width * 0.2923)
            height: convertDoubleToInt(applicationWindow.height * 0.008)
        }

        Rectangle{
            id: stripe2
            anchors.top: parent.top
            color: "#928647"
            anchors.left: stripe1.right
            width: convertDoubleToInt(applicationWindow.width * 0.081)
            height: convertDoubleToInt(applicationWindow.height * 0.008)
        }
        Rectangle{
            id: stripe3
            anchors.top: parent.top
            color: "#7bb1db"
            anchors.left: stripe2.right
            width: convertDoubleToInt(applicationWindow.width * 0.2367)
            height: convertDoubleToInt(applicationWindow.height * 0.008)
        }
        Rectangle{
            id: stripe4
            anchors.top: parent.top
            color: "#6d9b46"
            anchors.left: stripe3.right
            width: convertDoubleToInt(applicationWindow.width * 0.1397)
            height: convertDoubleToInt(applicationWindow.height * 0.008)
        }
        Rectangle{
            id: stripe5
            anchors.top: parent.top
            color: "#c9d200"
            anchors.left: stripe4.right
            anchors.right: parent.right
            height: convertDoubleToInt(applicationWindow.height * 0.008)
        }

        Rectangle {
            id: toolBarBack
            color: "white"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: stripe1.bottom
            anchors.bottom: parent.bottom

            Rectangle {
                id: backButton
                objectName: "backButton"
                width: opacity ? convertDoubleToInt(applicationWindow.width * 0.047) : 0
                anchors.left: parent.left
                anchors.leftMargin: 20
                opacity: stackView.depth > 1 ? 1 : 0
                anchors.verticalCenter: parent.verticalCenter
                antialiasing: true
                height: convertDoubleToInt(applicationWindow.height * 0.083)
                radius: 4
                color: backmouse.pressed ? "#222" : "transparent"
                Behavior on opacity { NumberAnimation{} }
                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: "images/navigation_previous_item.svg"
                    width: convertDoubleToInt(applicationWindow.width * 0.030)
                    height: convertDoubleToInt(applicationWindow.height * 0.093)
                }
                MouseArea {
                    id: backmouse
                    anchors.fill: parent
                    anchors.margins: -10
                    onClicked: stackView.pop()
                }
            }

            Text {
                font.pointSize: convertDoubleToInt(applicationWindow.width * 0.035)
                Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
                x: backButton.x + backButton.width + 20
                anchors.verticalCenter: parent.verticalCenter
                color: "Black"
                text: "NXP Demo Experience"
                font.family: "Avenir LT std"
            }

            Rectangle{
                id: stripe6
                anchors.bottom: parent.bottom
                color: "#c8c9c7"
                anchors.left: parent.left
                anchors.right: parent.right
                width: convertDoubleToInt(applicationWindow.width * 0.2923)
                height: convertDoubleToInt(applicationWindow.height * 0.008)
            }
        }
    }

    StackView {
        id: stackView
        objectName: "stackView"
        height: parent.height - toolBar.height
        anchors.fill: parent

        Rectangle{
            id:rect1
            height: applicationWindow.height * (0.097/6)
            color: "transparent"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
        }


        initialItem: Item {
            anchors.top: rect1.bottom
            width: parent.height/2
            height: parent.height-toolBar.height
            ListView {
                width: parent.width
                height: parent.height
                anchors.topMargin: 0
                anchors.rightMargin: convertDoubleToInt(parent.width * 0.58)
                model: pageModel
                anchors.fill: parent
                delegate: AndroidDelegate {
                    text: modelData //title
                    onClicked: {
                        stackView.push(Qt.resolvedUrl("content/subMenuPage.qml"))
                        mainwindow.goToSubmenu(modelData)
                    }
                }
            }
        }
    }
}

