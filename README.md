# PULPito

PULPito is a hardware platform, based on [PULPino platform](https://www.pulp-platform.org), 
used to develop new hybrid operating systems where assembly code from ARM and RiscV architectures 
can coexist in the same binary (two ISAs into a single binary).

PULPito can be deployed in a [ZTurn board](http://www.myirtech.com/list.asp?id=502) which includes 
a Zynq XC7Z020 chipset, containing two Cortex-A9 ARM processors (in the silicon) and a 
[Zery-Riscy](https://github.com/pulp-platform/zero-riscy) (RiscV RV32IMC) processor in the 
programmable logic.

PULPito, as well as its parent PULPino, contains a broad set of peripherals, including I2S, I2C, 
SPI and UART. The platform internal devices can be accessed from outside via JTAG and SPI which 
allows pre-loading RAMs with executable code. All platform processors (ARM and RiscV) can access 
all resources in the platform with a flat addressing mode.

This work will be presented in [JCER2018](http://www.jornadassarteco.org/descripcion/?anyo=2018&simposio=jcer2018).

## Getting Started

### Prerequisites

PULPito has the following requirements:

- [ZTurn board](http://www.myirtech.com/list.asp?id=502).
- Vivado 2017.1 or higher (includes ARM toolchain).
- Official [RiscV toolchain](https://github.com/riscv/riscv-gnu-toolchain).

### Installing

1. Pull all sources from main repository and all sources from sub-repositories (GIT sub-modules)
   $ git clone --recursive https://github.com/HCTLab/pulpito

2. Add a new ZTurn Vivado board template by copying all files from "fpga/vivado/boards/2017.1" into your Vivado execution path.

3. Open Vivado and select "Tools / Run Tcl Script...". 
   Please choose "fpga/vivado/project/pulpito.tcl" and press "OK".

4. Add the following design source file (by right-clicking "Add sources.." and then "Add or create design sources"):
   "fpga/vivado/zynq_ps/zynq_ps.bd"

5. Find "zynq_ps_i" instance and create a HDL wrapper (by right-clicking "Create HDL Wrapper...").

6. Just simulate, synthesize or generate a bitstream to begin with software development...

## Setup from scracth

To build a Vivado project from scratch, please follow next steps:

1. Copy all files from 'fpga/vivado/boards/2017.1' folder into your Vivado execution path.
   This folder includes a new template for ZTurn board.
   Create a new blank project based on ZTurn board.

2. Pull all sources from sub-repositories (GIT sub-modules)

   $ git clone --recursive https://github.com/HCTLab/pulpito

3. Add all (source) files from the following paths into your new project. DO NOT ADD SOURCES FROM SUB-DIRECTORIES:

   * rtl/adv_dbg_if/rtl
   * rtl/apb_event_unit
   * rtl/apb_event_unit/include
   * rtl/apb_fll_if
   * rtl/apb_gpio
   * rtl/apb_i2c
   * rtl/apb_node
   * rtl/apb_pulpino
   * rtl/apb_spi_master
   * rtl/apb_timer
   * rtl/apb_uart
   * rtl/apb2per
   * rtl/axi_node
   * rtl/axi_slice
   * rtl/axi_slice_dc
   * rtl/axi_spi_master
   * rtl/axi_spi_slave
   * rtl/axi2apb
   * rtl/core2axi
   * rtl/zriscy
   * rtl/zriscy/includes
   * rtl/zturn
   * rtl/top/components
   * rtl/top/sim
   * rtl/top
   
4. Mark following files with 'Verilog header' type (right click over file and then properties)

   * rtl/top/config.sv
   * rtl/top/axi_bus.sv
   * rtl/top/apb_bus.sv
   * rtl/top/debug_bus.sv
   * rtl/axi_node/defines.sv
   * rtl/zriscy/include/zeroriscy_config.sv
   * rtl/zriscy/include/zeroriscy_tracer_defines.sv
   * rtl/adv_dbg_if/rtl/adbg_defines.v
   * rtl/adv_dbg_if/rtl/adbg_lint_defines.v
   * rtl/adv_dbg_if/rtl/adbg_or1k_defines.v
   * rtl/adv_dbg_if/rtl/adbg_tap_defines.v
   * rtl/adv_dbg_if/rtl/adbg_axi_defines.v
   * rtl/apb_event_unit/include/defines_event_unit.sv
   * rtl/zturn/clocking.vh
   
5. Add the following 'define' in 'Tools/Settings/Simulation' at 'Verilog options':

   TRACE_EXECUTION = 1

6. Add the following option in 'Tools/Settings/Synthesis' at 'Verilog options':

   -verilog_define PULP_FPGA_EMUL=1

7. Select 'pulpemu_top' as the top module to be synthesized.
   Select 'pulpsim_top' as the top module to be simulated.

8. Add the component block 'fpga/vivado/zynq_ps/zynq_ps' into you project.
   You can also create this design block from scratch if you preserve same interface names.

9. Remove unreferenced files.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. 
For the versions available, see the [tags on this repository](https://github.com/HCTLab/pulpito/tags). 

## Authors

* **ETH Zurich and University of Bologna** - *Initial work* - [Pulp-Platform](https://github.com/pulp-platform)
* **Integrated Systems Laboratory (IIS)** - [ETH Zurich](http://pulp.ethz.ch)
* **Dipartimento di Elettronica, Politecnico di Milano** - [University of Bologna](http://projects.eees.dei.unibo.it/pulp-project/)
* **Juancho Andrés** - *Universidad Autónoma de Madrid* - [HCTLab](http://www.hctlab.com)

## License

This project is licensed under the [SolderPad open source license](http://solderpad.org/licenses/SHL-0.51/) - 
see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* This work is one of the basic pieces from my thesis. Thanks to [Javier Garrido](http://www.hctlab.com/people/person.aspx?user=javier.garrido) for his support and help.
* RiscV ecosystem is clearly a new paradigm for embedded systems due to its freedom.
* However my thesis is based on the idea that proprietary or free ISA can coexist in a same silicon and each ISA can take advantage of the other.
* (Maybe) Hybrid systems will be considered common architectures in the future...
* And of course, thanks to my wife Isabel and my childs, who share many nights in the dark supporting my hobby.
