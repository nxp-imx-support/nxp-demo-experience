/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** Copyright 2021-2023 NXP
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
    width: convertDoubleToInt(appWindow.width * 0.30)
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    id: listComponent
    property bool listState: false
    Rectangle {
        id: menu
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: licWarn.top
        SwipeView {
            id: view
            currentIndex: 0
            anchors.fill: parent
            clip: true
            interactive: false
            Item {
                id: firstPage
                ListView {
                    id: firstMenuList
                    model: demoqmlmodule.listFirstMenu
                    anchors.fill: parent
                    clip: true
                    delegate: Component {
                        Rectangle {
                            height: convertDoubleToInt(0.097 * appWindow.height)
                            anchors.left: parent.left
                            anchors.right: parent.right
                            Rectangle {
                                id: menuItemBox
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                color:"#f6f7f8"
                                visible: false
                            }

                            Image {
                                id: backIcon
                                anchors.verticalCenter: parent.verticalCenter
                                source: modelData == "Back" ? "../assets/chevron-left-solid.svg" : ""
                                width: convertDoubleToInt(appWindow.width * 0.02)
                                fillMode: Image.PreserveAspectFit
                                x: convertDoubleToInt(appWindow.width * 0.01)
                            }

                            Text {
                                text: modelData
                                color: "Black"
                                font.family: "Nunito"
                                font.pointSize: convertDoubleToInt(appWindow.width * 0.02)
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: convertDoubleToInt(appWindow.width * 0.042)
                                horizontalAlignment: Text.AlignLeft
                            }

                            MouseArea {
                                id: mouse
                                anchors.fill: parent
                                onClicked: {
                                    demoqmlmodule.firstMenuItem = modelData;
                                    demoqmlmodule.secondMenuItem = "";
                                    demolistmain.updateGridView();
                                    demodetailsmain.updateDetails();
                                    if (modelData == "Back"){
                                        drawer.close();
                                    } else if (modelData == "All Demos"){
                                        drawer.close();
                                    }
                                    else {
                                        secondMenuList.model = demoqmlmodule.listSecondMenu;
                                        view.currentIndex = 1;
                                    }
                                }

                                hoverEnabled: true
                                onEntered: {
                                    menuItemBox.visible = true;
                                }
                                onExited: {
                                    menuItemBox.visible = false;
                                }
                            }
                        }
                    }
                }
            }
            Item {
                id: secondPage
                ListView {
                    id: secondMenuList
                    model: demoqmlmodule.listSecondMenu
                    anchors.fill: parent
                    clip: true
                    delegate: Component {
                        Rectangle {
                            height: convertDoubleToInt(0.097 * appWindow.height)
                            anchors.left: parent.left
                            anchors.right: parent.right
                            Rectangle {
                                id: menuItemBox
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                color:"#f6f7f8"
                                visible: false
                            }

                            Image {
                                id: backIcon
                                anchors.verticalCenter: parent.verticalCenter
                                source: modelData == "Back" ? "../assets/chevron-left-solid.svg" : ""
                                width: convertDoubleToInt(appWindow.width * 0.02)
                                fillMode: Image.PreserveAspectFit
                                x: convertDoubleToInt(appWindow.width * 0.01)
                            }

                            Text {
                                text: modelData
                                color: "Black"
                                font.family: "Nunito"
                                font.pointSize: convertDoubleToInt(appWindow.width * 0.02)
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: convertDoubleToInt(appWindow.width * 0.042)
                                horizontalAlignment: Text.AlignLeft
                            }

                            MouseArea {
                                id: mouse
                                anchors.fill: parent
                                onClicked: {
                                    demoqmlmodule.secondMenuItem = modelData;
                                    demolistmain.updateGridView();
                                    demodetailsmain.updateDetails();
                                    if (modelData == "Back"){
                                        view.currentIndex = 0;
                                    } else if (modelData == "All Demos"){
                                        drawer.close();
                                    }
                                    else {
                                        drawer.close();
                                    }
                                }

                                hoverEnabled: true
                                onEntered: {
                                    menuItemBox.visible = true;
                                }
                                onExited: {
                                    menuItemBox.visible = false;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Rectangle{
        id: quit
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: licWarn.top
        height: 50
        Button {
            id: quitButton
            anchors.fill: parent
            contentItem: Text {
                anchors.fill: parent
                text: " Quit"
                color: "Black"
                font.family: "Nunito"
                font.pointSize: convertDoubleToInt(appWindow.width * 0.02)
            }
            onClicked: {
                Qt.callLater(Qt.quit)
            }
            background: Rectangle {
                id:rec
            }
        }
    }
    Rectangle{
        id: licWarn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 50
        Text {
            anchors.fill: parent
            text: " Version 4.8\n Copyright 2019-2024 NXP\n Uses LGPL-3.0 libraries"
            color: "Black"
            font.family: "Nunito"
            font.pointSize: convertDoubleToInt(10)
        }
    }
}
