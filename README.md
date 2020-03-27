# NXP Demo Experience

## Description

The NXP Demo Experience is an interface that enable the user to launch any NXP demonstration 
without command line. With this approach, by using the BSP Yocto support, the user is able 
to run the available demos using only a mouse connected to the board, or the touch screen support, if the display has it.

The next sections describes how to clone the source code and how to generates the NXP Demo Experience documentation, which contains all 
the details around this tool.

## Cloning the NXP Demo Experience and Its Submodule

The NXP Demo Experience is composed by two different project: the Qt interface and the demo supported list. 

In order to clone the NXP Demo Launcher source code, use the following command:

git clone https://source.codeaurora.org/external/imx/nxp_demo_experience.git

As this source code only includes the Qt interface, in order to enable the demos, update the demo supported list with the commands below: 

```bash
$ cd nxp_demo_experience
$ git submodule init
$ git submodule update
```

You can check more details on how to add and support more demos at the NXP Demo Experience documentation.

## How to Generates the NXP Demo Experience Documentation using AsciiDoc

In order to generates the NXP Demo Experience documentation file, go to the `doc` directory and use the following commands:

```bash
$ cd doc
$ apt-get install ruby
$ gem install bundler
$ bundle install
$ ./doc-generator
```

## Release Details

In order to track all the BSP, devices, and demos supported, please, check the ```doc/chapters/variables``` files, according to the version release:

### V2.0:

Supported Devices:
. i.MX 8MM EVK B0
. i.MX 8QXP MEK B0
. i.MX 7ULP EVK A0

BSP:
. L4.19.35_1.0.0

Yocto Release:
. Thud
. Warrior
