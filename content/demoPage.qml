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
    property string execText: ""
    property alias launchButton: launchButton
    property real progress: 0
    width: 1280
    height: 620
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
                implicitHeight: 240
                implicitWidth: 240
            }
        }
    }

    GridView {
        id: gridView
        objectName: "gridView"
        x: 0
        y: 0
        width: 940
        height: 620
        contentHeight: 560
        cacheBuffer: 300
        model: demoModel
        delegate: Item {
            Column {
                x: 40
                y: 40
                Rectangle {
                    width: 260
                    height: 260
                    antialiasing: true
                    color: buttonMouse.pressed ? "#126ee8" : "transparent"
                    opacity: buttonMouse.pressed ? 0.4 : 1
                    Image {
                        objectName: "demoImage"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: icon ? "file:" + icon : "file:.imx-launcher/icon/default-icon.png"
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
                            contentImage.source = "file:.imx-launcher/screenshot/" + screenshot
                        }
                    }
                }
                Text {
                    text: name
                    objectName: "demoText"
                    color: "#126ee8"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        cellHeight: 300
        cellWidth: 300
    }

    Column {
        id: textColumn
        x: 960
        y: 40
        width: 280
        height: 560
        Text {
            id: titleText
            y: 0
            width: 280
            height: 20
            color: "#ffffff"
            text: qsTr("Select a demo ...")
            font.bold: true
            font.pixelSize: 16
            horizontalAlignment: Text.AlignLeft
        }
        Text {
            id: informativeText
            y: 10
            width: 280
            height: 240
            color: "#ffffff"
            text: qsTr("")
            wrapMode: Text.WordWrap
            font.bold: false
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 14
        }
        Image {
            id: contentImage
            x: 50
            width: 200
            height: 200
            visible: false
        }
        Button {
            id: launchButton
            objectName: "launchButton"
            x: 120
            y: 520
            width: 160
            height: 40
            text: "LAUNCH"
            visible: false
            onClicked: {
                mainwindow.callDemo(execText);
            }
            style: ButtonStyle {
                label: Text {
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                    text: control.text
                    color: "#126ee8"
                    font.bold: true
                }
            }
        }
        spacing: 20
    }
}
