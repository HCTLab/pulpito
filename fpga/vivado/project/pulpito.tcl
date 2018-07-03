#
# Vivado (TM) v2017.1 (64-bit)
#
# pulpito.tcl: Tcl script for re-creating project 'pulpito'
#
# This file contains the Vivado Tcl commands for re-creating the project to the state*
# when this script was generated. In order to re-create the project, please source this
# file in the Vivado Tcl Shell.
#
# * Note that the runs in the created project will be configured the same way as the
#   original project, however they will not be launched automatically. To regenerate the
#   run results please launch the synthesis/implementation runs as needed.
#
#*****************************************************************************************
# NOTE: In order to use this script for source control purposes, please make sure that the
#       following files are added to the source control system:-
#
# 1. This project restoration tcl script (pulpito.tcl) that was generated.
#
# 2. The following source(s) files that were local or imported into the original project.
#    (Please see the '$orig_proj_dir' and '$origin_dir' variable setting below at the start of the script)
#
#    <none>
#
# 3. The following remote source files that were added to the original project:-
#
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_crc32.v"
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_tap_defines.v"
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_tap_top.v"
#    "pulpito/rtl/axi_slice_dc/dc_data_buffer.v"
#    "pulpito/rtl/axi_slice_dc/dc_full_detector.v"
#    "pulpito/rtl/axi_slice_dc/dc_synchronizer.v"
#    "pulpito/rtl/axi_slice_dc/dc_token_ring.v"
#    "pulpito/rtl/axi_slice_dc/dc_token_ring_fifo_din.v"
#    "pulpito/rtl/axi_slice_dc/dc_token_ring_fifo_dout.v"
#    "pulpito/rtl/top/config.sv"
#    "pulpito/rtl/top/apb_bus.sv"
#    "pulpito/rtl/top/debug_bus.sv"
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_axi_biu.sv"
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_defines.v"
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_axi_defines.v"
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_axi_module.sv"
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_or1k_biu.sv"
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_or1k_defines.v"
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_or1k_module.sv"
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_or1k_status_reg.sv"
#    "pulpito/rtl/adv_dbg_if/rtl/adbg_top.sv"
#    "pulpito/rtl/adv_dbg_if/rtl/adv_dbg_if.sv"
#    "pulpito/rtl/apb2per/apb2per.sv"
#    "pulpito/rtl/apb_event_unit/include/defines_event_unit.sv"
#    "pulpito/rtl/apb_event_unit/apb_event_unit.sv"
#    "pulpito/rtl/apb_fll_if/apb_fll_if.sv"
#    "pulpito/rtl/apb_gpio/apb_gpio.sv"
#    "pulpito/rtl/apb_i2c/i2c_master_defines.sv"
#    "pulpito/rtl/apb_i2c/apb_i2c.sv"
#    "pulpito/rtl/apb_node/apb_node.sv"
#    "pulpito/rtl/apb_node/apb_node_wrap.sv"
#    "pulpito/rtl/apb_pulpino/apb_pulpino.sv"
#    "pulpito/rtl/apb_spi_master/apb_spi_master.sv"
#    "pulpito/rtl/apb_timer/apb_timer.sv"
#    "pulpito/rtl/axi2apb/axi2apb.sv"
#    "pulpito/rtl/axi2apb/axi2apb32.sv"
#    "pulpito/rtl/top/axi_bus.sv"
#    "pulpito/rtl/top/axi2apb_wrap.sv"
#    "pulpito/rtl/axi_node/axi_AR_allocator.sv"
#    "pulpito/rtl/axi_node/axi_AW_allocator.sv"
#    "pulpito/rtl/axi_node/axi_ArbitrationTree.sv"
#    "pulpito/rtl/axi_node/axi_BR_allocator.sv"
#    "pulpito/rtl/axi_node/axi_BW_allocator.sv"
#    "pulpito/rtl/axi_node/axi_DW_allocator.sv"
#    "pulpito/rtl/axi_node/axi_FanInPrimitive_Req.sv"
#    "pulpito/rtl/axi_node/axi_RR_Flag_Req.sv"
#    "pulpito/rtl/axi_node/axi_address_decoder_AR.sv"
#    "pulpito/rtl/axi_node/axi_address_decoder_AW.sv"
#    "pulpito/rtl/axi_node/axi_address_decoder_BR.sv"
#    "pulpito/rtl/axi_node/axi_address_decoder_BW.sv"
#    "pulpito/rtl/axi_node/axi_address_decoder_DW.sv"
#    "pulpito/rtl/axi_slice/axi_ar_buffer.sv"
#    "pulpito/rtl/axi_slice/axi_aw_buffer.sv"
#    "pulpito/rtl/axi_slice/axi_b_buffer.sv"
#    "pulpito/rtl/axi_node/axi_multiplexer.sv"
#    "pulpito/rtl/axi_node/axi_node.sv"
#    "pulpito/rtl/top/axi_node_intf_wrap.sv"
#    "pulpito/rtl/axi_slice/axi_r_buffer.sv"
#    "pulpito/rtl/axi_node/axi_request_block.sv"
#    "pulpito/rtl/axi_node/axi_response_block.sv"
#    "pulpito/rtl/axi_slice/axi_slice.sv"
#    "pulpito/rtl/top/axi_slice_wrap.sv"
#    "pulpito/rtl/axi_spi_slave/axi_spi_slave.sv"
#    "pulpito/rtl/top/axi_spi_slave_wrap.sv"
#    "pulpito/rtl/axi_slice/axi_w_buffer.sv"
#    "pulpito/rtl/top/clk_rst_gen.sv"
#    "pulpito/rtl/top/components/cluster_clock_gating.sv"
#    "pulpito/rtl/top/components/cluster_clock_inverter.sv"
#    "pulpito/rtl/top/components/cluster_clock_mux2.sv"
#    "pulpito/rtl/core2axi/core2axi.sv"
#    "pulpito/rtl/top/core2axi_wrap.sv"
#    "pulpito/rtl/top/core_region.sv"
#    "pulpito/rtl/top/components/generic_fifo.sv"
#    "pulpito/rtl/apb_event_unit/generic_service_unit.sv"
#    "pulpito/rtl/apb_i2c/i2c_master_bit_ctrl.sv"
#    "pulpito/rtl/apb_i2c/i2c_master_byte_ctrl.sv"
#    "pulpito/rtl/top/periph_bus_wrap.sv"
#    "pulpito/rtl/top/peripherals.sv"
#    "pulpito/rtl/top/components/pulp_clock_inverter.sv"
#    "pulpito/rtl/top/components/pulp_clock_mux2.sv"
#    "pulpito/rtl/top/pulpito_top.sv"
#    "pulpito/rtl/zturn/pulpito_wrap.sv"
#    "pulpito/rtl/top/components/rstgen.sv"
#    "pulpito/rtl/apb_event_unit/sleep_unit.sv"
#    "pulpito/rtl/apb_spi_master/spi_master_apb_if.sv"
#    "pulpito/rtl/axi_spi_master/spi_master_clkgen.sv"
#    "pulpito/rtl/axi_spi_master/spi_master_controller.sv"
#    "pulpito/rtl/axi_spi_master/spi_master_fifo.sv"
#    "pulpito/rtl/axi_spi_master/spi_master_rx.sv"
#    "pulpito/rtl/axi_spi_master/spi_master_tx.sv"
#    "pulpito/rtl/axi_spi_slave/spi_slave_axi_plug.sv"
#    "pulpito/rtl/axi_spi_slave/spi_slave_cmd_parser.sv"
#    "pulpito/rtl/axi_spi_slave/spi_slave_controller.sv"
#    "pulpito/rtl/axi_spi_slave/spi_slave_dc_fifo.sv"
#    "pulpito/rtl/axi_spi_slave/spi_slave_regs.sv"
#    "pulpito/rtl/axi_spi_slave/spi_slave_rx.sv"
#    "pulpito/rtl/axi_spi_slave/spi_slave_syncro.sv"
#    "pulpito/rtl/axi_spi_slave/spi_slave_tx.sv"
#    "pulpito/rtl/apb_timer/timer.sv"
#    "pulpito/rtl/zriscy/include/zeroriscy_defines.sv"
#    "pulpito/rtl/zriscy/include/zeroriscy_config.sv"
#    "pulpito/rtl/zriscy/zeroriscy_alu.sv"
#    "pulpito/rtl/zriscy/zeroriscy_compressed_decoder.sv"
#    "pulpito/rtl/zriscy/zeroriscy_controller.sv"
#    "pulpito/rtl/zriscy/zeroriscy_core.sv"
#    "pulpito/rtl/zriscy/zeroriscy_cs_registers.sv"
#    "pulpito/rtl/zriscy/zeroriscy_debug_unit.sv"
#    "pulpito/rtl/zriscy/zeroriscy_decoder.sv"
#    "pulpito/rtl/zriscy/zeroriscy_ex_block.sv"
#    "pulpito/rtl/zriscy/zeroriscy_fetch_fifo.sv"
#    "pulpito/rtl/zriscy/zeroriscy_id_stage.sv"
#    "pulpito/rtl/zriscy/zeroriscy_if_stage.sv"
#    "pulpito/rtl/zriscy/zeroriscy_int_controller.sv"
#    "pulpito/rtl/zriscy/zeroriscy_load_store_unit.sv"
#    "pulpito/rtl/zriscy/zeroriscy_multdiv_fast.sv"
#    "pulpito/rtl/zriscy/zeroriscy_multdiv_slow.sv"
#    "pulpito/rtl/zriscy/zeroriscy_prefetch_buffer.sv"
#    "pulpito/rtl/zriscy/zeroriscy_register_file_ff.sv"
#    "pulpito/rtl/apb_uart/apb_uart.vhd"
#    "pulpito/rtl/apb_uart/slib_clock_div.vhd"
#    "pulpito/rtl/apb_uart/slib_counter.vhd"
#    "pulpito/rtl/apb_uart/slib_edge_detect.vhd"
#    "pulpito/rtl/apb_uart/slib_fifo.vhd"
#    "pulpito/rtl/apb_uart/slib_input_filter.vhd"
#    "pulpito/rtl/apb_uart/slib_input_sync.vhd"
#    "pulpito/rtl/apb_uart/slib_mv_filter.vhd"
#    "pulpito/rtl/apb_uart/uart_baudgen.vhd"
#    "pulpito/rtl/apb_uart/uart_interrupt.vhd"
#    "pulpito/rtl/apb_uart/uart_receiver.vhd"
#    "pulpito/rtl/apb_uart/uart_transmitter.vhd"
#    "pulpito/rtl/zturn/clocking.vh"
#    "pulpito/rtl/zturn/pulpemu_top.sv"
#    "pulpito/rtl/zriscy/zeroriscy_tracer.sv"
#    "pulpito/rtl/top/apu_defines.sv"
#    "pulpito/rtl/zturn/zturn.xdc"
#    "pulpito/rtl/zriscy/include/zeroriscy_tracer_defines.sv"
#    "pulpito/rtl/top/sim/axi_slave_mem.vhd"
#    "pulpito/rtl/top/sim/pulpsim_top.sv"
#    "pulpito/rtl/zriscy/zeroriscy_tracer.sv"
#
#*****************************************************************************************

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir [ file dirname [ file normalize [ info script ] ] ]
variable script_file
set script_file "pulpito.tcl"

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/../pulpito"]"

