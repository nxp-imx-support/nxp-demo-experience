/****************************************************************************
**
** Copyright 2022-2023 NXP
**
** SPDX-License-Identifier: BSD-2-Clause
**
****************************************************************************/

#include <curses.h>
#include <menu.h>
#include <panel.h>
#include "TUIWindow.h"
#include <stdlib.h>
#include "engine/DemoPage.h"

int startTui(void){
    WINDOW *menu_win;
    WINDOW *sub_win;
    WINDOW *helpWin;
    PANEL *sub_panel;
    PANEL *menu_panel;
    PANEL *helpPanel;
    int pageSize = 0;
    int ch = -1;
    int curDemo = -1;
    int curPage = 1;
    int selectDemo = 0;
    //Initialize Curses
    initscr();
    cbreak();
    noecho();
    keypad(stdscr, TRUE);
    curs_set(0);
    refresh();
    if (LINES < 15 || COLS < 70) {
        clear();
        refresh();
        endwin();
        printf("Output window is too small!\n");
        return 0;
    }

    //Get demo names
    DemoPage* demoPage = new DemoPage();
    std::vector<std::string> demo_names;
    int maxLen = -1;
    for (int i = 0; i < demoPage->demosList.size(); i++) {
        int len = demoPage->demosList.at(i).toStringList().at(0).toStdString().length();
        if (len > maxLen){
            maxLen = len;
        }
        demo_names.push_back(demoPage->demosList.at(i).toStringList().at(0).toStdString());
    }

    if (maxLen < 20) {
        maxLen = 20;
    }

    //Create Main Menu maxLen + 6
    menu_win = newwin(LINES-2, maxLen+6, 1, 1);

    //Create Sub-Window
    sub_win = newwin(LINES-2, COLS-maxLen-7, 1, maxLen + 6);
    box(sub_win, 0, 0);
    sub_panel = new_panel(sub_win);

    menu_panel = new_panel(menu_win);

    //Create Help Window
    helpWin = newwin(8, 36, (LINES/2)-4, (COLS/2)-18);
    box(helpWin, 0, 0);
    mvwprintw(helpWin, 0, 2, " Help Menu ");
    mvwprintw(helpWin, 2, 2, "Up/Down Arrow Key: Select Demo");
    mvwprintw(helpWin, 3, 2, "Enter Key: Run Demo");
    mvwprintw(helpWin, 4, 2, "Q or Ctrl+C Keys: Quit");
    mvwprintw(helpWin, 6, 7, "Press any key to close");
    helpPanel = new_panel(helpWin);
    hide_panel(helpPanel);
    //Write Menu
    box(menu_win, 0, 0);
    mvwaddch(menu_win, 0, maxLen + 5, ACS_TTEE);
    mvwaddch(menu_win, LINES-3, maxLen + 5, ACS_BTEE);
    mvwprintw(menu_win, 0, (maxLen-14)/2, " GoPoint ");

    if ((int)demo_names.size() == 0) {
        mvwprintw(menu_win, 2, 3, "No demos!");
        update_panels();
        doupdate();
        getch();
        clear();
        refresh();
        endwin();
        return 0;
    }

    for (int i = 0; i < LINES-6; i++) {
        if(i >= (int)demo_names.size()){
            break;
        }
        mvwprintw(menu_win, 2+i, 3, "%s", demo_names[i].c_str());
        pageSize++;
    }

    wmove(menu_win, 2, 2);
    wchgat(menu_win, maxLen + 2, A_STANDOUT, 2, NULL);
    update_panels();
    doupdate();

    int totalPage = (int)(std::ceil((float)demo_names.size()/(float)pageSize));
    mvwprintw(menu_win, LINES-3, (maxLen-8)/2, "%s", (" Page " + std::to_string(curPage) + " of " + std::to_string(totalPage) + " ").c_str());
    do {
        if (ch == 113 || ch == 81 || ch == KEY_RESIZE){
            break;
        } else if (ch == 10) {
            def_prog_mode();
            endwin();
            printf("\n");
            printf("%s", ("Starting " + demoPage->demosList.at(curDemo).toStringList().at(0).toStdString() + "!\n").c_str());
            printf("Quit the demo (Ctrl-C) to get back to demo select.\n\n");
            system(demoPage->demosList.at(curDemo).toStringList().at(3).toStdString().c_str());
            reset_prog_mode();
            refresh();
        } else if (ch == 259) {
            if (selectDemo - 1 >= 0){
                wmove(menu_win, 2+(selectDemo%(LINES-6)), 2);
                wchgat(menu_win, maxLen +2, A_NORMAL, 2, NULL);
                selectDemo = selectDemo - 1;
                wmove(menu_win, 2+(selectDemo%(LINES-6)), 2);
                wchgat(menu_win, maxLen + 2, A_STANDOUT, 2, NULL);
            }
        } else if (ch == 258) {
            if(selectDemo + 1 < (int)demo_names.size()){
                wmove(menu_win, 2+(selectDemo%(LINES-6)), 2);
                wchgat(menu_win, maxLen + 2, A_NORMAL, 2, NULL);
                selectDemo = selectDemo + 1;
                wmove(menu_win, 2+(selectDemo%(LINES-6)), 2);
                wchgat(menu_win, maxLen + 2 , A_STANDOUT, 2, NULL);
            }
        } else if (ch == 104 || ch == 72) {
            show_panel(helpPanel);
            update_panels();
            doupdate();
            getch();
            hide_panel(helpPanel);
        }
        if (curDemo != selectDemo) {
            werase(sub_win);
            box(sub_win, 0, 0);
            mvwprintw(sub_win, 2, 2, "%s", demoPage->demosList.at(selectDemo).toStringList().at(0).toStdString().c_str());
            mvwprintw(sub_win, LINES-5, 2, "Press Enter to launch");
            mvwprintw(sub_win, LINES-3, COLS-maxLen-20, " H - Help ");
            std::string des = demoPage->demosList.at(selectDemo).toStringList().at(8).toStdString();
            std::string line = "";
            std::string next = "";
            int progress = 0;
            int lineCount = 0;
            while (progress < (int)des.length()) {
                line.clear();
                while((int)line.length() < (int)(COLS-12-maxLen)){
                    if(progress > (int)des.length()){
                        break;
                    }
                    int wordPos = des.find(' ', progress);
                    if (wordPos == (int)std::string::npos){
                        wordPos = des.length();
                    }
                    next = des.substr(progress, wordPos-progress);
                    refresh();
                    if((int)(next.size() + line.size()) > (int)(COLS-12-maxLen)){
                        break;
                    }
                    line.append(next);
                    if(wordPos == (int)des.length()){
                        progress = des.length();
                    }
                    if((int)line.size() != (int)(COLS-12-maxLen)){
                        line.append(" ");
                    }
                    progress = progress + next.size() + 1;

                }
                if (lineCount > (LINES-12) && (progress < (int)des.length())) {
                    line.replace(line.length()-3,3,"...");
                    progress = (int)des.length();
                }
                mvwprintw(sub_win, lineCount + 4, 2, "%s", line.c_str());
                lineCount++;
            }
            curDemo = selectDemo;
        }
        if (curDemo == curPage*pageSize || curDemo == ((curPage-1)*pageSize)-1) {
            werase(menu_win);
            if(curDemo == curPage*pageSize){
                curPage++;

            }else{
                curPage--;
            }
            box(menu_win, 0, 0);
            mvwaddch(menu_win, 0, maxLen + 5, ACS_TTEE);
            mvwaddch(menu_win, LINES-3, maxLen + 5, ACS_BTEE);
            mvwprintw(menu_win, 0, (maxLen-14)/2, " NXP Demo Experience ");
            mvwprintw(menu_win, LINES-3, (maxLen-8)/2, "%s", (" Page " + std::to_string(curPage) + " of " + std::to_string(totalPage) + " ").c_str());
            for(int i = (curPage-1)*(LINES-6); i < (curPage)*(LINES-6); i++){
                if(i >= (int)demo_names.size()){
                    break;
                }
                mvwprintw(menu_win, 2+i-((curPage-1)*(LINES-6)), 3, "%s", demo_names[i].c_str());
            }
            wmove(menu_win, 2+(selectDemo%(LINES-6)), 2);
            wchgat(menu_win, maxLen + 2 , A_STANDOUT, 2, NULL);
        }
        update_panels();
        doupdate();
        ch = getch();
    } while (true);
    clear();
    refresh();
    endwin();
    if (ch == KEY_RESIZE) {
        printf("Resize detected. Please relaunch the application.\n");
    }
    return 0;
}

