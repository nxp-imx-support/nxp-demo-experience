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

Item {
    id: demoPage
    property string execText: ""
    property alias launchButton: launchButton
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
        y: 0
        width:  convertDoubleToInt(parent.width*0.73)
        height: parent.height
        contentHeight:  convertDoubleToInt(parent.height * 0.9032)
        cacheBuffer: 300
        model: demoModel
        delegate: Item {
            Column {
                x: convertDoubleToInt(0.03125 * demoPage.width)
                y: -convertDoubleToInt(0.0245 * demoPage.height)
                Rectangle {
                    width:  convertDoubleToInt(demoPage.width * 0.203)
                    height:  convertDoubleToInt(demoPage.height * 0.42)
                    antialiasing: true
                    color: buttonMouse.pressed ? "#003da5" : "transparent"
                    opacity: buttonMouse.pressed ? 0.4 : 1
                    Image {
                        objectName: "demoImage"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.fill: parent
                        source: icon ? "file:" + icon : "file:" + homeDir + "/.nxp-demo-experience/icon/default-icon.png"
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
                Text {
                    text: name
                    objectName: "demoText"
                    font.family: "Avenir LT std"
                    color: "#003da5"
                    font.bold: true
                    font.pointSize: width_imp < 1280 ? 8 : 12
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        cellHeight:  convertDoubleToInt(0.4838 * demoPage.height)
        cellWidth:  convertDoubleToInt(0.234 * demoPage.width)
    }

    Column {
        id: textColumn
        x: convertDoubleToInt(parent.width*0.75)
        y: convertDoubleToInt(parent.left + 0.064 * parent.height)
        width:  convertDoubleToInt(0.22 * demoPage.width)
        height:  convertDoubleToInt(0.0645 * demoPage.height)
        Text {
            id: titleText
            y: 0
            width:  convertDoubleToInt(0.22 * demoPage.width)
            height:  convertDoubleToInt(0.0322 * demoPage.height)
            color: "#000000"
            text: qsTr("Select a demo ...")
            font.family: "Avenir LT std"
            font.bold: true
            font.pointSize: width_imp < 1280 ? 8 : 12
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignLeft
        }
        Text {
            id: informativeText
            y:  convertDoubleToInt(titleText.bottom)
            width:  convertDoubleToInt(0.22 * demoPage.width)
            height: width_imp < 1280 ? convertDoubleToInt(0.38 * demoPage.height) : convertDoubleToInt(0.43 * demoPage.height)
            color: "#000000"
            text: qsTr("")
            font.family: "Avenir LT std"
            wrapMode: Text.WordWrap
            font.bold: false
            horizontalAlignment: Text.AlignJustify
            font.pointSize: width_imp < 1280 ? 6 : 10
        }
        Image {
            id: contentImage
            x: convertDoubleToInt(0.039 * demoPage.width)
            width:  convertDoubleToInt(0.156 * demoPage.width)
            height:  convertDoubleToInt(0.156 * demoPage.width)
            visible: false
        }
        Button {
            id: launchButton
            objectName: "launchButton"
            x: convertDoubleToInt(0.093 * demoPage.width)
            y: convertDoubleToInt(0.838 * demoPage.height)
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
                    font.pointSize: width_imp < 1280 ? 6 : 10
                    wrapMode: Text.WordWrap
                    text: control.text
                    color: "#003da5"
                    font.bold: true
                    font.family: "Avenir LT std"
                }
            }
        }
        spacing: 20
    }
}
