// Copyright 2018 EPS Universidad Autónoma de Madrid.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

/* -----------------------------------------------------------
   ZTurn Clock Configuration

   Rocket Chip             1000              RC_CLK_MULT
    Clockrate     =   ---------------   X   -------------
     (in MHz)         ZYNQ_CLK_PERIOD       RC_CLK_DIVIDE

   This sets the parameters used by top module to generate its 
   own clock.

   Most uses should only change RC_CLK_MULT & RC_CLK_DIVIDE.
   ZYNQ_CLK_PERIOD should only be changed to match the input
   clock period set in the constraints
   ----------------------------------------------------------- */

`ifndef _clocking_vh_
`define _clocking_vh_

// Final Clockrate == 48 Mhz

`define ZYNQ_CLK_PERIOD      83.33333
`define RC_CLK_MULT          64.00000        // From 2.000 to 64.000
`define RC_CLK_DIVIDE        16.00000        // From 1.000 to 128.000

`endif // _clocking_vh_
