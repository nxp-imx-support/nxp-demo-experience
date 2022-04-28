# NXP Demo Experience

## Description

The NXP Demo Experience is an interface that enable the user to launch any NXP demonstration without command line. With this approach, by using the BSP Yocto support, the user is able to run the available demos using only a mouse connected to the board, or the touch screen support, if the display has it. 

For details on supported boards and how to get the NXP Demo Experience, please refer to the README on [meta-nxp-demo-experience](https://source.codeaurora.org/external/imxsupport/meta-nxp-demo-experience) or refer to Chapter 3 of the documentation for a manual install.

To see what demos are available and add demos to the NXP Demo Experience, please refer to the README.md on [nxp-demo-experience-demos-list](https://source.codeaurora.org/external/imxsupport/nxp-demo-experience-demos-list/).

## Developing the NXP Demo Experience

This repository contains the source code that is used to compile the NXP Demo Experience. To compile, users will need to use the [Qt Creator tool](https://www.qt.io/). For information on how to configure the cross compiler in Qt, please see Chapter 6 in the documentation.

In order to clone the NXP Demo Launcher source code, use the following command:
```bash
$ git clone https://source.codeaurora.org/external/imxsupport/nxp-demo-experience.git
```

For proper operation, you will also need the demo data. To clone this, use the following command:
```bash
$ git clone https://source.codeaurora.org/external/imxsupport/nxp-demo-experience-demos-list.git
```
After downloading, ensure that `DEMOPATH` in `engine/DemoPage.h` is the path of where `nxp-demo-experience-demos-list` is cloned for the demos to load correctly.


## How to Generates the NXP Demo Experience Documentation using AsciiDoc

Please note that these documents are no longer be updated and removed in the next update. For documentation, please visit https://github.com/NXP/nxp-demo-experience-assets/releases.

In order to generates the NXP Demo Experience documentation file, go to the `doc` directory and use the following commands:

```bash
$ cd doc
$ sudo apt-get install ruby
$ sudo gem install bundler
$ bundle install
$ ./doc-generator
```
