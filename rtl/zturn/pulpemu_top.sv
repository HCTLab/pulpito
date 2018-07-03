// Copyright 2018 EPS Universidad Autónoma de Madrid.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`timescale 1 ps / 1 ps

`include "clocking.vh"
`include "../top/axi_bus.sv"

`define USE_ZERO_RISCY          1
`define RISCY_RV32F             0
`define ZERO_RV32M              1
`define ZERO_RV32E              0

`define AXI_ADDR_WIDTH         32
`define AXI_DATA_WIDTH         32
`define AXI_ID_MASTER_WIDTH     2
`define AXI_ID_SLAVE_WIDTH      4
`define AXI_USER_WIDTH          1

module pulpemu_top
  (
    DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    
    ext_tck_i,
    ext_trstn_i,
    ext_tdi_i,
    ext_tms_i,
    ext_tdo_o,

    uart_tx,      // UART from RiscV domain
    uart_rx,      // UART from RiscV domain

    clk
  );

  inout  [14:0] DDR_addr;
  inout  [2:0]  DDR_ba;
  inout         DDR_cas_n;
  inout         DDR_ck_n;
  inout         DDR_ck_p;
  inout         DDR_cke;
  inout         DDR_cs_n;
  inout  [3:0]  DDR_dm;
  inout  [31:0] DDR_dq;
  inout  [3:0]  DDR_dqs_n;
  inout  [3:0]  DDR_dqs_p;
  inout         DDR_odt;
  inout         DDR_ras_n;
  inout         DDR_reset_n;
  inout         DDR_we_n;
  
  inout         FIXED_IO_ddr_vrn;
  inout         FIXED_IO_ddr_vrp;
  inout  [53:0] FIXED_IO_mio;
  inout         FIXED_IO_ps_clk;
  inout         FIXED_IO_ps_porb;
  inout         FIXED_IO_ps_srstb;

  input         ext_tck_i;
  input         ext_trstn_i;
  input         ext_tdi_i;
  input         ext_tms_i;
  output        ext_tdo_o;

  output        uart_tx;
  input         uart_rx;
  
  input         clk;

  // ----------------------- WIRES -----------------------

  wire [14:0] DDR_addr;
  wire [2:0]  DDR_ba;
  wire        DDR_cas_n;
  wire        DDR_ck_n;
  wire        DDR_ck_p;
  wire        DDR_cke;
  wire        DDR_cs_n;
  wire [3:0]  DDR_dm;
  wire [31:0] DDR_dq;
  wire [3:0]  DDR_dqs_n;
  wire [3:0]  DDR_dqs_p;
  wire        DDR_odt;
  wire        DDR_ras_n;
  wire        DDR_reset_n;
  wire        DDR_we_n;
  wire        FIXED_IO_ddr_vrn;
  wire        FIXED_IO_ddr_vrp;
  wire [53:0] FIXED_IO_mio;
  wire        FIXED_IO_ps_clk;
  wire        FIXED_IO_ps_porb;
  wire        FIXED_IO_ps_srstb;

  wire        fetch_enable;

  wire [31:0] jtag_emu_i;              // input to PS
  wire [31:0] jtag_emu_o;              // output from PS
  wire        tck_i;                   // input
  wire        trst_ni;                 // input
  wire        tms_i;                   // input
  wire        td_i;                    // input
  wire        td_o;                    // output

  wire        reset, reset_n, fclk_reset0_n;
  wire        host_clk, host_clk_i, gclk_i, gclk_fbout, mmcm_locked;

  AXI_BUS
  #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( `AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH      )
  )
  M_AXI_ACP();

  AXI_BUS
  #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( `AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH      )
  )
  M_AXI_GP();

  AXI_BUS
  #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( `AXI_ID_SLAVE_WIDTH  ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH      )
  )
  S_AXI_GP();

  // ----------------------- ASSIGN LOGIC -----------------------

  // JTAG signals for JTAG EMU
  //assign tck_i              = jtag_emu_o[0];
  //assign trst_ni            = jtag_emu_o[1];
  //assign td_i               = jtag_emu_o[2];
  //assign tms_i              = jtag_emu_o[3];
  assign jtag_emu_i[3:0]  = 4'b0;
  assign jtag_emu_i[4]    = td_o;
  assign jtag_emu_i[31:5] = 27'b0;

  // External JTAG
  assign tck_i            = ext_tck_i;
  assign trst_ni          = ext_trstn_i;
  assign td_i             = ext_tdi_i;
  assign tms_i            = ext_tms_i;
  assign ext_tdo_o        = td_o;
  
  assign reset            = !fclk_reset0_n || !mmcm_locked;
  assign reset_n          = !reset;
  assign fetch_enable     =  reset_n;
  
  // Clock buffering & generation from internal MMCME
  IBUFG  ibufg_gclk 
  (
    .I ( clk    ), 
    .O ( gclk_i )
  );
  
  MMCME2_BASE 
  #(
    .BANDWIDTH          ( "OPTIMIZED"      ),
    .CLKFBOUT_MULT_F    ( `RC_CLK_MULT     ),
    .CLKFBOUT_PHASE     ( 0.0              ),
    .CLKIN1_PERIOD      ( `ZYNQ_CLK_PERIOD ),
    .CLKOUT1_DIVIDE     ( 1                ),
    .CLKOUT2_DIVIDE     ( 1                ),
    .CLKOUT3_DIVIDE     ( 1                ),
    .CLKOUT4_DIVIDE     ( 1                ),
    .CLKOUT5_DIVIDE     ( 1                ),
    .CLKOUT6_DIVIDE     ( 1                ),
    .CLKOUT0_DIVIDE_F   ( `RC_CLK_DIVIDE   ),
    .CLKOUT0_DUTY_CYCLE ( 0.5              ),
    .CLKOUT1_DUTY_CYCLE ( 0.5              ),
    .CLKOUT2_DUTY_CYCLE ( 0.5              ),
    .CLKOUT3_DUTY_CYCLE ( 0.5              ),
    .CLKOUT4_DUTY_CYCLE ( 0.5              ),
    .CLKOUT5_DUTY_CYCLE ( 0.5              ),
    .CLKOUT6_DUTY_CYCLE ( 0.5              ),
    .CLKOUT0_PHASE      ( 0.0              ),
    .CLKOUT1_PHASE      ( 0.0              ),
    .CLKOUT2_PHASE      ( 0.0              ),
    .CLKOUT3_PHASE      ( 0.0              ),
    .CLKOUT4_PHASE      ( 0.0              ),
    .CLKOUT5_PHASE      ( 0.0              ),
    .CLKOUT6_PHASE      ( 0.0              ),
    .CLKOUT4_CASCADE    ( "FALSE"          ),
    .DIVCLK_DIVIDE      ( 1                ),
    .REF_JITTER1        ( 0.0              ),
    .STARTUP_WAIT       ( "FALSE"          )
  ) 
  MMCME2_BASE_inst 
  (
    .CLKOUT0            ( host_clk_i       ),
    .CLKOUT0B           (                  ),
    .CLKOUT1            (                  ),
    .CLKOUT1B           (                  ),
    .CLKOUT2            (                  ),
    .CLKOUT2B           (                  ),
    .CLKOUT3            (                  ),
    .CLKOUT3B           (                  ),
    .CLKOUT4            (                  ),
    .CLKOUT5            (                  ),
    .CLKOUT6            (                  ),
    .CLKFBOUT           ( gclk_fbout       ),
    .CLKFBOUTB          (                  ),
    .LOCKED             ( mmcm_locked      ),
    .CLKIN1             ( gclk_i           ),
    .PWRDWN             ( 1'b0             ),
    .RST                ( 1'b0             ),
    .CLKFBIN            ( gclk_fbout       )
  );
  
  BUFG  bufg_host_clk 
  (
    .I ( host_clk_i ), 
    .O ( host_clk   )
  );

  // Zynq Processing System 7
  zynq_ps_wrapper  zynq_ps_wrapper_i 
  (
    .CFLK_CLK0          (                     ),   // PLL generated clock from PS7 not used
                                              
    .DDR_addr           ( DDR_addr            ),
    .DDR_ba             ( DDR_ba              ),
    .DDR_cas_n          ( DDR_cas_n           ),
    .DDR_ck_n           ( DDR_ck_n            ),
    .DDR_ck_p           ( DDR_ck_p            ),
    .DDR_cke            ( DDR_cke             ),
    .DDR_cs_n           ( DDR_cs_n            ),
    .DDR_dm             ( DDR_dm              ),
    .DDR_dq             ( DDR_dq              ),
    .DDR_dqs_n          ( DDR_dqs_n           ),
    .DDR_dqs_p          ( DDR_dqs_p           ),
    .DDR_odt            ( DDR_odt             ),
    .DDR_ras_n          ( DDR_ras_n           ),
    .DDR_reset_n        ( DDR_reset_n         ),
    .DDR_we_n           ( DDR_we_n            ),
                                              
    .EXT_CLK_IN         ( host_clk            ),
    .FCLK_RESET0_N      ( fclk_reset0_n       ),
                                              
    .FIXED_IO_ddr_vrn   ( FIXED_IO_ddr_vrn    ),
    .FIXED_IO_ddr_vrp   ( FIXED_IO_ddr_vrp    ),
    .FIXED_IO_mio       ( FIXED_IO_mio        ),
    .FIXED_IO_ps_clk    ( FIXED_IO_ps_clk     ),
    .FIXED_IO_ps_porb   ( FIXED_IO_ps_porb    ),
    .FIXED_IO_ps_srstb  ( FIXED_IO_ps_srstb   ),
                                              
     // Master AXI GP                         
    .M_AXI_GP_araddr    ( S_AXI_GP.ar_addr    ),
    .M_AXI_GP_arburst   ( S_AXI_GP.ar_burst   ),
    .M_AXI_GP_arcache   ( S_AXI_GP.ar_cache   ),
    .M_AXI_GP_arid      ( S_AXI_GP.ar_id      ),
    .M_AXI_GP_arlen     ( S_AXI_GP.ar_len     ),
    .M_AXI_GP_arlock    ( S_AXI_GP.ar_lock    ),
    .M_AXI_GP_arprot    ( S_AXI_GP.ar_prot    ),
    .M_AXI_GP_arqos     ( S_AXI_GP.ar_qos     ),
    .M_AXI_GP_arready   ( S_AXI_GP.ar_ready   ),
    .M_AXI_GP_arregion  ( S_AXI_GP.ar_region  ),
    .M_AXI_GP_arsize    ( S_AXI_GP.ar_size    ),
    .M_AXI_GP_arvalid   ( S_AXI_GP.ar_valid   ),
                                              
    .M_AXI_GP_awaddr    ( S_AXI_GP.aw_addr    ),
    .M_AXI_GP_awburst   ( S_AXI_GP.aw_burst   ),
    .M_AXI_GP_awcache   ( S_AXI_GP.aw_cache   ),
    .M_AXI_GP_awid      ( S_AXI_GP.aw_id      ),
    .M_AXI_GP_awlen     ( S_AXI_GP.aw_len     ),
    .M_AXI_GP_awlock    ( S_AXI_GP.aw_lock    ),
    .M_AXI_GP_awprot    ( S_AXI_GP.aw_prot    ),
    .M_AXI_GP_awqos     ( S_AXI_GP.aw_qos     ),
    .M_AXI_GP_awready   ( S_AXI_GP.aw_ready   ),
    .M_AXI_GP_awregion  ( S_AXI_GP.aw_region  ),
    .M_AXI_GP_awsize    ( S_AXI_GP.aw_size    ),
    .M_AXI_GP_awvalid   ( S_AXI_GP.aw_valid   ),
                                              
    .M_AXI_GP_bid       ( S_AXI_GP.b_id       ),
    .M_AXI_GP_bready    ( S_AXI_GP.b_ready    ),
    .M_AXI_GP_bresp     ( S_AXI_GP.b_resp     ),
    .M_AXI_GP_bvalid    ( S_AXI_GP.b_valid    ),
                                              
    .M_AXI_GP_rdata     ( S_AXI_GP.r_data     ),
    .M_AXI_GP_rid       ( S_AXI_GP.r_id       ),
    .M_AXI_GP_rlast     ( S_AXI_GP.r_last     ),
    .M_AXI_GP_rready    ( S_AXI_GP.r_ready    ),
    .M_AXI_GP_rresp     ( S_AXI_GP.r_resp     ),
    .M_AXI_GP_rvalid    ( S_AXI_GP.r_valid    ),
                                              
    .M_AXI_GP_wdata     ( S_AXI_GP.w_data     ),
    .M_AXI_GP_wlast     ( S_AXI_GP.w_last     ),
    .M_AXI_GP_wready    ( S_AXI_GP.w_ready    ),
    .M_AXI_GP_wstrb     ( S_AXI_GP.w_strb     ),
    .M_AXI_GP_wvalid    ( S_AXI_GP.w_valid    ),

     // Slave AXI ACP interface
    .S_AXI_ACP_araddr   ( M_AXI_ACP.ar_addr   ),
    .S_AXI_ACP_arburst  ( M_AXI_ACP.ar_burst  ),
    .S_AXI_ACP_arcache  ( M_AXI_ACP.ar_cache  ),
    //.S_AXI_ACP_arid     ( M_AXI_ACP.ar_id     ),
    .S_AXI_ACP_arlen    ( M_AXI_ACP.ar_len    ),
    .S_AXI_ACP_arlock   ( M_AXI_ACP.ar_lock   ),
    .S_AXI_ACP_arprot   ( M_AXI_ACP.ar_prot   ),
    .S_AXI_ACP_arqos    ( M_AXI_ACP.ar_qos    ),
    .S_AXI_ACP_arready  ( M_AXI_ACP.ar_ready  ),
    .S_AXI_ACP_arregion ( M_AXI_ACP.ar_region ),
    .S_AXI_ACP_arsize   ( M_AXI_ACP.ar_size   ),
    .S_AXI_ACP_arvalid  ( M_AXI_ACP.ar_valid  ),
                                              
    .S_AXI_ACP_awaddr   ( M_AXI_ACP.aw_addr   ),
    .S_AXI_ACP_awburst  ( M_AXI_ACP.aw_burst  ),
    .S_AXI_ACP_awcache  ( M_AXI_ACP.aw_cache  ),
    //.S_AXI_ACP_awid     ( M_AXI_ACP.aw_id     ),
    .S_AXI_ACP_awlen    ( M_AXI_ACP.aw_len    ),
    .S_AXI_ACP_awlock   ( M_AXI_ACP.aw_lock   ),
    .S_AXI_ACP_awprot   ( M_AXI_ACP.aw_prot   ),
    .S_AXI_ACP_awqos    ( M_AXI_ACP.aw_qos    ),
    .S_AXI_ACP_awready  ( M_AXI_ACP.aw_ready  ),
    .S_AXI_ACP_awregion ( M_AXI_ACP.aw_region ),
    .S_AXI_ACP_awsize   ( M_AXI_ACP.aw_size   ),
    .S_AXI_ACP_awvalid  ( M_AXI_ACP.aw_valid  ),
                                              
    //.S_AXI_ACP_bid      ( M_AXI_ACP.b_id      ),
    .S_AXI_ACP_bready   ( M_AXI_ACP.b_ready   ),
    .S_AXI_ACP_bresp    ( M_AXI_ACP.b_resp    ),
    .S_AXI_ACP_bvalid   ( M_AXI_ACP.b_valid   ),
                                              
    //.S_AXI_ACP_rid      ( M_AXI_ACP.r_id      ),
    .S_AXI_ACP_rdata    ( M_AXI_ACP.r_data    ),
    .S_AXI_ACP_rlast    ( M_AXI_ACP.r_last    ),
    .S_AXI_ACP_rready   ( M_AXI_ACP.r_ready   ),
    .S_AXI_ACP_rresp    ( M_AXI_ACP.r_resp    ),
    .S_AXI_ACP_rvalid   ( M_AXI_ACP.r_valid   ),
                                              
    .S_AXI_ACP_wdata    ( M_AXI_ACP.w_data    ),
    .S_AXI_ACP_wlast    ( M_AXI_ACP.w_last    ),
    .S_AXI_ACP_wready   ( M_AXI_ACP.w_ready   ),
    .S_AXI_ACP_wstrb    ( M_AXI_ACP.w_strb    ),
    .S_AXI_ACP_wvalid   ( M_AXI_ACP.w_valid   ),

     // Slave AXI GP interface
    .S_AXI_GP_araddr    ( M_AXI_GP.ar_addr    ),
    .S_AXI_GP_arburst   ( M_AXI_GP.ar_burst   ),
    .S_AXI_GP_arcache   ( M_AXI_GP.ar_cache   ),
    //.S_AXI_GP_arid      ( M_AXI_GP.ar_id      ),
    .S_AXI_GP_arlen     ( M_AXI_GP.ar_len     ),
    .S_AXI_GP_arlock    ( M_AXI_GP.ar_lock    ),
    .S_AXI_GP_arprot    ( M_AXI_GP.ar_prot    ),
    .S_AXI_GP_arqos     ( M_AXI_GP.ar_qos     ),
    .S_AXI_GP_arready   ( M_AXI_GP.ar_ready   ),
    .S_AXI_GP_arregion  ( M_AXI_GP.ar_region  ),
    .S_AXI_GP_arsize    ( M_AXI_GP.ar_size    ),
    .S_AXI_GP_arvalid   ( M_AXI_GP.ar_valid   ),
                                              
    .S_AXI_GP_awaddr    ( M_AXI_GP.aw_addr    ),
    .S_AXI_GP_awburst   ( M_AXI_GP.aw_burst   ),
    .S_AXI_GP_awcache   ( M_AXI_GP.aw_cache   ),
    //.S_AXI_GP_awid      ( M_AXI_GP.aw_id      ),
    .S_AXI_GP_awlen     ( M_AXI_GP.aw_len     ),
    .S_AXI_GP_awlock    ( M_AXI_GP.aw_lock    ),
    .S_AXI_GP_awprot    ( M_AXI_GP.aw_prot    ),
    .S_AXI_GP_awqos     ( M_AXI_GP.aw_qos     ),
    .S_AXI_GP_awready   ( M_AXI_GP.aw_ready   ),
    .S_AXI_GP_awregion  ( M_AXI_GP.aw_region  ),
    .S_AXI_GP_awsize    ( M_AXI_GP.aw_size    ),
    .S_AXI_GP_awvalid   ( M_AXI_GP.aw_valid   ),
                                              
    //.S_AXI_GP_bid       ( M_AXI_GP.b_id       ),
    .S_AXI_GP_bready    ( M_AXI_GP.b_ready    ),
    .S_AXI_GP_bresp     ( M_AXI_GP.b_resp     ),
    .S_AXI_GP_bvalid    ( M_AXI_GP.b_valid    ),
                                              
    //.S_AXI_GP_rid       ( M_AXI_GP.r_id       ),
    .S_AXI_GP_rdata     ( M_AXI_GP.r_data     ),
    .S_AXI_GP_rlast     ( M_AXI_GP.r_last     ),
    .S_AXI_GP_rready    ( M_AXI_GP.r_ready    ),
    .S_AXI_GP_rresp     ( M_AXI_GP.r_resp     ),
    .S_AXI_GP_rvalid    ( M_AXI_GP.r_valid    ),
                                              
    .S_AXI_GP_wdata     ( M_AXI_GP.w_data     ),
    .S_AXI_GP_wlast     ( M_AXI_GP.w_last     ),
    .S_AXI_GP_wready    ( M_AXI_GP.w_ready    ),
    .S_AXI_GP_wstrb     ( M_AXI_GP.w_strb     ),
    .S_AXI_GP_wvalid    ( M_AXI_GP.w_valid    )
  );

  // PULPino SoC
  pulpito 
  #(
    .USE_ZERO_RISCY    ( `USE_ZERO_RISCY ),
    .RISCY_RV32F       ( `RISCY_RV32F    ),
    .ZERO_RV32M        ( `ZERO_RV32M     ),
    .ZERO_RV32E        ( `ZERO_RV32E     )
  )
  pulpito_wrap_i
  (
    .clk               ( host_clk        ),
    .rst_n             ( reset_n         ),
                                         
    .fetch_enable_i    ( fetch_enable    ),
                                         
    .acp_master        ( M_AXI_ACP       ),
    .axi_master        ( M_AXI_GP        ),
    .axi_slave         ( S_AXI_GP        ),
                                         
    .uart_tx           ( uart_tx         ),
    .uart_rx           ( uart_rx         ),
    .uart_rts          (                 ),
    .uart_dtr          (                 ),
    .uart_cts          ( 1'b0            ),
    .uart_dsr          ( 1'b0            ),
                                         
    .tck_i             ( tck_i           ),
    .trstn_i           ( trst_ni         ),
    .tms_i             ( tms_i           ),
    .tdi_i             ( td_i            ),
    .tdo_o             ( td_o            )
  );

endmodule
