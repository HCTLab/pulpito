# Copyright 2018 EPS Universidad Autónoma de Madrid.
# Copyright and related rights are licensed under the Solderpad Hardware
# License, Version 0.51 (the “License”); you may not use this file except in
# compliance with the License.  You may obtain a copy of the License at
# http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
# or agreed to in writing, software, hardware and materials distributed under
# this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

set_property PACKAGE_PIN U14 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 83.333 -name board_clk -add [get_ports clk]

set_property PACKAGE_PIN T12 [get_ports uart_tx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx]
set_property PACKAGE_PIN U12 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx]

set_property PACKAGE_PIN U7 [get_ports ext_tck_i]
set_property IOSTANDARD LVCMOS33 [get_ports ext_tck_i]
set_property PACKAGE_PIN V7 [get_ports ext_tms_i]
set_property IOSTANDARD LVCMOS33 [get_ports ext_tms_i]
set_property PACKAGE_PIN T9 [get_ports ext_tdi_i]
set_property IOSTANDARD LVCMOS33 [get_ports ext_tdi_i]
set_property PACKAGE_PIN U10 [get_ports ext_tdo_o]
set_property IOSTANDARD LVCMOS33 [get_ports ext_tdo_o]
set_property PACKAGE_PIN Y7 [get_ports ext_trstn_i]
set_property IOSTANDARD LVCMOS33 [get_ports ext_trstn_i]


