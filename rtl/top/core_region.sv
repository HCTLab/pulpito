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
`include "config.sv"

module core_region
  #(
    parameter AXI_ADDR_WIDTH       = 32,
    parameter AXI_DATA_WIDTH       = 64,
    parameter AXI_ID_MASTER_WIDTH  = 10,
    parameter AXI_ID_SLAVE_WIDTH   = 10,
    parameter AXI_USER_WIDTH       = 0,
    parameter DATA_RAM_SIZE        = 32768,
    parameter INSTR_RAM_SIZE       = 32768,
    parameter USE_ZERO_RISCY       = 1,
    parameter RISCY_RV32F          = 0,
    parameter ZERO_RV32M           = 1,
    parameter ZERO_RV32E           = 0
  )
  (
    // Clock and Reset
    input logic         clk,
    input logic         rst_n,

    input  logic        testmode_i,
    input  logic        fetch_enable_i,
    input  logic [31:0] irq_i,
    output logic        core_busy_o,
    input  logic        clock_gating_i,
    input  logic [31:0] boot_addr_i,

    AXI_BUS.Master      instr_master,
    AXI_BUS.Master      data_master,
    AXI_BUS.Master      dbg_master,
    DEBUG_BUS.Slave     debug,

    // JTAG signals
    input  logic        tck_i,
    input  logic        trstn_i,
    input  logic        tms_i,
    input  logic        tdi_i,
    output logic        tdo_o
  );

  localparam INSTR_ADDR_WIDTH = $clog2(INSTR_RAM_SIZE)+1; // to make space for the boot rom
  localparam DATA_ADDR_WIDTH  = $clog2(DATA_RAM_SIZE);
  localparam AXI_B_WIDTH      = $clog2(AXI_DATA_WIDTH/8); // AXI "Byte" width

  // signals from/to core (instr bus)
  logic                        core_instr_req;
  logic                        core_instr_gnt;
  logic                        core_instr_rvalid;
  logic [31:0]                 core_instr_addr;
  logic [31:0]                 core_instr_rdata;

  // signals to/from core2axi (data bus)
  logic                        core_data_req;
  logic                        core_data_gnt;
  logic                        core_data_rvalid;
  logic [31:0]                 core_data_addr;
  logic                        core_data_we;
  logic [3:0]                  core_data_be;
  logic [31:0]                 core_data_rdata;
  logic [31:0]                 core_data_wdata;

  enum logic [0:0] { AXI, RAM } lsu_resp_CS, lsu_resp_NS;

  AXI_BUS
  #(
    .AXI_ADDR_WIDTH   ( AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH   ( AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH     ( AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH   ( AXI_USER_WIDTH      )
  )
  data_master_int();

  AXI_BUS
  #(
    .AXI_ADDR_WIDTH   ( AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH   ( AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH     ( AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH   ( AXI_USER_WIDTH      )
  )
  instr_master_int();

  //----------------------------------------------------------------------------//
  // Core instantiation
  //----------------------------------------------------------------------------//

  logic [4:0] irq_id;
  always_comb begin
    irq_id = '0;
    for (int i = 0; i < 32; i+=1) begin
      if(irq_i[i]) begin
        irq_id = i[4:0];
      end
    end
  end
  
  //if(USE_ZERO_RISCY) 
  //begin: CORE
    
      zeroriscy_core
      #(
        .N_EXT_PERF_COUNTERS (     0      ),
        .RV32E               ( ZERO_RV32E ),
        .RV32M               ( ZERO_RV32M )
      )
      RISCV_CORE
      (
        .clk_i           ( clk               ),
        .rst_ni          ( rst_n             ),

        .clock_en_i      ( clock_gating_i    ),
        .test_en_i       ( testmode_i        ),

        .boot_addr_i     ( boot_addr_i       ),
        .core_id_i       ( 4'h0              ),
        .cluster_id_i    ( 6'h0              ),

        .instr_addr_o    ( core_instr_addr   ),
        .instr_req_o     ( core_instr_req    ),
        .instr_rdata_i   ( core_instr_rdata  ),
        .instr_gnt_i     ( core_instr_gnt    ),
        .instr_rvalid_i  ( core_instr_rvalid ),

        .data_addr_o     ( core_data_addr    ),
        .data_wdata_o    ( core_data_wdata   ),
        .data_we_o       ( core_data_we      ),
        .data_req_o      ( core_data_req     ),
        .data_be_o       ( core_data_be      ),
        .data_rdata_i    ( core_data_rdata   ),
        .data_gnt_i      ( core_data_gnt     ),
        .data_rvalid_i   ( core_data_rvalid  ),
        .data_err_i      ( 1'b0              ),

        .irq_i           ( (|irq_i)          ),
        .irq_id_i        ( irq_id            ),
        .irq_ack_o       (                   ),
        .irq_id_o        (                   ),

        .debug_req_i     ( debug.req         ),
        .debug_gnt_o     ( debug.gnt         ),
        .debug_rvalid_o  ( debug.rvalid      ),
        .debug_addr_i    ( debug.addr        ),
        .debug_we_i      ( debug.we          ),
        .debug_wdata_i   ( debug.wdata       ),
        .debug_rdata_o   ( debug.rdata       ),
        .debug_halted_o  (                   ),
        .debug_halt_i    ( 1'b0              ),
        .debug_resume_i  ( 1'b0              ),

        .fetch_enable_i  ( fetch_enable_i    ),
        .core_busy_o     ( core_busy_o       ),
        .ext_perf_counters_i (               )
      );
    //end 
  /*
  else 
    begin: CORE

      riscv_core
      #(
        .N_EXT_PERF_COUNTERS (     0       ),
        .FPU                 ( RISCY_RV32F ),
        .SHARED_FP           (     0       ),
        .SHARED_FP_DIVSQRT   (     2       )
      )
      RISCV_CORE
      (
        .clk_i           ( clk               ),
        .rst_ni          ( rst_n             ),
    
        .clock_en_i      ( clock_gating_i    ),
        .test_en_i       ( testmode_i        ),
    
        .boot_addr_i     ( boot_addr_i       ),
        .core_id_i       ( 4'h0              ),
        .cluster_id_i    ( 6'h0              ),
    
        .instr_addr_o    ( core_instr_addr   ),
        .instr_req_o     ( core_instr_req    ),
        .instr_rdata_i   ( core_instr_rdata  ),
        .instr_gnt_i     ( core_instr_gnt    ),
        .instr_rvalid_i  ( core_instr_rvalid ),
    
        .data_addr_o     ( core_data_addr    ),
        .data_wdata_o    ( core_data_wdata   ),
        .data_we_o       ( core_data_we      ),
        .data_req_o      ( core_data_req     ),
        .data_be_o       ( core_data_be      ),
        .data_rdata_i    ( core_data_rdata   ),
        .data_gnt_i      ( core_data_gnt     ),
        .data_rvalid_i   ( core_data_rvalid  ),
        .data_err_i      ( 1'b0              ),
    
        .irq_i           ( (|irq_i)          ),
        .irq_id_i        ( irq_id            ),
        .irq_ack_o       (                   ),
        .irq_id_o        (                   ),
        .irq_sec_i       ( 1'b0              ),
        .sec_lvl_o       (                   ),
    
        .debug_req_i     ( debug.req         ),
        .debug_gnt_o     ( debug.gnt         ),
        .debug_rvalid_o  ( debug.rvalid      ),
        .debug_addr_i    ( debug.addr        ),
        .debug_we_i      ( debug.we          ),
        .debug_wdata_i   ( debug.wdata       ),
        .debug_rdata_o   ( debug.rdata       ),
        .debug_halted_o  (                   ),
        .debug_halt_i    ( 1'b0              ),
        .debug_resume_i  ( 1'b0              ),
    
        .fetch_enable_i  ( fetch_enable_i    ),
        .core_busy_o     ( core_busy_o       ),
    
        // apu-interconnect
        // handshake signals
        .apu_master_req_o      (             ),
        .apu_master_ready_o    (             ),
        .apu_master_gnt_i      ( 1'b1        ),
        // request channel
        .apu_master_operands_o (             ),
        .apu_master_op_o       (             ),
        .apu_master_type_o     (             ),
        .apu_master_flags_o    (             ),
        // response channel
        .apu_master_valid_i    ( '0          ),
        .apu_master_result_i   ( '0          ),
        .apu_master_flags_i    ( '0          ),
    
        .ext_perf_counters_i   (             )
      );
    //end
  */

  //----------------------------------------------------------------------------//
  // Instruction AXI bridge
  //----------------------------------------------------------------------------//

  core2axi_wrap
  #(
    .AXI_ADDR_WIDTH   ( AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH   ( AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH     ( AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH   ( AXI_USER_WIDTH      ),
    .REGISTERED_GRANT ( "FALSE"             )
  )
  core2axi_instr_i
  (
    .clk_i         ( clk             ),
    .rst_ni        ( rst_n           ),

    .data_req_i    ( core_instr_req    ),
    .data_gnt_o    ( core_instr_gnt    ),
    .data_rvalid_o ( core_instr_rvalid ),
    .data_addr_i   ( core_instr_addr   ),
    .data_we_i     ( 1'b0              ),
    .data_be_i     ( 1'b0              ),
    .data_rdata_o  ( core_instr_rdata  ),
    .data_wdata_i  ( '0                ),

    .master        ( instr_master_int )
  );

  // AXI slice
  axi_slice_wrap
  #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH       ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH       ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH       ),
    .AXI_ID_WIDTH   ( AXI_ID_MASTER_WIDTH  ),
    .SLICE_DEPTH    ( 2                    )
  )
  axi_slice_instr_core2axi
  (
    .clk_i      ( clk             ),
    .rst_ni     ( rst_n           ),

    .test_en_i  ( testmode_i      ),

    .axi_slave  ( instr_master_int ),
    .axi_master ( instr_master     )
  );

  //----------------------------------------------------------------------------//
  // Data AXI bridge
  //----------------------------------------------------------------------------//

  core2axi_wrap
  #(
    .AXI_ADDR_WIDTH   ( AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH   ( AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH     ( AXI_ID_MASTER_WIDTH ),
    .AXI_USER_WIDTH   ( AXI_USER_WIDTH      ),
    .REGISTERED_GRANT ( "FALSE"             )
  )
  core2axi_data_i
  (
    .clk_i         ( clk              ),
    .rst_ni        ( rst_n            ),

    .data_req_i    ( core_data_req    ),
    .data_gnt_o    ( core_data_gnt    ),
    .data_rvalid_o ( core_data_rvalid ),
    .data_addr_i   ( core_data_addr   ),
    .data_we_i     ( core_data_we     ),
    .data_be_i     ( core_data_be     ),
    .data_rdata_o  ( core_data_rdata  ),
    .data_wdata_i  ( core_data_wdata  ),

    .master        ( data_master_int  )
  );

  // AXI slice
  axi_slice_wrap
  #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH       ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH       ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH       ),
    .AXI_ID_WIDTH   ( AXI_ID_MASTER_WIDTH  ),
    .SLICE_DEPTH    ( 2                    )
  )
  axi_slice_data_core2axi
  (
    .clk_i      ( clk             ),
    .rst_ni     ( rst_n           ),

    .test_en_i  ( testmode_i      ),

    .axi_slave  ( data_master_int ),
    .axi_master ( data_master     )
  );

  //----------------------------------------------------------------------------//
  // Advanced Debug Unit
  //----------------------------------------------------------------------------//

  // TODO: remove the debug connections to the core
  adv_dbg_if
  #(
    .NB_CORES           ( 1                   ),
    .AXI_ADDR_WIDTH     ( AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH     ( AXI_DATA_WIDTH      ),
    .AXI_USER_WIDTH     ( AXI_USER_WIDTH      ),
    .AXI_ID_WIDTH       ( AXI_ID_MASTER_WIDTH )
    )
  adv_dbg_if_i
  (
    .tms_pad_i   ( tms_i           ),
    .tck_pad_i   ( tck_i           ),
    .trstn_pad_i ( trstn_i         ),
    .tdi_pad_i   ( tdi_i           ),
    .tdo_pad_o   ( tdo_o           ),

    .test_mode_i ( testmode_i      ),

    .cpu_addr_o  (                 ),
    .cpu_data_i  ( '0              ),
    .cpu_data_o  (                 ),
    .cpu_bp_i    ( '0              ),
    .cpu_stall_o (                 ),
    .cpu_stb_o   (                 ),
    .cpu_we_o    (                 ),
    .cpu_ack_i   ( '1              ),
    .cpu_rst_o   (                 ),

    .axi_aclk             ( clk                  ),
    .axi_aresetn          ( rst_n                ),

    .axi_master_aw_valid  ( dbg_master.aw_valid  ),
    .axi_master_aw_addr   ( dbg_master.aw_addr   ),
    .axi_master_aw_prot   ( dbg_master.aw_prot   ),
    .axi_master_aw_region ( dbg_master.aw_region ),
    .axi_master_aw_len    ( dbg_master.aw_len    ),
    .axi_master_aw_size   ( dbg_master.aw_size   ),
    .axi_master_aw_burst  ( dbg_master.aw_burst  ),
    .axi_master_aw_lock   ( dbg_master.aw_lock   ),
    .axi_master_aw_cache  ( dbg_master.aw_cache  ),
    .axi_master_aw_qos    ( dbg_master.aw_qos    ),
    .axi_master_aw_id     ( dbg_master.aw_id     ),
    .axi_master_aw_user   ( dbg_master.aw_user   ),
    .axi_master_aw_ready  ( dbg_master.aw_ready  ),

    .axi_master_ar_valid  ( dbg_master.ar_valid  ),
    .axi_master_ar_addr   ( dbg_master.ar_addr   ),
    .axi_master_ar_prot   ( dbg_master.ar_prot   ),
    .axi_master_ar_region ( dbg_master.ar_region ),
    .axi_master_ar_len    ( dbg_master.ar_len    ),
    .axi_master_ar_size   ( dbg_master.ar_size   ),
    .axi_master_ar_burst  ( dbg_master.ar_burst  ),
    .axi_master_ar_lock   ( dbg_master.ar_lock   ),
    .axi_master_ar_cache  ( dbg_master.ar_cache  ),
    .axi_master_ar_qos    ( dbg_master.ar_qos    ),
    .axi_master_ar_id     ( dbg_master.ar_id     ),
    .axi_master_ar_user   ( dbg_master.ar_user   ),
    .axi_master_ar_ready  ( dbg_master.ar_ready  ),

    .axi_master_w_valid   ( dbg_master.w_valid   ),
    .axi_master_w_data    ( dbg_master.w_data    ),
    .axi_master_w_strb    ( dbg_master.w_strb    ),
    .axi_master_w_user    ( dbg_master.w_user    ),
    .axi_master_w_last    ( dbg_master.w_last    ),
    .axi_master_w_ready   ( dbg_master.w_ready   ),

    .axi_master_r_valid   ( dbg_master.r_valid   ),
    .axi_master_r_data    ( dbg_master.r_data    ),
    .axi_master_r_resp    ( dbg_master.r_resp    ),
    .axi_master_r_last    ( dbg_master.r_last    ),
    .axi_master_r_id      ( dbg_master.r_id      ),
    .axi_master_r_user    ( dbg_master.r_user    ),
    .axi_master_r_ready   ( dbg_master.r_ready   ),

    .axi_master_b_valid   ( dbg_master.b_valid   ),
    .axi_master_b_resp    ( dbg_master.b_resp    ),
    .axi_master_b_id      ( dbg_master.b_id      ),
    .axi_master_b_user    ( dbg_master.b_user    ),
    .axi_master_b_ready   ( dbg_master.b_ready   )
    );

  //----------------------------------------------------------------------------//
  // Test Code
  //----------------------------------------------------------------------------//

  // introduce random stalls for data access to stress LSU
`ifdef DATA_STALL_RANDOM
  random_stalls data_stalls_i
  (
    .clk           ( clk                     ),

    .core_req_i    ( CORE.RISCV_CORE.data_req_o   ),
    .core_addr_i   ( CORE.RISCV_CORE.data_addr_o  ),
    .core_we_i     ( CORE.RISCV_CORE.data_we_o    ),
    .core_be_i     ( CORE.RISCV_CORE.data_be_o    ),
    .core_wdata_i  ( CORE.RISCV_CORE.data_wdata_o ),
    .core_gnt_o    (                         ),
    .core_rdata_o  (                         ),
    .core_rvalid_o (                         ),

    .data_req_o    (                         ),
    .data_addr_o   (                         ),
    .data_we_o     (                         ),
    .data_be_o     (                         ),
    .data_wdata_o  (                         ),
    .data_gnt_i    ( core_data_gnt           ),
    .data_rdata_i  ( core_data_rdata         ),
    .data_rvalid_i ( core_data_rvalid        )
  );

  initial begin
    force CORE.RISCV_CORE.data_gnt_i    = data_stalls_i.core_gnt_o;
    force CORE.RISCV_CORE.data_rvalid_i = data_stalls_i.core_rvalid_o;
    force CORE.RISCV_CORE.data_rdata_i  = data_stalls_i.core_rdata_o;

    force core_data_req   = data_stalls_i.data_req_o;
    force core_data_addr  = data_stalls_i.data_addr_o;
    force core_data_we    = data_stalls_i.data_we_o;
    force core_data_be    = data_stalls_i.data_be_o;
    force core_data_wdata = data_stalls_i.data_wdata_o;
  end
