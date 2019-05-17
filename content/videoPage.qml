/****************************************************************************
**
** Copyright (C) 2019 NXP
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
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
import Utils 1.0

Item {

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

    Utils {
        id: utils
        objectName: "utils"
    }

    Component {
        id: touchStyle
        ButtonStyle {
            panel: Item {
                implicitHeight: 240
                implicitWidth: 240
                BorderImage {
                    anchors.fill: parent
                    antialiasing: true
                    border.bottom: 8
                    border.top: 8
                    border.left: 8
                    border.right: 8
                    anchors.margins: control.pressed ? -4 : 0
                    source: control.pressed ? "../images/button_pressed.png" : "../images/button_default.png"
                    Text {
                        text: control.text
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 23
                        renderType: Text.NativeRendering
                    }
                }
            }
        }
    }

    Column {
        //column1 is visible by default in the modelPage.qml
        id: column1
        x: 40
        y: 40
        width: 260
        height: 560
        spacing: 40
        visible: true
        Button {
            width: 260
            height: 260
            opacity: 1
            visible: true
            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../images/video-playback.png"
            }
            onClicked: {
                titleText.text = qsTr("PLAYBACK")
                informativeText.text = qsTr("This example open a Big Buck Bunny HD video for about 30 seconds.")
                launchButton.visible = 1
                contentImage.visible = 1
                contentImage.source = "../images/bigbuck.png"
            }
        }

        Button {
            width: 260
            height: 260
            opacity: 1
            visible: true
            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../images/video-camera.png"
            }
            onClicked: {
                titleText.text = qsTr("CAMERA")
                informativeText.text = qsTr("This example will test the camera available in /dev/video0, showing the first 200 frames and then closing. So please, be sure to connect the MINISAS-TO-CSI daughter card to the MIPI-CSI interface and change the DTB file to 'fsl-imx8qxp-mek-mipi-ov5640.dtb'. For more details, visit the <a href=\"https://community.nxp.com/docs/DOC-343216\">i.MX Camera Use Cases</a> documentation.")
                launchButton.visible = 0
                fakeButton.visible = 1
                contentImage.visible = 1
                contentImage.source = "../images/minisas-to-csi.png"
            }
        }

    }

    Column {
        //If necessary, change it for 'visible: true'
        id: column2
        x: 340
        y: 40
        width: 260
        height: 560
        visible: true

        Button {
            width: 260
            height: 260
            opacity: 1
            visible: true
            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../images/new-demo.png"
            }
        }

        Button {
            width: 260
            height: 260
            opacity: 1
            visible: true
            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../images/new-demo.png"
            }
        }
        spacing: 40
    }

    Column {
        //If necessary, change it for 'visible: true'
        id: column3
        x: 640
        y: 40
        width: 260
        height: 560
        visible: true

        Button {
            width: 260
            height: 260
            opacity: 1
            visible: true
            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../images/new-demo.png"
            }
        }

        Button {
            width: 260
            height: 260
            opacity: 1
            visible: true
            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../images/new-demo.png"
            }
        }
        spacing: 40
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
            text: qsTr("VIDEO")
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
            text: qsTr("This section shows some Multimedia features, such as Video Playback, Camera enablement, and others.")
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
            x: 120
            y: 520
            width: 160
            height: 40
            text: "LAUNCH"
            visible: false
            onClicked: utils.callDemo();
            style: ButtonStyle {
                label: Text {
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                    text: control.text
                    color: "blue"
                    font.bold: true
                }
            }
        }
        Button {
            id: fakeButton
            x: 120
            y: 520
            width: 160
            height: 40
            text: qsTr("LAUNCH")
            visible: false
            onClicked: utils.callDemo2();
            style: ButtonStyle {
                label: Text {
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                    text: control.text
                    color: "blue"
                    font.bold: true
                }
            }
        }

        spacing: 20
    }
}
