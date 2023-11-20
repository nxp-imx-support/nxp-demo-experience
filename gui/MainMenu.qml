/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** Copyright 2019-2021, 2023 NXP
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
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

ToolBar {
    id: toolBarBack
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: colorBar.bottom
    height: convertDoubleToInt(appWindow.height * 0.120)
    background: Rectangle {
        color: "white"
    }
    TabBar {
        id: tabBar
        width: convertDoubleToInt(appWindow.width * 1.00)
        height: convertDoubleToInt(appWindow.height * 0.06)
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        currentIndex: 0
        background: Rectangle {
            color: "white"
        }
        TabButton {
            id: rectLogo
            width: convertDoubleToInt(appWindow.width)
            height: tabBar.height * 0.7
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                color: "white"
            }
            Rectangle{
                id:spacer
                visible: true
                width: 20

            }
            Text {
                id: textItem1
                font.pointSize: convertDoubleToInt(appWindow.height * 0.040)
                font.bold: true
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: "#20272D"
                text: "GoPoint for i.MX Application Processors"
                font.family: "Nunito"
                padding: convertDoubleToInt(appWindow.height * 0.020)
            }
        }
    }
    Rectangle{
        id: bottomLine
        color: "#D9D9D9"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: appWindow.width
        height: convertDoubleToInt(appWindow.height * 0.0026)
    }
}