`endif

  // introduce random stalls for instruction access to stress instruction
  // fetcher
`ifdef INSTR_STALL_RANDOM
  random_stalls instr_stalls_i
  (
    .clk           ( clk                     ),

    .core_req_i    ( CORE.RISCV_CORE.instr_req_o  ),
    .core_addr_i   ( CORE.RISCV_CORE.instr_addr_o ),
    .core_we_i     (                         ),
    .core_be_i     (                         ),
    .core_wdata_i  (                         ),
    .core_gnt_o    (                         ),
    .core_rdata_o  (                         ),
    .core_rvalid_o (                         ),

    .data_req_o    (                         ),
    .data_addr_o   (                         ),
    .data_we_o     (                         ),
    .data_be_o     (                         ),
    .data_wdata_o  (                         ),
    .data_gnt_i    ( core_instr_gnt          ),
    .data_rdata_i  ( core_instr_rdata        ),
    .data_rvalid_i ( core_instr_rvalid       )
  );

  initial begin
    force CORE.RISCV_CORE.instr_gnt_i    = instr_stalls_i.core_gnt_o;
    force CORE.RISCV_CORE.instr_rvalid_i = instr_stalls_i.core_rvalid_o;
    force CORE.RISCV_CORE.instr_rdata_i  = instr_stalls_i.core_rdata_o;

    force core_instr_req  = instr_stalls_i.data_req_o;
    force core_instr_addr = instr_stalls_i.data_addr_o;
  end
`endif

endmodule
