import QtQuick 2.12
import QtQuick.Controls 2.12


Rectangle {
    width: convertDoubleToInt(appWindow.width * 0.30)
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    id: listComponent
    property bool listState: false
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
                            source: modelData == "Back" ? "../../icons/chevron-left-solid.svg" : ""
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
