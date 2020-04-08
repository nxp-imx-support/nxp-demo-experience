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
import QtQuick.Controls.Styles 1.1
import Mainwindow 1.0
import QtGraphicalEffects 1.12

Item {
    id: demoPage
    property string execText: ""
   // property alias launchButton: launchButton
    property real progress: 0
    property int width_imp:  applicationWindow.width
    property int height_imp: applicationWindow.height - 100
    width: width_imp
    height: height_imp

    function convertDoubleToInt (x) {
        return x < 0 ? Math.ceil(x) : Math.floor(x);
    }

    SequentialAnimation on progress {
        loops: Animation.Infinite
        running: true
        NumberAnimation {
            from: 0
            to: 1
            duration: 3000
        }
        NumberAnimation {
            from: 1
            to: 0
            duration: 3000
        }
    }

    Component {
        id: touchStyle
        ButtonStyle {
            panel: Item {
                implicitHeight: convertDoubleToInt(demoPage.height * 0.38)
                implicitWidth:  convertDoubleToInt(demoPage.width * 0.1875)
            }
        }
    }

    GridView {
        id: gridView
        objectName: "gridView"
        x: 0
        y: convertDoubleToInt(demoPage.height * 0.02)
        width:  convertDoubleToInt(parent.width*0.6)
        height: parent.height
        contentHeight:  convertDoubleToInt(parent.height * 0.9032)
        cacheBuffer: 300
        model: demoModel
        delegate: Item {
            Column {
                x: convertDoubleToInt(0.025 * demoPage.width)
                y: convertDoubleToInt(0.0245 * demoPage.height)
                Rectangle {
                    width:  convertDoubleToInt(demoPage.width * 0.18)
                    height:  convertDoubleToInt(demoPage.height * 0.4)
                    anchors.horizontalCenter: parent.horizontalCenter
                    antialiasing: true
                    color: buttonMouse.pressed ? "#003da5" : "transparent"
                    opacity: buttonMouse.pressed ? 0.4 : 1
                    Rectangle{
                        id: imageRect2
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: parent.height * 0.8

                        Image {
                            id: demoImage
                            objectName: "demoImage"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width * 0.8
                            source: icon ? "file:" + icon : "file:" + homeDir + "/.nxp-demo-experience/icon/default-icon.svg"
                            visible: false
                            fillMode: Image.PreserveAspectFit
                        }
                        ColorOverlay{
                            // Icon color
                            anchors.fill: demoImage
                            source:demoImage
                            color:"#7bb1db"
                            smooth: true
                            antialiasing: true
                        }
                        MouseArea {
                            id: buttonMouse
                            anchors.fill: parent
                            anchors.margins: -5
                            onClicked: {
                                titleText.text = name
                                informativeText.text = description
                                execText = executable
                                launchButton.visible = 1
                                contentImage.visible = 1
                                contentImage.source = "file:" + homeDir + "/.nxp-demo-experience/screenshot/" + screenshot
                            }
                        }

                    }
                    Rectangle {
                        anchors.top: imageRect2.bottom
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right

                        Text {
                            text: name
                            objectName: "demoText"
                            font.family: "Avenir LT std"
                            color: "#003da5"
                            font.bold: true
                            font.pointSize: convertDoubleToInt(applicationWindow.width * 0.012)
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }

                    }
                }
            }
        }
        cellHeight:  convertDoubleToInt(0.46 * demoPage.height)
        cellWidth:  convertDoubleToInt(0.18 * demoPage.width)
    }

    Column {
        id: textColumn
        anchors.left: gridView.right
        y: convertDoubleToInt(parent.left + 0.064 * parent.height)
        anchors.right: parent.right
        height:  convertDoubleToInt(0.1 * demoPage.height)
        Rectangle{
            id:titleRect
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: convertDoubleToInt(0.14 * demoPage.height)

            Text {
                id: titleText
                y: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: "#000000"
                text: qsTr("Select a demo ...")
                font.family: "Avenir LT std"
                font.bold: true
                font.pointSize: convertDoubleToInt(applicationWindow.width * 0.017)
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle
        {
            id:infoRect
            anchors.top: titleRect.bottom
            anchors.left: parent.left
            height: convertDoubleToInt(0.5 * demoPage.height)
            Text {
                id: informativeText
                y:  convertDoubleToInt(titleText.bottom)
                width:  convertDoubleToInt(0.36 * demoPage.width)
                color: "#000000"
                text: qsTr("")
                font.family: "Avenir LT std"
                wrapMode: Text.WordWrap
                font.bold: false
                horizontalAlignment: Text.AlignLeft
                font.pointSize: convertDoubleToInt(applicationWindow.width * 0.012)
            }
        }

        Rectangle{
            id:imageRect
            anchors.top: infoRect.bottom
            width: convertDoubleToInt(0.156 * demoPage.width)
            height:  convertDoubleToInt(0.156 * demoPage.width)
            Image {
                id: contentImage
                anchors.fill: parent
                visible: false
                anchors.centerIn: parent
            }
        }

        Rectangle{
            id:buttonRect
            anchors.left: imageRect.right
            anchors.right: parent.right
            anchors.bottom: imageRect.bottom
            height: 60
            Button {
                id: launchButton
                objectName: "launchButton"
                anchors.centerIn: parent
                width:  convertDoubleToInt(0.125 * demoPage.width)
                height:  convertDoubleToInt(0.0645 * demoPage.height)
                text: "Launch"
                visible: false
                onClicked: {
                    mainwindow.callDemo(execText);
                }
                style: ButtonStyle {
                    label: Text {
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: convertDoubleToInt(applicationWindow.width * 0.01)
                        wrapMode: Text.WordWrap
                        text: control.text
                        color: "#003da5"
                        font.bold: true
                        font.family: "Avenir LT std"
                    }
                }
            }
        }

    }
}
