// Copyright 2018 EPS Universidad Autónoma de Madrid.
// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`include "axi_bus.sv"
`include "debug_bus.sv"

`define AXI_ADDR_WIDTH         32
`define AXI_DATA_WIDTH         32
`define AXI_ID_MASTER_WIDTH     2
`define AXI_ID_SLAVE_WIDTH      4
`define AXI_USER_WIDTH          1

module pulpito_top
  #(
    parameter USE_ZERO_RISCY  = 1,
    parameter RISCY_RV32F     = 0,
    parameter ZERO_RV32M      = 1,
    parameter ZERO_RV32E      = 0
  )
  (
    // Clock and Reset
    input  logic              clk,
    input  logic              rst_n,

    input  logic              clk_sel_i,
    input  logic              clk_standalone_i,
    input  logic              testmode_i,
    input  logic              fetch_enable_i,
    input  logic              scan_enable_i,
    
    // AXI buses
    AXI_BUS.Master            acp_master,
    AXI_BUS.Master            axi_master,
    AXI_BUS.Slave             axi_slave,

    // SPI Slave
    input  logic              spi_clk_i,
    input  logic              spi_cs_i,
    output logic [1:0]        spi_mode_o,
    output logic              spi_sdo0_o,
    output logic              spi_sdo1_o,
    output logic              spi_sdo2_o,
    output logic              spi_sdo3_o,
    input  logic              spi_sdi0_i,
    input  logic              spi_sdi1_i,
    input  logic              spi_sdi2_i,
    input  logic              spi_sdi3_i,

    // SPI Master
    output logic              spi_master_clk_o,
    output logic              spi_master_csn0_o,
    output logic              spi_master_csn1_o,
    output logic              spi_master_csn2_o,
    output logic              spi_master_csn3_o,
    output logic [1:0]        spi_master_mode_o,
    output logic              spi_master_sdo0_o,
    output logic              spi_master_sdo1_o,
    output logic              spi_master_sdo2_o,
    output logic              spi_master_sdo3_o,
    input  logic              spi_master_sdi0_i,
    input  logic              spi_master_sdi1_i,
    input  logic              spi_master_sdi2_i,
    input  logic              spi_master_sdi3_i,

    input  logic              scl_pad_i,
    output logic              scl_pad_o,
    output logic              scl_padoen_o,
    input  logic              sda_pad_i,
    output logic              sda_pad_o,
    output logic              sda_padoen_o,

    output logic              uart_tx,
    input  logic              uart_rx,
    output logic              uart_rts,
    output logic              uart_dtr,
    input  logic              uart_cts,
    input  logic              uart_dsr,

    input  logic       [31:0] gpio_in,
    output logic       [31:0] gpio_out,
    output logic       [31:0] gpio_dir,
    output logic [31:0] [5:0] gpio_padcfg,

    // JTAG signals
    input  logic              tck_i,
    input  logic              trstn_i,
    input  logic              tms_i,
    input  logic              tdi_i,
    output logic              tdo_o,

    // PULPito specific pad config
    output logic [31:0] [5:0] pad_cfg_o,
    output logic       [31:0] pad_mux_o
  );

  logic        clk_int;

  logic        fetch_enable_int;
  logic        core_busy_int;
  logic        clk_gate_core_int;
  logic [31:0] irq_to_core_int;

  logic        lock_fll_int;
  logic        cfgreq_fll_int;
  logic        cfgack_fll_int;
  logic [1:0]  cfgad_fll_int;
  logic [31:0] cfgd_fll_int;
  logic [31:0] cfgq_fll_int;
  logic        cfgweb_n_fll_int;
  logic        rstn_int;
  logic [31:0] boot_addr_int;

  //----------------------------------------------------------------------------
  // Buses
  //----------------------------------------------------------------------------
  
  // Note: ID_WITH must be increased accoording axi_bus implementation
  
  AXI_BUS
  #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH       ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH       ),
    .AXI_ID_WIDTH   ( `AXI_ID_MASTER_WIDTH  ),   
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH       )
  )
  masters[2:0]();

  AXI_BUS
  #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH        ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH        ),
    .AXI_ID_WIDTH   ( `AXI_ID_SLAVE_WIDTH    ),   
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH        )
  )
  slaves[2:0]();
  
  AXI_BUS
  #(
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH        ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH        ),
    .AXI_ID_WIDTH   ( `AXI_ID_MASTER_WIDTH   ),   
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH        )
  )
  axi_spi_master();

  DEBUG_BUS
  debug();

  //----------------------------------------------------------------------------
  // Clock and reset generation
  //----------------------------------------------------------------------------
  
  clk_rst_gen
  clk_rst_gen_i
  (
      .clk_i            ( clk              ),
      .rstn_i           ( rst_n            ),

      .clk_sel_i        ( clk_sel_i        ),
      .clk_standalone_i ( clk_standalone_i ),
      .testmode_i       ( testmode_i       ),
      .scan_i           ( 1'b0             ),
      .scan_o           (                  ),
      .scan_en_i        ( scan_enable_i    ),

      .fll_req_i        ( cfgreq_fll_int   ),
      .fll_wrn_i        ( cfgweb_n_fll_int ),
      .fll_add_i        ( cfgad_fll_int    ),
      .fll_data_i       ( cfgd_fll_int     ),
      .fll_ack_o        ( cfgack_fll_int   ),
      .fll_r_data_o     ( cfgq_fll_int     ),
      .fll_lock_o       ( lock_fll_int     ),

      .clk_o            ( clk_int          ),
      .rstn_o           ( rstn_int         )

    );
    
  //----------------------------------------------------------------------------
  // AXI connections from/to top
  //----------------------------------------------------------------------------
  
  assign masters[1].aw_valid  = axi_slave.aw_valid  ; 
  assign masters[1].aw_id     = axi_slave.aw_id     ; 
  assign masters[1].aw_prot   = axi_slave.aw_prot   ; 
  assign masters[1].aw_region = axi_slave.aw_region ; 
  assign masters[1].aw_qos    = axi_slave.aw_qos    ; 
  assign masters[1].aw_cache  = axi_slave.aw_cache  ; 
  assign masters[1].aw_lock   = axi_slave.aw_lock   ; 
  assign masters[1].aw_burst  = axi_slave.aw_burst  ; 
  assign masters[1].aw_size   = axi_slave.aw_size   ; 
  assign masters[1].aw_len    = axi_slave.aw_len    ; 
  assign masters[1].aw_addr   = axi_slave.aw_addr   ; 
  assign masters[1].aw_user   = axi_slave.aw_user   ; 
  assign axi_slave.aw_ready   = masters[1].aw_ready ; 
                                                     
  assign masters[1].w_valid   = axi_slave.w_valid   ; 
  assign masters[1].w_data    = axi_slave.w_data    ; 
  assign masters[1].w_strb    = axi_slave.w_strb    ; 
  assign masters[1].w_last    = axi_slave.w_last    ; 
  assign masters[1].w_user    = axi_slave.w_user    ; 
  assign axi_slave.w_ready    = masters[1].w_ready  ; 
                                                     
  assign axi_slave.b_valid    = masters[1].b_valid  ; 
  assign axi_slave.b_id       = masters[1].b_id     ; 
  assign axi_slave.b_resp     = masters[1].b_resp   ; 
  assign axi_slave.b_user     = masters[1].b_user   ; 
  assign masters[1].b_ready   = axi_slave.b_ready   ; 
                                                     
  assign masters[1].ar_valid  = axi_slave.ar_valid  ; 
  assign masters[1].ar_id     = axi_slave.ar_id     ; 
  assign masters[1].ar_prot   = axi_slave.ar_prot   ; 
  assign masters[1].ar_region = axi_slave.ar_region ; 
  assign masters[1].ar_qos    = axi_slave.ar_qos    ; 
  assign masters[1].ar_cache  = axi_slave.ar_cache  ; 
  assign masters[1].ar_lock   = axi_slave.ar_lock   ; 
  assign masters[1].ar_burst  = axi_slave.ar_burst  ; 
  assign masters[1].ar_size   = axi_slave.ar_size   ; 
  assign masters[1].ar_len    = axi_slave.ar_len    ; 
  assign masters[1].ar_addr   = axi_slave.ar_addr   ; 
  assign masters[1].ar_user   = axi_slave.ar_user   ; 
  assign axi_slave.ar_ready   = masters[1].ar_ready ; 
                                                     
  assign axi_slave.r_valid    = masters[1].r_valid  ; 
  assign axi_slave.r_id       = masters[1].r_id     ; 
  assign axi_slave.r_data     = masters[1].r_data   ; 
  assign axi_slave.r_resp     = masters[1].r_resp   ; 
  assign axi_slave.r_last     = masters[1].r_last   ; 
  assign axi_slave.r_user     = masters[1].r_user   ; 
  assign masters[1].r_ready   = axi_slave.r_ready   ; 
 
  //----------------------------------------------------------------------------
  
  assign acp_master.aw_valid  = slaves[0].aw_valid  ; 
  assign acp_master.aw_id     = slaves[0].aw_id     ; 
  assign acp_master.aw_prot   = slaves[0].aw_prot   ; 
  assign acp_master.aw_region = slaves[0].aw_region ; 
  assign acp_master.aw_qos    = slaves[0].aw_qos    ; 
  assign acp_master.aw_cache  = slaves[0].aw_cache  ; 
  assign acp_master.aw_lock   = slaves[0].aw_lock   ; 
  assign acp_master.aw_burst  = slaves[0].aw_burst  ; 
  assign acp_master.aw_size   = slaves[0].aw_size   ; 
  assign acp_master.aw_len    = slaves[0].aw_len    ; 
  assign acp_master.aw_addr   = slaves[0].aw_addr   ; 
  assign acp_master.aw_user   = slaves[0].aw_user   ; 
  assign slaves[0].aw_ready   = acp_master.aw_ready ; 
                                                     
  assign acp_master.w_valid   = slaves[0].w_valid   ; 
  assign acp_master.w_data    = slaves[0].w_data    ; 
  assign acp_master.w_strb    = slaves[0].w_strb    ; 
  assign acp_master.w_last    = slaves[0].w_last    ; 
  assign acp_master.w_user    = slaves[0].w_user    ; 
  assign slaves[0].w_ready    = acp_master.w_ready  ; 
                                                     
  assign slaves[0].b_valid    = acp_master.b_valid  ; 
  assign slaves[0].b_id       = acp_master.b_id     ; 
  assign slaves[0].b_resp     = acp_master.b_resp   ; 
  assign slaves[0].b_user     = acp_master.b_user   ; 
  assign acp_master.b_ready   = slaves[0].b_ready   ; 
                                                     
  assign acp_master.ar_valid  = slaves[0].ar_valid  ; 
  assign acp_master.ar_id     = slaves[0].ar_id     ; 
  assign acp_master.ar_prot   = slaves[0].ar_prot   ; 
  assign acp_master.ar_region = slaves[0].ar_region ; 
  assign acp_master.ar_qos    = slaves[0].ar_qos    ; 
  assign acp_master.ar_cache  = slaves[0].ar_cache  ; 
  assign acp_master.ar_lock   = slaves[0].ar_lock   ; 
  assign acp_master.ar_burst  = slaves[0].ar_burst  ; 
  assign acp_master.ar_size   = slaves[0].ar_size   ; 
  assign acp_master.ar_len    = slaves[0].ar_len    ; 
  assign acp_master.ar_addr   = slaves[0].ar_addr   ; 
  assign acp_master.ar_user   = slaves[0].ar_user   ; 
  assign slaves[0].ar_ready   = acp_master.ar_ready ; 
                                                     
  assign slaves[0].r_valid    = acp_master.r_valid  ; 
  assign slaves[0].r_id       = acp_master.r_id     ; 
  assign slaves[0].r_data     = acp_master.r_data   ; 
  assign slaves[0].r_resp     = acp_master.r_resp   ; 
  assign slaves[0].r_last     = acp_master.r_last   ; 
  assign slaves[0].r_user     = acp_master.r_user   ; 
  assign acp_master.r_ready   = slaves[0].r_ready   ; 
 
  //----------------------------------------------------------------------------
  // Core region
  //----------------------------------------------------------------------------
  
  core_region
  #(
    .AXI_ADDR_WIDTH       ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH       ( `AXI_DATA_WIDTH      ),
    .AXI_ID_MASTER_WIDTH  ( `AXI_ID_MASTER_WIDTH ),
    .AXI_ID_SLAVE_WIDTH   ( `AXI_ID_SLAVE_WIDTH  ),
    .AXI_USER_WIDTH       ( `AXI_USER_WIDTH      ),
    
    .USE_ZERO_RISCY       (  USE_ZERO_RISCY      ),
    .RISCY_RV32F          (  RISCY_RV32F         ),
    .ZERO_RV32M           (  ZERO_RV32M          ),
    .ZERO_RV32E           (  ZERO_RV32E          )
  )
  core_region_i
  (
    .clk            ( clk_int           ),
    .rst_n          ( rstn_int          ),

    .testmode_i     ( testmode_i        ),
    .fetch_enable_i ( fetch_enable_int  ),
    .irq_i          ( irq_to_core_int   ),
    .core_busy_o    ( core_busy_int     ),
    .clock_gating_i ( clk_gate_core_int ),
    .boot_addr_i    ( boot_addr_int     ),

    .instr_master   ( axi_master        ),
    .data_master    ( masters[0]        ),
    .dbg_master     ( masters[2]        ),
    .debug          ( debug             ),

    .tck_i          ( tck_i             ),
    .trstn_i        ( trstn_i           ),
    .tms_i          ( tms_i             ),
    .tdi_i          ( tdi_i             ),
    .tdo_o          ( tdo_o             )
  );

  //----------------------------------------------------------------------------
  // Peripherals
  //----------------------------------------------------------------------------
  
  peripherals
  #(
    .AXI_ADDR_WIDTH      ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH      ( `AXI_DATA_WIDTH      ),
    .AXI_MASTER_ID_WIDTH ( `AXI_ID_MASTER_WIDTH ),
    .AXI_SLAVE_ID_WIDTH  ( `AXI_ID_SLAVE_WIDTH  ),
    .AXI_USER_WIDTH      ( `AXI_USER_WIDTH      )
  )
  peripherals_i
  (
    .clk_i           ( clk_int           ),
    .rst_n           ( rstn_int          ),

    .axi_spi_master  ( axi_spi_master    ),
    .debug           ( debug             ),

    .spi_clk_i       ( spi_clk_i         ),
    .testmode_i      ( testmode_i        ),
    .spi_cs_i        ( spi_cs_i          ),
    .spi_mode_o      ( spi_mode_o        ),
    .spi_sdo0_o      ( spi_sdo0_o        ),
    .spi_sdo1_o      ( spi_sdo1_o        ),
    .spi_sdo2_o      ( spi_sdo2_o        ),
    .spi_sdo3_o      ( spi_sdo3_o        ),
    .spi_sdi0_i      ( spi_sdi0_i        ),
    .spi_sdi1_i      ( spi_sdi1_i        ),
    .spi_sdi2_i      ( spi_sdi2_i        ),
    .spi_sdi3_i      ( spi_sdi3_i        ),

    .slave           ( slaves[1]        ),

    .uart_tx         ( uart_tx           ),
    .uart_rx         ( uart_rx           ),
    .uart_rts        ( uart_rts          ),
    .uart_dtr        ( uart_dtr          ),
    .uart_cts        ( uart_cts          ),
    .uart_dsr        ( uart_dsr          ),

    .spi_master_clk  ( spi_master_clk_o  ),
    .spi_master_csn0 ( spi_master_csn0_o ),
    .spi_master_csn1 ( spi_master_csn1_o ),
    .spi_master_csn2 ( spi_master_csn2_o ),
    .spi_master_csn3 ( spi_master_csn3_o ),
    .spi_master_mode ( spi_master_mode_o ),
    .spi_master_sdo0 ( spi_master_sdo0_o ),
    .spi_master_sdo1 ( spi_master_sdo1_o ),
    .spi_master_sdo2 ( spi_master_sdo2_o ),
    .spi_master_sdo3 ( spi_master_sdo3_o ),
    .spi_master_sdi0 ( spi_master_sdi0_i ),
    .spi_master_sdi1 ( spi_master_sdi1_i ),
    .spi_master_sdi2 ( spi_master_sdi2_i ),
    .spi_master_sdi3 ( spi_master_sdi3_i ),

    .scl_pad_i       ( scl_pad_i         ),
    .scl_pad_o       ( scl_pad_o         ),
    .scl_padoen_o    ( scl_padoen_o      ),
    .sda_pad_i       ( sda_pad_i         ),
    .sda_pad_o       ( sda_pad_o         ),
    .sda_padoen_o    ( sda_padoen_o      ),

    .gpio_in         ( gpio_in           ),
    .gpio_out        ( gpio_out          ),
    .gpio_dir        ( gpio_dir          ),
    .gpio_padcfg     ( gpio_padcfg       ),

    .core_busy_i     ( core_busy_int     ),
    .irq_o           ( irq_to_core_int   ),
    .fetch_enable_i  ( fetch_enable_i    ),
    .fetch_enable_o  ( fetch_enable_int  ),
    .clk_gate_core_o ( clk_gate_core_int ),

    .fll1_req_o      ( cfgreq_fll_int    ),
    .fll1_wrn_o      ( cfgweb_n_fll_int  ),
    .fll1_add_o      ( cfgad_fll_int     ),
    .fll1_wdata_o    ( cfgd_fll_int      ),
    .fll1_ack_i      ( cfgack_fll_int    ),
    .fll1_rdata_i    ( cfgq_fll_int      ),
    .fll1_lock_i     ( lock_fll_int      ),
    
    .pad_cfg_o       ( pad_cfg_o         ),
    .pad_mux_o       ( pad_mux_o         ),
    .boot_addr_o     ( boot_addr_int     )
  );

  //----------------------------------------------------------------------------
  // Axi node
  //----------------------------------------------------------------------------

  axi_node_intf_wrap
  #(
    .NB_MASTER      ( 3                    ),
    .NB_SLAVE       ( 3                    ),
    .AXI_ADDR_WIDTH ( `AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( `AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( `AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH ( `AXI_USER_WIDTH      )
  )
  axi_interconnect_i
  (
    .clk       ( clk_int    ),
    .rst_n     ( rstn_int   ),
    .test_en_i ( testmode_i ),

    .master    ( slaves     ),
    .slave     ( masters    ),

    // slaves[0] : 256 MB assigned (0000_0000 ~ 0FFF_FFFF) - Data & Instructions at DDR at Zynq PS7 AXI bus
    // slaves[1] : 128 KB assigned (4A10_0000 ~ 4A11_FFFF) - APB peripherals (which must be also accesed from M_AXI_GP0 from PS7)
    // slaves[2] : 256 MB assigned (8000_0000 ~ 8FFF_FFFF) - RFU
    
    // NOTE: Address block order:  slaves[N], ..., slaves[1], slaves[0]
    .start_addr_i ( { 32'h8000_0000, 32'h4A10_0000, 32'h0000_0000 } ),
    .end_addr_i   ( { 32'h8FFF_FFFF, 32'h4A11_FFFF, 32'h0FFF_FFFF } )
  );

endmodule