create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 2 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list host_clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {pulpito_wrap_i/M_AXI_GP_rdata[0]} {pulpito_wrap_i/M_AXI_GP_rdata[1]} {pulpito_wrap_i/M_AXI_GP_rdata[2]} {pulpito_wrap_i/M_AXI_GP_rdata[3]} {pulpito_wrap_i/M_AXI_GP_rdata[4]} {pulpito_wrap_i/M_AXI_GP_rdata[5]} {pulpito_wrap_i/M_AXI_GP_rdata[6]} {pulpito_wrap_i/M_AXI_GP_rdata[7]} {pulpito_wrap_i/M_AXI_GP_rdata[8]} {pulpito_wrap_i/M_AXI_GP_rdata[9]} {pulpito_wrap_i/M_AXI_GP_rdata[10]} {pulpito_wrap_i/M_AXI_GP_rdata[11]} {pulpito_wrap_i/M_AXI_GP_rdata[12]} {pulpito_wrap_i/M_AXI_GP_rdata[13]} {pulpito_wrap_i/M_AXI_GP_rdata[14]} {pulpito_wrap_i/M_AXI_GP_rdata[15]} {pulpito_wrap_i/M_AXI_GP_rdata[16]} {pulpito_wrap_i/M_AXI_GP_rdata[17]} {pulpito_wrap_i/M_AXI_GP_rdata[18]} {pulpito_wrap_i/M_AXI_GP_rdata[19]} {pulpito_wrap_i/M_AXI_GP_rdata[20]} {pulpito_wrap_i/M_AXI_GP_rdata[21]} {pulpito_wrap_i/M_AXI_GP_rdata[22]} {pulpito_wrap_i/M_AXI_GP_rdata[23]} {pulpito_wrap_i/M_AXI_GP_rdata[24]} {pulpito_wrap_i/M_AXI_GP_rdata[25]} {pulpito_wrap_i/M_AXI_GP_rdata[26]} {pulpito_wrap_i/M_AXI_GP_rdata[27]} {pulpito_wrap_i/M_AXI_GP_rdata[28]} {pulpito_wrap_i/M_AXI_GP_rdata[29]} {pulpito_wrap_i/M_AXI_GP_rdata[30]} {pulpito_wrap_i/M_AXI_GP_rdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {pulpito_wrap_i/M_AXI_GP_awaddr[0]} {pulpito_wrap_i/M_AXI_GP_awaddr[1]} {pulpito_wrap_i/M_AXI_GP_awaddr[2]} {pulpito_wrap_i/M_AXI_GP_awaddr[3]} {pulpito_wrap_i/M_AXI_GP_awaddr[4]} {pulpito_wrap_i/M_AXI_GP_awaddr[5]} {pulpito_wrap_i/M_AXI_GP_awaddr[6]} {pulpito_wrap_i/M_AXI_GP_awaddr[7]} {pulpito_wrap_i/M_AXI_GP_awaddr[8]} {pulpito_wrap_i/M_AXI_GP_awaddr[9]} {pulpito_wrap_i/M_AXI_GP_awaddr[10]} {pulpito_wrap_i/M_AXI_GP_awaddr[11]} {pulpito_wrap_i/M_AXI_GP_awaddr[12]} {pulpito_wrap_i/M_AXI_GP_awaddr[13]} {pulpito_wrap_i/M_AXI_GP_awaddr[14]} {pulpito_wrap_i/M_AXI_GP_awaddr[15]} {pulpito_wrap_i/M_AXI_GP_awaddr[16]} {pulpito_wrap_i/M_AXI_GP_awaddr[17]} {pulpito_wrap_i/M_AXI_GP_awaddr[18]} {pulpito_wrap_i/M_AXI_GP_awaddr[19]} {pulpito_wrap_i/M_AXI_GP_awaddr[20]} {pulpito_wrap_i/M_AXI_GP_awaddr[21]} {pulpito_wrap_i/M_AXI_GP_awaddr[22]} {pulpito_wrap_i/M_AXI_GP_awaddr[23]} {pulpito_wrap_i/M_AXI_GP_awaddr[24]} {pulpito_wrap_i/M_AXI_GP_awaddr[25]} {pulpito_wrap_i/M_AXI_GP_awaddr[26]} {pulpito_wrap_i/M_AXI_GP_awaddr[27]} {pulpito_wrap_i/M_AXI_GP_awaddr[28]} {pulpito_wrap_i/M_AXI_GP_awaddr[29]} {pulpito_wrap_i/M_AXI_GP_awaddr[30]} {pulpito_wrap_i/M_AXI_GP_awaddr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {pulpito_wrap_i/M_AXI_GP_wdata[0]} {pulpito_wrap_i/M_AXI_GP_wdata[1]} {pulpito_wrap_i/M_AXI_GP_wdata[2]} {pulpito_wrap_i/M_AXI_GP_wdata[3]} {pulpito_wrap_i/M_AXI_GP_wdata[4]} {pulpito_wrap_i/M_AXI_GP_wdata[5]} {pulpito_wrap_i/M_AXI_GP_wdata[6]} {pulpito_wrap_i/M_AXI_GP_wdata[7]} {pulpito_wrap_i/M_AXI_GP_wdata[8]} {pulpito_wrap_i/M_AXI_GP_wdata[9]} {pulpito_wrap_i/M_AXI_GP_wdata[10]} {pulpito_wrap_i/M_AXI_GP_wdata[11]} {pulpito_wrap_i/M_AXI_GP_wdata[12]} {pulpito_wrap_i/M_AXI_GP_wdata[13]} {pulpito_wrap_i/M_AXI_GP_wdata[14]} {pulpito_wrap_i/M_AXI_GP_wdata[15]} {pulpito_wrap_i/M_AXI_GP_wdata[16]} {pulpito_wrap_i/M_AXI_GP_wdata[17]} {pulpito_wrap_i/M_AXI_GP_wdata[18]} {pulpito_wrap_i/M_AXI_GP_wdata[19]} {pulpito_wrap_i/M_AXI_GP_wdata[20]} {pulpito_wrap_i/M_AXI_GP_wdata[21]} {pulpito_wrap_i/M_AXI_GP_wdata[22]} {pulpito_wrap_i/M_AXI_GP_wdata[23]} {pulpito_wrap_i/M_AXI_GP_wdata[24]} {pulpito_wrap_i/M_AXI_GP_wdata[25]} {pulpito_wrap_i/M_AXI_GP_wdata[26]} {pulpito_wrap_i/M_AXI_GP_wdata[27]} {pulpito_wrap_i/M_AXI_GP_wdata[28]} {pulpito_wrap_i/M_AXI_GP_wdata[29]} {pulpito_wrap_i/M_AXI_GP_wdata[30]} {pulpito_wrap_i/M_AXI_GP_wdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {pulpito_wrap_i/M_AXI_GP_araddr[0]} {pulpito_wrap_i/M_AXI_GP_araddr[1]} {pulpito_wrap_i/M_AXI_GP_araddr[2]} {pulpito_wrap_i/M_AXI_GP_araddr[3]} {pulpito_wrap_i/M_AXI_GP_araddr[4]} {pulpito_wrap_i/M_AXI_GP_araddr[5]} {pulpito_wrap_i/M_AXI_GP_araddr[6]} {pulpito_wrap_i/M_AXI_GP_araddr[7]} {pulpito_wrap_i/M_AXI_GP_araddr[8]} {pulpito_wrap_i/M_AXI_GP_araddr[9]} {pulpito_wrap_i/M_AXI_GP_araddr[10]} {pulpito_wrap_i/M_AXI_GP_araddr[11]} {pulpito_wrap_i/M_AXI_GP_araddr[12]} {pulpito_wrap_i/M_AXI_GP_araddr[13]} {pulpito_wrap_i/M_AXI_GP_araddr[14]} {pulpito_wrap_i/M_AXI_GP_araddr[15]} {pulpito_wrap_i/M_AXI_GP_araddr[16]} {pulpito_wrap_i/M_AXI_GP_araddr[17]} {pulpito_wrap_i/M_AXI_GP_araddr[18]} {pulpito_wrap_i/M_AXI_GP_araddr[19]} {pulpito_wrap_i/M_AXI_GP_araddr[20]} {pulpito_wrap_i/M_AXI_GP_araddr[21]} {pulpito_wrap_i/M_AXI_GP_araddr[22]} {pulpito_wrap_i/M_AXI_GP_araddr[23]} {pulpito_wrap_i/M_AXI_GP_araddr[24]} {pulpito_wrap_i/M_AXI_GP_araddr[25]} {pulpito_wrap_i/M_AXI_GP_araddr[26]} {pulpito_wrap_i/M_AXI_GP_araddr[27]} {pulpito_wrap_i/M_AXI_GP_araddr[28]} {pulpito_wrap_i/M_AXI_GP_araddr[29]} {pulpito_wrap_i/M_AXI_GP_araddr[30]} {pulpito_wrap_i/M_AXI_GP_araddr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {pulpito_wrap_i/S_AXI_GP_wdata[0]} {pulpito_wrap_i/S_AXI_GP_wdata[1]} {pulpito_wrap_i/S_AXI_GP_wdata[2]} {pulpito_wrap_i/S_AXI_GP_wdata[3]} {pulpito_wrap_i/S_AXI_GP_wdata[4]} {pulpito_wrap_i/S_AXI_GP_wdata[5]} {pulpito_wrap_i/S_AXI_GP_wdata[6]} {pulpito_wrap_i/S_AXI_GP_wdata[7]} {pulpito_wrap_i/S_AXI_GP_wdata[8]} {pulpito_wrap_i/S_AXI_GP_wdata[9]} {pulpito_wrap_i/S_AXI_GP_wdata[10]} {pulpito_wrap_i/S_AXI_GP_wdata[11]} {pulpito_wrap_i/S_AXI_GP_wdata[12]} {pulpito_wrap_i/S_AXI_GP_wdata[13]} {pulpito_wrap_i/S_AXI_GP_wdata[14]} {pulpito_wrap_i/S_AXI_GP_wdata[15]} {pulpito_wrap_i/S_AXI_GP_wdata[16]} {pulpito_wrap_i/S_AXI_GP_wdata[17]} {pulpito_wrap_i/S_AXI_GP_wdata[18]} {pulpito_wrap_i/S_AXI_GP_wdata[19]} {pulpito_wrap_i/S_AXI_GP_wdata[20]} {pulpito_wrap_i/S_AXI_GP_wdata[21]} {pulpito_wrap_i/S_AXI_GP_wdata[22]} {pulpito_wrap_i/S_AXI_GP_wdata[23]} {pulpito_wrap_i/S_AXI_GP_wdata[24]} {pulpito_wrap_i/S_AXI_GP_wdata[25]} {pulpito_wrap_i/S_AXI_GP_wdata[26]} {pulpito_wrap_i/S_AXI_GP_wdata[27]} {pulpito_wrap_i/S_AXI_GP_wdata[28]} {pulpito_wrap_i/S_AXI_GP_wdata[29]} {pulpito_wrap_i/S_AXI_GP_wdata[30]} {pulpito_wrap_i/S_AXI_GP_wdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {pulpito_wrap_i/S_AXI_ACP_araddr[0]} {pulpito_wrap_i/S_AXI_ACP_araddr[1]} {pulpito_wrap_i/S_AXI_ACP_araddr[2]} {pulpito_wrap_i/S_AXI_ACP_araddr[3]} {pulpito_wrap_i/S_AXI_ACP_araddr[4]} {pulpito_wrap_i/S_AXI_ACP_araddr[5]} {pulpito_wrap_i/S_AXI_ACP_araddr[6]} {pulpito_wrap_i/S_AXI_ACP_araddr[7]} {pulpito_wrap_i/S_AXI_ACP_araddr[8]} {pulpito_wrap_i/S_AXI_ACP_araddr[9]} {pulpito_wrap_i/S_AXI_ACP_araddr[10]} {pulpito_wrap_i/S_AXI_ACP_araddr[11]} {pulpito_wrap_i/S_AXI_ACP_araddr[12]} {pulpito_wrap_i/S_AXI_ACP_araddr[13]} {pulpito_wrap_i/S_AXI_ACP_araddr[14]} {pulpito_wrap_i/S_AXI_ACP_araddr[15]} {pulpito_wrap_i/S_AXI_ACP_araddr[16]} {pulpito_wrap_i/S_AXI_ACP_araddr[17]} {pulpito_wrap_i/S_AXI_ACP_araddr[18]} {pulpito_wrap_i/S_AXI_ACP_araddr[19]} {pulpito_wrap_i/S_AXI_ACP_araddr[20]} {pulpito_wrap_i/S_AXI_ACP_araddr[21]} {pulpito_wrap_i/S_AXI_ACP_araddr[22]} {pulpito_wrap_i/S_AXI_ACP_araddr[23]} {pulpito_wrap_i/S_AXI_ACP_araddr[24]} {pulpito_wrap_i/S_AXI_ACP_araddr[25]} {pulpito_wrap_i/S_AXI_ACP_araddr[26]} {pulpito_wrap_i/S_AXI_ACP_araddr[27]} {pulpito_wrap_i/S_AXI_ACP_araddr[28]} {pulpito_wrap_i/S_AXI_ACP_araddr[29]} {pulpito_wrap_i/S_AXI_ACP_araddr[30]} {pulpito_wrap_i/S_AXI_ACP_araddr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {pulpito_wrap_i/S_AXI_GP_araddr[0]} {pulpito_wrap_i/S_AXI_GP_araddr[1]} {pulpito_wrap_i/S_AXI_GP_araddr[2]} {pulpito_wrap_i/S_AXI_GP_araddr[3]} {pulpito_wrap_i/S_AXI_GP_araddr[4]} {pulpito_wrap_i/S_AXI_GP_araddr[5]} {pulpito_wrap_i/S_AXI_GP_araddr[6]} {pulpito_wrap_i/S_AXI_GP_araddr[7]} {pulpito_wrap_i/S_AXI_GP_araddr[8]} {pulpito_wrap_i/S_AXI_GP_araddr[9]} {pulpito_wrap_i/S_AXI_GP_araddr[10]} {pulpito_wrap_i/S_AXI_GP_araddr[11]} {pulpito_wrap_i/S_AXI_GP_araddr[12]} {pulpito_wrap_i/S_AXI_GP_araddr[13]} {pulpito_wrap_i/S_AXI_GP_araddr[14]} {pulpito_wrap_i/S_AXI_GP_araddr[15]} {pulpito_wrap_i/S_AXI_GP_araddr[16]} {pulpito_wrap_i/S_AXI_GP_araddr[17]} {pulpito_wrap_i/S_AXI_GP_araddr[18]} {pulpito_wrap_i/S_AXI_GP_araddr[19]} {pulpito_wrap_i/S_AXI_GP_araddr[20]} {pulpito_wrap_i/S_AXI_GP_araddr[21]} {pulpito_wrap_i/S_AXI_GP_araddr[22]} {pulpito_wrap_i/S_AXI_GP_araddr[23]} {pulpito_wrap_i/S_AXI_GP_araddr[24]} {pulpito_wrap_i/S_AXI_GP_araddr[25]} {pulpito_wrap_i/S_AXI_GP_araddr[26]} {pulpito_wrap_i/S_AXI_GP_araddr[27]} {pulpito_wrap_i/S_AXI_GP_araddr[28]} {pulpito_wrap_i/S_AXI_GP_araddr[29]} {pulpito_wrap_i/S_AXI_GP_araddr[30]} {pulpito_wrap_i/S_AXI_GP_araddr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {pulpito_wrap_i/S_AXI_GP_awaddr[0]} {pulpito_wrap_i/S_AXI_GP_awaddr[1]} {pulpito_wrap_i/S_AXI_GP_awaddr[2]} {pulpito_wrap_i/S_AXI_GP_awaddr[3]} {pulpito_wrap_i/S_AXI_GP_awaddr[4]} {pulpito_wrap_i/S_AXI_GP_awaddr[5]} {pulpito_wrap_i/S_AXI_GP_awaddr[6]} {pulpito_wrap_i/S_AXI_GP_awaddr[7]} {pulpito_wrap_i/S_AXI_GP_awaddr[8]} {pulpito_wrap_i/S_AXI_GP_awaddr[9]} {pulpito_wrap_i/S_AXI_GP_awaddr[10]} {pulpito_wrap_i/S_AXI_GP_awaddr[11]} {pulpito_wrap_i/S_AXI_GP_awaddr[12]} {pulpito_wrap_i/S_AXI_GP_awaddr[13]} {pulpito_wrap_i/S_AXI_GP_awaddr[14]} {pulpito_wrap_i/S_AXI_GP_awaddr[15]} {pulpito_wrap_i/S_AXI_GP_awaddr[16]} {pulpito_wrap_i/S_AXI_GP_awaddr[17]} {pulpito_wrap_i/S_AXI_GP_awaddr[18]} {pulpito_wrap_i/S_AXI_GP_awaddr[19]} {pulpito_wrap_i/S_AXI_GP_awaddr[20]} {pulpito_wrap_i/S_AXI_GP_awaddr[21]} {pulpito_wrap_i/S_AXI_GP_awaddr[22]} {pulpito_wrap_i/S_AXI_GP_awaddr[23]} {pulpito_wrap_i/S_AXI_GP_awaddr[24]} {pulpito_wrap_i/S_AXI_GP_awaddr[25]} {pulpito_wrap_i/S_AXI_GP_awaddr[26]} {pulpito_wrap_i/S_AXI_GP_awaddr[27]} {pulpito_wrap_i/S_AXI_GP_awaddr[28]} {pulpito_wrap_i/S_AXI_GP_awaddr[29]} {pulpito_wrap_i/S_AXI_GP_awaddr[30]} {pulpito_wrap_i/S_AXI_GP_awaddr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {pulpito_wrap_i/S_AXI_ACP_wdata[0]} {pulpito_wrap_i/S_AXI_ACP_wdata[1]} {pulpito_wrap_i/S_AXI_ACP_wdata[2]} {pulpito_wrap_i/S_AXI_ACP_wdata[3]} {pulpito_wrap_i/S_AXI_ACP_wdata[4]} {pulpito_wrap_i/S_AXI_ACP_wdata[5]} {pulpito_wrap_i/S_AXI_ACP_wdata[6]} {pulpito_wrap_i/S_AXI_ACP_wdata[7]} {pulpito_wrap_i/S_AXI_ACP_wdata[8]} {pulpito_wrap_i/S_AXI_ACP_wdata[9]} {pulpito_wrap_i/S_AXI_ACP_wdata[10]} {pulpito_wrap_i/S_AXI_ACP_wdata[11]} {pulpito_wrap_i/S_AXI_ACP_wdata[12]} {pulpito_wrap_i/S_AXI_ACP_wdata[13]} {pulpito_wrap_i/S_AXI_ACP_wdata[14]} {pulpito_wrap_i/S_AXI_ACP_wdata[15]} {pulpito_wrap_i/S_AXI_ACP_wdata[16]} {pulpito_wrap_i/S_AXI_ACP_wdata[17]} {pulpito_wrap_i/S_AXI_ACP_wdata[18]} {pulpito_wrap_i/S_AXI_ACP_wdata[19]} {pulpito_wrap_i/S_AXI_ACP_wdata[20]} {pulpito_wrap_i/S_AXI_ACP_wdata[21]} {pulpito_wrap_i/S_AXI_ACP_wdata[22]} {pulpito_wrap_i/S_AXI_ACP_wdata[23]} {pulpito_wrap_i/S_AXI_ACP_wdata[24]} {pulpito_wrap_i/S_AXI_ACP_wdata[25]} {pulpito_wrap_i/S_AXI_ACP_wdata[26]} {pulpito_wrap_i/S_AXI_ACP_wdata[27]} {pulpito_wrap_i/S_AXI_ACP_wdata[28]} {pulpito_wrap_i/S_AXI_ACP_wdata[29]} {pulpito_wrap_i/S_AXI_ACP_wdata[30]} {pulpito_wrap_i/S_AXI_ACP_wdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {pulpito_wrap_i/S_AXI_ACP_awaddr[0]} {pulpito_wrap_i/S_AXI_ACP_awaddr[1]} {pulpito_wrap_i/S_AXI_ACP_awaddr[2]} {pulpito_wrap_i/S_AXI_ACP_awaddr[3]} {pulpito_wrap_i/S_AXI_ACP_awaddr[4]} {pulpito_wrap_i/S_AXI_ACP_awaddr[5]} {pulpito_wrap_i/S_AXI_ACP_awaddr[6]} {pulpito_wrap_i/S_AXI_ACP_awaddr[7]} {pulpito_wrap_i/S_AXI_ACP_awaddr[8]} {pulpito_wrap_i/S_AXI_ACP_awaddr[9]} {pulpito_wrap_i/S_AXI_ACP_awaddr[10]} {pulpito_wrap_i/S_AXI_ACP_awaddr[11]} {pulpito_wrap_i/S_AXI_ACP_awaddr[12]} {pulpito_wrap_i/S_AXI_ACP_awaddr[13]} {pulpito_wrap_i/S_AXI_ACP_awaddr[14]} {pulpito_wrap_i/S_AXI_ACP_awaddr[15]} {pulpito_wrap_i/S_AXI_ACP_awaddr[16]} {pulpito_wrap_i/S_AXI_ACP_awaddr[17]} {pulpito_wrap_i/S_AXI_ACP_awaddr[18]} {pulpito_wrap_i/S_AXI_ACP_awaddr[19]} {pulpito_wrap_i/S_AXI_ACP_awaddr[20]} {pulpito_wrap_i/S_AXI_ACP_awaddr[21]} {pulpito_wrap_i/S_AXI_ACP_awaddr[22]} {pulpito_wrap_i/S_AXI_ACP_awaddr[23]} {pulpito_wrap_i/S_AXI_ACP_awaddr[24]} {pulpito_wrap_i/S_AXI_ACP_awaddr[25]} {pulpito_wrap_i/S_AXI_ACP_awaddr[26]} {pulpito_wrap_i/S_AXI_ACP_awaddr[27]} {pulpito_wrap_i/S_AXI_ACP_awaddr[28]} {pulpito_wrap_i/S_AXI_ACP_awaddr[29]} {pulpito_wrap_i/S_AXI_ACP_awaddr[30]} {pulpito_wrap_i/S_AXI_ACP_awaddr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 32 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {pulpito_wrap_i/S_AXI_GP_rdata[0]} {pulpito_wrap_i/S_AXI_GP_rdata[1]} {pulpito_wrap_i/S_AXI_GP_rdata[2]} {pulpito_wrap_i/S_AXI_GP_rdata[3]} {pulpito_wrap_i/S_AXI_GP_rdata[4]} {pulpito_wrap_i/S_AXI_GP_rdata[5]} {pulpito_wrap_i/S_AXI_GP_rdata[6]} {pulpito_wrap_i/S_AXI_GP_rdata[7]} {pulpito_wrap_i/S_AXI_GP_rdata[8]} {pulpito_wrap_i/S_AXI_GP_rdata[9]} {pulpito_wrap_i/S_AXI_GP_rdata[10]} {pulpito_wrap_i/S_AXI_GP_rdata[11]} {pulpito_wrap_i/S_AXI_GP_rdata[12]} {pulpito_wrap_i/S_AXI_GP_rdata[13]} {pulpito_wrap_i/S_AXI_GP_rdata[14]} {pulpito_wrap_i/S_AXI_GP_rdata[15]} {pulpito_wrap_i/S_AXI_GP_rdata[16]} {pulpito_wrap_i/S_AXI_GP_rdata[17]} {pulpito_wrap_i/S_AXI_GP_rdata[18]} {pulpito_wrap_i/S_AXI_GP_rdata[19]} {pulpito_wrap_i/S_AXI_GP_rdata[20]} {pulpito_wrap_i/S_AXI_GP_rdata[21]} {pulpito_wrap_i/S_AXI_GP_rdata[22]} {pulpito_wrap_i/S_AXI_GP_rdata[23]} {pulpito_wrap_i/S_AXI_GP_rdata[24]} {pulpito_wrap_i/S_AXI_GP_rdata[25]} {pulpito_wrap_i/S_AXI_GP_rdata[26]} {pulpito_wrap_i/S_AXI_GP_rdata[27]} {pulpito_wrap_i/S_AXI_GP_rdata[28]} {pulpito_wrap_i/S_AXI_GP_rdata[29]} {pulpito_wrap_i/S_AXI_GP_rdata[30]} {pulpito_wrap_i/S_AXI_GP_rdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list pulpito_wrap_i/M_AXI_GP_arready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list pulpito_wrap_i/M_AXI_GP_arvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list pulpito_wrap_i/M_AXI_GP_awvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list pulpito_wrap_i/M_AXI_GP_bready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list pulpito_wrap_i/M_AXI_GP_bvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list pulpito_wrap_i/M_AXI_GP_rready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list pulpito_wrap_i/M_AXI_GP_rvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list pulpito_wrap_i/M_AXI_GP_wready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list pulpito_wrap_i/M_AXI_GP_wvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list pulpito_wrap_i/S_AXI_ACP_arready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list pulpito_wrap_i/S_AXI_ACP_arvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list pulpito_wrap_i/S_AXI_ACP_awready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list pulpito_wrap_i/S_AXI_ACP_awvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list pulpito_wrap_i/S_AXI_ACP_bready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list pulpito_wrap_i/S_AXI_ACP_bvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 1 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list pulpito_wrap_i/S_AXI_ACP_rready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list pulpito_wrap_i/S_AXI_ACP_rvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 1 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list pulpito_wrap_i/S_AXI_ACP_wready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 1 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list pulpito_wrap_i/S_AXI_ACP_wvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 1 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list pulpito_wrap_i/S_AXI_GP_arready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 1 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list pulpito_wrap_i/S_AXI_GP_arvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 1 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list pulpito_wrap_i/S_AXI_GP_awready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 1 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list pulpito_wrap_i/S_AXI_GP_awvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list pulpito_wrap_i/S_AXI_GP_bready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
set_property port_width 1 [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list pulpito_wrap_i/S_AXI_GP_bvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe36]
set_property port_width 1 [get_debug_ports u_ila_0/probe36]
connect_debug_port u_ila_0/probe36 [get_nets [list pulpito_wrap_i/S_AXI_GP_rready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe37]
set_property port_width 1 [get_debug_ports u_ila_0/probe37]
connect_debug_port u_ila_0/probe37 [get_nets [list pulpito_wrap_i/S_AXI_GP_rvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe38]
set_property port_width 1 [get_debug_ports u_ila_0/probe38]
connect_debug_port u_ila_0/probe38 [get_nets [list pulpito_wrap_i/S_AXI_GP_wready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe39]
set_property port_width 1 [get_debug_ports u_ila_0/probe39]
connect_debug_port u_ila_0/probe39 [get_nets [list pulpito_wrap_i/S_AXI_GP_wvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe40]
set_property port_width 1 [get_debug_ports u_ila_0/probe40]
connect_debug_port u_ila_0/probe40 [get_nets [list pulpito_wrap_i/fetch_enable_i]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets host_clk]
