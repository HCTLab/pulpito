// Copyright 2018 EPS Universidad Autónoma de Madrid.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`include "../axi_bus.sv"

`define REF_CLK_PERIOD         (2*15.25us)  // 32.786 kHz --> FLL reset value --> 50 MHz
`define CLK_PERIOD              20.00ns      // 50 MHz

`define EXIT_SUCCESS            0
`define EXIT_FAIL               1
`define EXIT_ERROR              -1

`define AXI_ADDR_WIDTH          32
`define AXI_DATA_WIDTH          32
`define AXI_ID_MASTER_WIDTH     2
`define AXI_ID_SLAVE_WIDTH      4
`define AXI_USER_WIDTH          1


module pulpsim_top;

  timeunit                      1ns;
  timeprecision                 1ps;

  parameter  CLK_USE_FLL      = 0;           // 0 or 1
  parameter  TEST             = "";          // Valid values are "" (NONE), "DEBUG"
  parameter  USE_ZERO_RISCY   = 1;
  parameter  RISCY_RV32F      = 0;
  parameter  ZERO_RV32M       = 1;
  parameter  ZERO_RV32E       = 0;

  int                exit_status = `EXIT_ERROR; // exit code, will be overwritten when successful

  logic              clk;
  logic              rst_n;
  logic              fetch_enable_i;

  logic              uart_tx;
  logic              uart_rx;
  logic              uart_rts;
  logic              uart_dtr;
  logic              uart_cts;
  logic              uart_dsr;
  
  logic              tck_i;
  logic              trstn_i;
  logic              tms_i;
  logic              tdi_i;
  logic              tdo_o;

  // AXI buses
  AXI_BUS
  #(
    .AXI_ADDR_WIDTH     ( `AXI_ADDR_WIDTH          ),
    .AXI_DATA_WIDTH     ( `AXI_DATA_WIDTH          ),
    .AXI_ID_WIDTH       ( `AXI_ID_MASTER_WIDTH     ),
    .AXI_USER_WIDTH     ( `AXI_USER_WIDTH          )
  )                                                
  acp_master();                                    
                                                   
  AXI_BUS                                          
  #(                                               
    .AXI_ADDR_WIDTH     ( `AXI_ADDR_WIDTH          ),
    .AXI_DATA_WIDTH     ( `AXI_DATA_WIDTH          ),
    .AXI_ID_WIDTH       ( `AXI_ID_MASTER_WIDTH     ),
    .AXI_USER_WIDTH     ( `AXI_USER_WIDTH          )
  )                                                
  axi_master();                                    
                                                   
  AXI_BUS                                          
  #(                                               
    .AXI_ADDR_WIDTH     ( `AXI_ADDR_WIDTH          ),
    .AXI_DATA_WIDTH     ( `AXI_DATA_WIDTH          ),
    .AXI_ID_WIDTH       ( `AXI_ID_SLAVE_WIDTH      ),
    .AXI_USER_WIDTH     ( `AXI_USER_WIDTH          )
  )
  axi_slave();

  // PULP SoC
  pulpito_top
  #(
    .USE_ZERO_RISCY     ( USE_ZERO_RISCY           ),
    .RISCY_RV32F        ( RISCY_RV32F              ),
    .ZERO_RV32M         ( ZERO_RV32M               ),
    .ZERO_RV32E         ( ZERO_RV32E               )
  )                                               
  pulpito_i                                       
  (                                               
    .clk                ( clk                      ),
    .rst_n              ( rst_n                    ),
                                                  
    .clk_sel_i          ( 1'b0                     ),
    .clk_standalone_i   ( 1'b0                     ),
                                                  
    .testmode_i         ( 1'b0                     ),
    .fetch_enable_i     ( fetch_enable_i           ),
    .scan_enable_i      ( 1'b0                     ),
                                                  
    // AXI buses                                  
    .acp_master         ( acp_master               ),
    .axi_master         ( axi_master               ),
    .axi_slave          ( axi_slave                ),
                                                  
    .spi_clk_i          ( clk                      ),
    .spi_cs_i           ( 1'b0                     ),
    .spi_mode_o         (                          ),
    .spi_sdo0_o         (                          ),
    .spi_sdo1_o         (                          ),
    .spi_sdo2_o         (                          ),
    .spi_sdo3_o         (                          ),
    .spi_sdi0_i         (                          ),
    .spi_sdi1_i         (                          ),
    .spi_sdi2_i         (                          ),
    .spi_sdi3_i         (                          ),
                                                  
    .spi_master_clk_o   (                          ),
    .spi_master_csn0_o  (                          ),
    .spi_master_csn1_o  (                          ),
    .spi_master_csn2_o  (                          ),
    .spi_master_csn3_o  (                          ),
    .spi_master_mode_o  (                          ),
    .spi_master_sdo0_o  (                          ),
    .spi_master_sdo1_o  (                          ),
    .spi_master_sdo2_o  (                          ),
    .spi_master_sdo3_o  (                          ),
    .spi_master_sdi0_i  (                          ),
    .spi_master_sdi1_i  (                          ),
    .spi_master_sdi2_i  (                          ),
    .spi_master_sdi3_i  (                          ),
                                                  
    .uart_tx            ( uart_tx                  ),
    .uart_rx            ( uart_rx                  ),
    .uart_rts           ( uart_rts                 ),
    .uart_dtr           ( uart_dtr                 ),
    .uart_cts           ( uart_cts                 ),
    .uart_dsr           ( uart_dsr                 ),
                                                  
    .scl_pad_i          (                          ),
    .scl_pad_o          (                          ),
    .scl_padoen_o       (                          ),
    .sda_pad_i          (                          ),
    .sda_pad_o          (                          ),
    .sda_padoen_o       (                          ),
                                                  
    .gpio_in            (                          ),
    .gpio_out           (                          ),
    .gpio_dir           (                          ),
    .gpio_padcfg        (                          ),
                                                  
    .tck_i              ( tck_i                    ),
    .trstn_i            ( trstn_i                  ),
    .tms_i              ( tms_i                    ),
    .tdi_i              ( tdi_i                    ),
    .tdo_o              ( tdo_o                    ),
                                                  
    .pad_cfg_o          (                          ),
    .pad_mux_o          (                          )
  );

  // PULP memories
  axi_slave_mem
  #(
    .C_MEM_SIZE         ( 65536                    ),
    .C_MEM_FILE         ( "program.mem"            ),
    .C_S_AXI_DATA_WIDTH ( `AXI_DATA_WIDTH          ),
    .C_S_AXI_ADDR_WIDTH ( 18                       )
  )                                               
  mem_instr_i                                     
  (                                               
    .S_AXI_ACLK         ( clk                      ),
    .S_AXI_ARESETN      ( rst_n                    ),
    .S_AXI_AWADDR       ( axi_master.aw_addr[17:0] ),
    .S_AXI_AWVALID      ( axi_master.aw_valid      ),
    .S_AXI_AWREADY      ( axi_master.aw_ready      ),
    .S_AXI_ARADDR       ( axi_master.ar_addr[17:0] ),
    .S_AXI_ARVALID      ( axi_master.ar_valid      ),
    .S_AXI_ARREADY      ( axi_master.ar_ready      ),
    .S_AXI_WDATA        ( axi_master.w_data        ),
    .S_AXI_WSTRB        ( axi_master.w_strb        ),
    .S_AXI_WVALID       ( axi_master.w_valid       ),
    .S_AXI_WREADY       ( axi_master.w_ready       ),
    .S_AXI_RDATA        ( axi_master.r_data        ),
    .S_AXI_RRESP        ( axi_master.r_resp        ),
    .S_AXI_RVALID       ( axi_master.r_valid       ),
    .S_AXI_RREADY       ( axi_master.r_ready       ),
    .S_AXI_BRESP        ( axi_master.b_resp        ),
    .S_AXI_BVALID       ( axi_master.b_valid       ),
    .S_AXI_BREADY       ( axi_master.b_ready       )
  );

  axi_slave_mem
  #(
    .C_MEM_SIZE         ( 65536                    ),
    .C_MEM_FILE         ( "program.mem"            ),
    .C_S_AXI_DATA_WIDTH ( `AXI_DATA_WIDTH          ),
    .C_S_AXI_ADDR_WIDTH ( 18                       )
  )                                               
  mem_data_i                                     
  (                                               
    .S_AXI_ACLK         ( clk                      ),
    .S_AXI_ARESETN      ( rst_n                    ),
    .S_AXI_AWADDR       ( acp_master.aw_addr[17:0] ),
    .S_AXI_AWVALID      ( acp_master.aw_valid      ),
    .S_AXI_AWREADY      ( acp_master.aw_ready      ),
    .S_AXI_ARADDR       ( acp_master.ar_addr[17:0] ),
    .S_AXI_ARVALID      ( acp_master.ar_valid      ),
    .S_AXI_ARREADY      ( acp_master.ar_ready      ),
    .S_AXI_WDATA        ( acp_master.w_data        ),
    .S_AXI_WSTRB        ( acp_master.w_strb        ),
    .S_AXI_WVALID       ( acp_master.w_valid       ),
    .S_AXI_WREADY       ( acp_master.w_ready       ),
    .S_AXI_RDATA        ( acp_master.r_data        ),
    .S_AXI_RRESP        ( acp_master.r_resp        ),
    .S_AXI_RVALID       ( acp_master.r_valid       ),
    .S_AXI_RREADY       ( acp_master.r_ready       ),
    .S_AXI_BRESP        ( acp_master.b_resp        ),
    .S_AXI_BVALID       ( acp_master.b_valid       ),
    .S_AXI_BREADY       ( acp_master.b_ready       )
  );

  generate
    if (CLK_USE_FLL) begin
      initial
      begin
        #(`REF_CLK_PERIOD/2);
        clk = 1'b1;
        forever clk = #(`REF_CLK_PERIOD/2) ~clk;
      end
    end else begin
      initial
      begin
        #(`CLK_PERIOD/2);
        clk = 1'b1;
        forever clk = #(`CLK_PERIOD/2) ~clk;
      end
    end
  endgenerate

  initial
  begin
    int i;

    $display("Using %s core", USE_ZERO_RISCY ? "zero-riscy" : "ri5cy");

    // Set slave AXI bus signals (no accessess by now) to avoid spurious acceses from ARM side
    axi_slave.aw_valid   = 1'b0;
    axi_slave.aw_addr    = 32'h0000_0000;
    axi_slave.aw_id      = 0;
    axi_slave.aw_prot    = 0;
    axi_slave.aw_region  = 0;
    axi_slave.aw_len     = 0;
    axi_slave.aw_size    = 0;
    axi_slave.aw_burst   = 0;
    axi_slave.aw_lock    = 0;
    axi_slave.aw_cache   = 0;
    axi_slave.aw_qos     = 0;
    axi_slave.aw_user    = 0;

    axi_slave.ar_valid   = 1'b0;
    axi_slave.ar_addr    = 32'h0000_0000;
    axi_slave.ar_id      = 0;
    axi_slave.ar_prot    = 0;
    axi_slave.ar_region  = 0;
    axi_slave.ar_len     = 0;
    axi_slave.ar_size    = 0;
    axi_slave.ar_burst   = 0;
    axi_slave.ar_lock    = 0;
    axi_slave.ar_cache   = 0;
    axi_slave.ar_qos     = 0;
    axi_slave.ar_user    = 0;

    axi_slave.w_valid    = 1'b0;
    axi_slave.w_strb     = 0;
    axi_slave.w_data     = 32'h0000_0000;
    axi_slave.w_user     = 0;
    axi_slave.w_last     = 0;
    
    axi_slave.r_ready    = 1'b1;
    axi_slave.b_ready    = 1'b1;
    
    // Set master AXI bus (for instructions) ID
    axi_master.r_id      = 0;
    axi_master.b_id      = 0;

    // Set master AXI bus (for data) ID
    acp_master.r_id      = 0;
    acp_master.b_id      = 0;
    
    // Disconnect JTAG
    tck_i                = 1'b0;
    trstn_i              = 1'b1;
    tms_i                = 1'b1;
    tdi_i                = 1'b1;
    
    // Prepare other peripherals
    uart_rx              = 1'b1;

    // ------------------------ START SIMULATION ------------------------

    // Assert reset for 20 cycles
    trstn_i              = 1'b0;
    rst_n                = 1'b0;
    fetch_enable_i       = 1'b0;
    #(`CLK_PERIOD*20);
    trstn_i              = 1'b1;
    rst_n                = 1'b1;
    
    // Start fetching instructions from RiscV (after 20 cycles from reset deassertion) for many cycles
    #(`CLK_PERIOD*20);
    fetch_enable_i       = 1'b1;
    #(`CLK_PERIOD*1000);
  
    // Simulate an access from PS7 to APB
    axi_slave.ar_addr    = 32'h4A10_0000;
    axi_slave.ar_size    = 2;
    axi_slave.ar_valid   = 1'b1;
    #(`CLK_PERIOD);
    axi_slave.ar_addr    = 32'h0000_0000;
    axi_slave.ar_size    = 0;
    axi_slave.ar_valid   = 1'b0;

    // Wait some more cycles before ending simulation    
    #(`CLK_PERIOD*20);
    $fflush();
    $stop();
  end

endmodule
