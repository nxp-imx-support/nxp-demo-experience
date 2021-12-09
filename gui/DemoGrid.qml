/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** Copyright 2021 NXP
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
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.12

Rectangle{
    id: rectList1
    anchors.left: parent.left
    width: convertDoubleToInt(appWindow.width * 0.6);
    property alias gridDemos: gridDemos
    property alias rectList1: rectList1
    property real update: updateGridView()
    property int currentSel: gridDemos.currentIndex
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCente

    function updateGridView(){
        gridDemos.model = demoqmlmodule.listDemos;
        return 1;
    }

    Rectangle {
        width: convertDoubleToInt(appWindow.width * 0.1875 * 3)
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

    GridView {
        id: gridDemos
        anchors.fill: parent
        cellWidth: convertDoubleToInt(appWindow.width * 0.1875);
        cellHeight: convertDoubleToInt(appWindow.height * 0.2778);
        focus: true
        model: demoqmlmodule.listDemos ? demoqmlmodule.listDemos : ""
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        ScrollBar.vertical: ScrollBar{
            active: true
        }

        highlight: Rectangle {
            width: convertDoubleToInt(appWindow.width * 0.1406);
            height: convertDoubleToInt(appWindow.height * 0.25);
            color: "#f6f7f8"
        }

        delegate: Item {
            width: convertDoubleToInt(appWindow.width * 0.1875);
            height: convertDoubleToInt(appWindow.height * 0.2778);

            Item {
                id: imageItem
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                height: convertDoubleToInt(appWindow.height * 0.2222);

                Image {
                    id: myIcon
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: modelData[6] ? "file:" + modelData[6]
                                         : modelData[5] ? "file:" + modelData[5]
                                         : "file:/home/root/.nxp-demo-experience/icon/cube-solid.svg"
                    width: convertDoubleToInt(appWindow.width * 0.12);
                    fillMode: Image.PreserveAspectFit
                    Component.onCompleted:{
                        var str = myIcon.source.toString();
                        if (str.endsWith(".svg")){
                            colorOverlay.color = "#7bb1db";
                            myIcon.width = convertDoubleToInt(appWindow.width * 0.09);
                        }
                    }
                }
                ColorOverlay{
                    // Icon color
                    id: colorOverlay
                    anchors.fill: myIcon
                    source: myIcon
                    smooth: true
                    antialiasing: true
                }
            }

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: imageItem.bottom
                height: convertDoubleToInt(appWindow.height * 0.0556);

                Text {

                    text: modelData[0]
                    font.pointSize: convertDoubleToInt(appWindow.width * 0.012)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    wrapMode: Text.WrapAnywhere
                    elide: Text.ElideRight
                    clip: truncated
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    parent.GridView.view.currentIndex = index
                    demodetailsmain.updateDetails();
                }
            }
        }
    }
  }
}
