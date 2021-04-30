/****************************************************************************
**
** Copyright 2021 NXP
**
** SPDX-License-Identifier: BSD-2-Clause
**
****************************************************************************/

import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import com.nxp.demopage 1.0
import "gui"

//Top level element
ApplicationWindow {
    id: appWindow
    visible: true
    width: 1200//swidth
    height: 900//sheight
    //maximumWidth: swidth
    //maximumHeight: sheight
    //minimumWidth: swidth
    //minimumHeight: sheight

    title: "NXP Demo Experience"


    function convertDoubleToInt (x) {
        return x < 0 ? Math.ceil(x) : Math.floor(x);
    }

    menuBar: BorderImage{
        id: menuBar
        width: appWindow.width
        height: colorBar.height + mainMenu.height

        ColorBar{
            id: colorBar
            height: convertDoubleToInt(appWindow.height * 0.010)
        }
        MainMenu{
            id: mainMenu
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 0
        Loader {
            id: demoPage
            active: false
            onLoaded:  item.init()
            DemoPage { }
        }
    }
    DemoQmlModule{
        id: demoqmlmodule
    }
}
