import QtQuick 2.12
import QtGraphicalEffects 1.0
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