# Create project
create_project pulpito ./pulpito -part xc7z020clg400-1

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Reconstruct message rules
# None

# Set project properties
set obj [get_projects pulpito]
set_property -name "board_part" -value "myirtech.com:zturn:part0:1.0" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/pulpito.cache/ip" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC XPM_MEMORY" -objects $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_crc32.v"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_tap_defines.v"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_tap_top.v"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice_dc/dc_data_buffer.v"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice_dc/dc_full_detector.v"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice_dc/dc_synchronizer.v"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice_dc/dc_token_ring.v"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice_dc/dc_token_ring_fifo_din.v"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice_dc/dc_token_ring_fifo_dout.v"]"\
 "[file normalize "$origin_dir/../../../rtl/top/config.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/apb_bus.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/debug_bus.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_axi_biu.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_defines.v"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_axi_defines.v"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_axi_module.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_or1k_biu.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_or1k_defines.v"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_or1k_module.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_or1k_status_reg.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_top.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/adv_dbg_if/rtl/adv_dbg_if.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb2per/apb2per.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_event_unit/include/defines_event_unit.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_event_unit/apb_event_unit.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_fll_if/apb_fll_if.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_gpio/apb_gpio.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_i2c/i2c_master_defines.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_i2c/apb_i2c.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_node/apb_node.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_node/apb_node_wrap.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_pulpino/apb_pulpino.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_spi_master/apb_spi_master.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_timer/apb_timer.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi2apb/axi2apb.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi2apb/axi2apb32.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/axi_bus.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/axi2apb_wrap.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_AR_allocator.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_AW_allocator.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_ArbitrationTree.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_BR_allocator.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_BW_allocator.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_DW_allocator.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_FanInPrimitive_Req.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_RR_Flag_Req.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_address_decoder_AR.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_address_decoder_AW.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_address_decoder_BR.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_address_decoder_BW.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_address_decoder_DW.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice/axi_ar_buffer.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice/axi_aw_buffer.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice/axi_b_buffer.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_multiplexer.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_node.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/axi_node_intf_wrap.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice/axi_r_buffer.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_request_block.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_node/axi_response_block.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice/axi_slice.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/axi_slice_wrap.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_slave/axi_spi_slave.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/axi_spi_slave_wrap.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_slice/axi_w_buffer.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/clk_rst_gen.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/components/cluster_clock_gating.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/components/cluster_clock_inverter.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/components/cluster_clock_mux2.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/core2axi/core2axi.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/core2axi_wrap.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/core_region.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/components/generic_fifo.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_event_unit/generic_service_unit.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_i2c/i2c_master_bit_ctrl.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_i2c/i2c_master_byte_ctrl.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/periph_bus_wrap.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/peripherals.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/components/pulp_clock_inverter.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/components/pulp_clock_mux2.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/pulpito_top.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zturn/pulpito_wrap.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/components/rstgen.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_event_unit/sleep_unit.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_spi_master/spi_master_apb_if.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_master/spi_master_clkgen.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_master/spi_master_controller.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_master/spi_master_fifo.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_master/spi_master_rx.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_master/spi_master_tx.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_axi_plug.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_cmd_parser.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_controller.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_dc_fifo.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_regs.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_rx.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_syncro.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_tx.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_timer/timer.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/include/zeroriscy_defines.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/include/zeroriscy_config.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_alu.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_compressed_decoder.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_controller.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_core.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_cs_registers.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_debug_unit.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_decoder.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_ex_block.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_fetch_fifo.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_id_stage.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_if_stage.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_int_controller.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_load_store_unit.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_multdiv_fast.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_multdiv_slow.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_prefetch_buffer.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_register_file_ff.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/apb_uart.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/slib_clock_div.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/slib_counter.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/slib_edge_detect.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/slib_fifo.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/slib_input_filter.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/slib_input_sync.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/slib_mv_filter.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/uart_baudgen.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/uart_interrupt.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/uart_receiver.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/apb_uart/uart_transmitter.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/zturn/clocking.vh"]"\
 "[file normalize "$origin_dir/../../../rtl/zturn/pulpemu_top.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_tracer.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/apu_defines.sv"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_tap_defines.v"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../../rtl/top/config.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../../rtl/top/apb_bus.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../../rtl/top/debug_bus.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_axi_biu.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_defines.v"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_axi_defines.v"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_axi_module.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_or1k_biu.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_or1k_defines.v"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_or1k_module.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_or1k_status_reg.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/adv_dbg_if/rtl/adbg_top.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/adv_dbg_if/rtl/adv_dbg_if.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb2per/apb2per.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_event_unit/include/defines_event_unit.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_event_unit/apb_event_unit.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_fll_if/apb_fll_if.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_gpio/apb_gpio.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_i2c/apb_i2c.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_node/apb_node.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_node/apb_node_wrap.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_pulpino/apb_pulpino.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_spi_master/apb_spi_master.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_timer/apb_timer.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi2apb/axi2apb.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi2apb/axi2apb32.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/axi_bus.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../../rtl/top/axi2apb_wrap.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_AR_allocator.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_AW_allocator.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_ArbitrationTree.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_BR_allocator.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_BW_allocator.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_DW_allocator.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_FanInPrimitive_Req.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_RR_Flag_Req.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_address_decoder_AR.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_address_decoder_AW.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_address_decoder_BR.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_address_decoder_BW.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_address_decoder_DW.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_slice/axi_ar_buffer.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_slice/axi_aw_buffer.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_slice/axi_b_buffer.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_multiplexer.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_node.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/axi_node_intf_wrap.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_slice/axi_r_buffer.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_request_block.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_node/axi_response_block.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_slice/axi_slice.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/axi_slice_wrap.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_slave/axi_spi_slave.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/axi_spi_slave_wrap.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_slice/axi_w_buffer.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/clk_rst_gen.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/components/cluster_clock_gating.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/components/cluster_clock_inverter.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/components/cluster_clock_mux2.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/core2axi/core2axi.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/core2axi_wrap.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/core_region.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/components/generic_fifo.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_event_unit/generic_service_unit.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_i2c/i2c_master_bit_ctrl.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_i2c/i2c_master_byte_ctrl.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/periph_bus_wrap.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/peripherals.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/components/pulp_clock_inverter.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/components/pulp_clock_mux2.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/pulpito_top.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zturn/pulpito_wrap.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj
set_property -name "used_in" -value "synthesis implementation" -objects $file_obj
set_property -name "used_in_simulation" -value "0" -objects $file_obj

set file "$origin_dir/../../../rtl/top/components/rstgen.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_event_unit/sleep_unit.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_spi_master/spi_master_apb_if.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_master/spi_master_clkgen.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_master/spi_master_controller.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_master/spi_master_fifo.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_master/spi_master_rx.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_master/spi_master_tx.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_axi_plug.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_cmd_parser.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_controller.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_dc_fifo.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_regs.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_rx.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_syncro.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/axi_spi_slave/spi_slave_tx.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_timer/timer.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/include/zeroriscy_defines.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/include/zeroriscy_config.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_alu.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_compressed_decoder.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_controller.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_core.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_cs_registers.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_debug_unit.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_decoder.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_ex_block.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_fetch_fifo.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_id_stage.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_if_stage.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_int_controller.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_load_store_unit.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_multdiv_fast.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_multdiv_slow.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_prefetch_buffer.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_register_file_ff.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/apb_uart.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/slib_clock_div.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/slib_counter.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/slib_edge_detect.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/slib_fifo.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/slib_input_filter.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/slib_input_sync.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/slib_mv_filter.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/uart_baudgen.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/uart_interrupt.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/uart_receiver.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/apb_uart/uart_transmitter.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/zturn/clocking.vh"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj

set file "$origin_dir/../../../rtl/zturn/pulpemu_top.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj
set_property -name "used_in" -value "synthesis implementation" -objects $file_obj
set_property -name "used_in_simulation" -value "0" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_tracer.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj
set_property -name "used_in" -value "simulation" -objects $file_obj
set_property -name "used_in_implementation" -value "0" -objects $file_obj
set_property -name "used_in_synthesis" -value "0" -objects $file_obj

set file "$origin_dir/../../../rtl/top/apu_defines.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Verilog Header" -objects $file_obj


# Set 'sources_1' fileset file properties for local files
# None

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property -name "top" -value "pulpemu_top" -objects $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/../../../rtl/zturn/zturn.xdc"]"
set file_added [add_files -norecurse -fileset $obj $file]
set file "$origin_dir/../../../rtl/zturn/zturn.xdc"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property -name "target_constrs_file" -value "[file normalize "$origin_dir/../../../rtl/zturn/zturn.xdc"]" -objects $obj

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
set files [list \
 "[file normalize "$origin_dir/../../../rtl/zriscy/include/zeroriscy_tracer_defines.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/top/sim/axi_slave_mem.vhd"]"\
 "[file normalize "$origin_dir/../../../rtl/top/sim/pulpsim_top.sv"]"\
 "[file normalize "$origin_dir/../../../rtl/zriscy/zeroriscy_tracer.sv"]"\
]
add_files -norecurse -fileset $obj $files

# Set 'sim_1' fileset file properties for remote files
set file "$origin_dir/../../../rtl/zriscy/include/zeroriscy_tracer_defines.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/top/sim/axi_slave_mem.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../rtl/top/sim/pulpsim_top.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj

set file "$origin_dir/../../../rtl/zriscy/zeroriscy_tracer.sv"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property -name "file_type" -value "SystemVerilog" -objects $file_obj
set_property -name "used_in" -value "" -objects $file_obj
set_property -name "used_in_implementation" -value "0" -objects $file_obj
set_property -name "used_in_simulation" -value "0" -objects $file_obj
set_property -name "used_in_synthesis" -value "0" -objects $file_obj


# Set 'sim_1' fileset file properties for local files
# None

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "top" -value "pulpsim_top" -objects $obj
set_property -name "verilog_define" -value "TRACE_EXECUTION=1" -objects $obj

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
  create_run -name synth_1 -part xc7z020clg400-1 -flow {Vivado Synthesis 2017} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2017" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property -name "steps.synth_design.args.more options" -value "-verilog_define PULP_FPGA_EMUL=1" -objects $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
  create_run -name impl_1 -part xc7z020clg400-1 -flow {Vivado Implementation 2017} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2017" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property -name "steps.write_bitstream.args.readback_file" -value "0" -objects $obj
set_property -name "steps.write_bitstream.args.verbose" -value "0" -objects $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:pulpito"
