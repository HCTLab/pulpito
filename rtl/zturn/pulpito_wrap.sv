// Copyright 2018 EPS Universidad Autónoma de Madrid.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`include "../top/axi_bus.sv"

module pulpito
  #(
    parameter USE_ZERO_RISCY  = 1,
    parameter RISCY_RV32F     = 0,
    parameter ZERO_RV32M      = 1,
    parameter ZERO_RV32E      = 0
  )
  (
    input  logic              clk,
    input  logic              rst_n,
  
    input  logic              fetch_enable_i,

    // AXI buses
    AXI_BUS.Master            acp_master,
    AXI_BUS.Master            axi_master,
    AXI_BUS.Slave             axi_slave,
  
    output logic              uart_tx,
    input  logic              uart_rx,
    output logic              uart_rts,
    output logic              uart_dtr,
    input  logic              uart_cts,
    input  logic              uart_dsr,
  
    input  logic              tck_i,
    input  logic              trstn_i,
    input  logic              tms_i,
    input  logic              tdi_i,
    output logic              tdo_o
  );

  // PULP SoC
  pulpito_top
  #(
    .USE_ZERO_RISCY    ( USE_ZERO_RISCY ),
    .RISCY_RV32F       ( RISCY_RV32F    ),
    .ZERO_RV32M        ( ZERO_RV32M     ),
    .ZERO_RV32E        ( ZERO_RV32E     )
  )
  pulpito_i
  (
    .clk               ( clk               ),
    .rst_n             ( rst_n             ),

    .clk_sel_i         ( 1'b0              ),
    .clk_standalone_i  ( 1'b0              ),

    .testmode_i        ( 1'b0              ),
    .fetch_enable_i    ( fetch_enable_i    ),
    .scan_enable_i     ( 1'b0              ),

    // AXI buses
    .acp_master        ( acp_master        ),
    .axi_master        ( axi_master        ),
    .axi_slave         ( axi_slave         ),

    .spi_clk_i         ( clk               ),
    .spi_cs_i          ( 1'b0              ),
    .spi_mode_o        (                   ),
    .spi_sdo0_o        (                   ),
    .spi_sdo1_o        (                   ),
    .spi_sdo2_o        (                   ),
    .spi_sdo3_o        (                   ),
    .spi_sdi0_i        (                   ),
    .spi_sdi1_i        (                   ),
    .spi_sdi2_i        (                   ),
    .spi_sdi3_i        (                   ),

    .spi_master_clk_o  (                   ),
    .spi_master_csn0_o (                   ),
    .spi_master_csn1_o (                   ),
    .spi_master_csn2_o (                   ),
    .spi_master_csn3_o (                   ),
    .spi_master_mode_o (                   ),
    .spi_master_sdo0_o (                   ),
    .spi_master_sdo1_o (                   ),
    .spi_master_sdo2_o (                   ),
    .spi_master_sdo3_o (                   ),
    .spi_master_sdi0_i (                   ),
    .spi_master_sdi1_i (                   ),
    .spi_master_sdi2_i (                   ),
    .spi_master_sdi3_i (                   ),

    .uart_tx           ( uart_tx           ),
    .uart_rx           ( uart_rx           ),
    .uart_rts          ( uart_rts          ),
    .uart_dtr          ( uart_dtr          ),
    .uart_cts          ( uart_cts          ),
    .uart_dsr          ( uart_dsr          ),

    .scl_pad_i         (                   ),
    .scl_pad_o         (                   ),
    .scl_padoen_o      (                   ),
    .sda_pad_i         (                   ),
    .sda_pad_o         (                   ),
    .sda_padoen_o      (                   ),

    .gpio_in           (                   ),
    .gpio_out          (                   ),
    .gpio_dir          (                   ),
    .gpio_padcfg       (                   ),

    .tck_i             ( tck_i             ),
    .trstn_i           ( trstn_i           ),
    .tms_i             ( tms_i             ),
    .tdi_i             ( tdi_i             ),
    .tdo_o             ( tdo_o             ),

    .pad_cfg_o         (                   ),
    .pad_mux_o         (                   )
  );

endmodule
