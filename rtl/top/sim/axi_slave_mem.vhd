-- Copyright 2018 EPS Universidad Autónoma de Madrid.
-- Copyright and related rights are licensed under the Solderpad Hardware
-- License, Version 0.51 (the “License”); you may not use this file except in
-- compliance with the License.  You may obtain a copy of the License at
-- http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
-- or agreed to in writing, software, hardware and materials distributed under
-- this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
-- CONDITIONS OF ANY KIND, either express or implied. See the License for the
-- specific language governing permissions and limitations under the License.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity axi_slave_mem is
    generic
    (
        C_MEM_SIZE                     : integer := 1024;
        C_MEM_FILE                     : string  := "";
        C_S_AXI_DATA_WIDTH             : integer := 32;
        C_S_AXI_ADDR_WIDTH             : integer := 32
    );
    port
    (
        S_AXI_ACLK                     : in  std_logic;
        S_AXI_ARESETN                  : in  std_logic;
        S_AXI_AWADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_AWVALID                  : in  std_logic;
        S_AXI_AWREADY                  : out std_logic;
        S_AXI_ARADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_ARVALID                  : in  std_logic;
        S_AXI_ARREADY                  : out std_logic;
        S_AXI_WDATA                    : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_WSTRB                    : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
        S_AXI_WVALID                   : in  std_logic;
        S_AXI_WREADY                   : out std_logic;
        S_AXI_RDATA                    : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_RRESP                    : out std_logic_vector(1 downto 0);
        S_AXI_RVALID                   : out std_logic;
        S_AXI_RREADY                   : in  std_logic;
        S_AXI_BRESP                    : out std_logic_vector(1 downto 0);
        S_AXI_BVALID                   : out std_logic;
        S_AXI_BREADY                   : in  std_logic
    );
end axi_slave_mem;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture rtl of axi_slave_mem is

   -- Type declarations
   type main_fsm_type is (reset, idle, read_transaction_in_progress, write_transaction_in_progress, complete);
   type register_array_type is array (C_MEM_SIZE-1 downto 0) of std_logic_vector(31 downto 0);

   impure function InitRomFromFile (RomFileName : in string) return register_array_type is
       FILE romfile : text;
       variable status : file_open_status;
       variable RomFileLine : line;
       variable rom : register_array_type := (others => x"00000000");
       variable i : integer;
   begin
       file_open(status, romfile, RomFileName, READ_MODE);
       if status = open_ok then
           i := 0;
           while not endfile(romfile) loop
               readline(romfile, RomFileLine);
               hread(RomFileLine, rom(i));
               i := i + 1;
           end loop;
           file_close(romfile);
       else
           report "ROM file not found/defined. Filling memory with zeroes..." severity NOTE;
       end if;
       return rom;
   end function;

   -- Signal declarations
   signal local_address : integer range 0 to 2**C_S_AXI_ADDR_WIDTH;
   signal register_array : register_array_type := InitRomFromFile(C_MEM_FILE);
   signal combined_S_AXI_AWVALID_S_AXI_ARVALID : std_logic_vector(1 downto 0);
   signal Local_Reset : std_logic;
   signal current_state, next_state : main_fsm_type;
   
begin

   Local_Reset <= not S_AXI_ARESETN;
   combined_S_AXI_AWVALID_S_AXI_ARVALID <= S_AXI_AWVALID & S_AXI_ARVALID;

   state_machine_update : process (S_AXI_ACLK)
   begin
      if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
         if Local_Reset = '1' then
            current_state <= reset;
         else
            current_state <= next_state;
         end if;
      end if;
   end process;

   state_machine_decisions : process (current_state, combined_S_AXI_AWVALID_S_AXI_ARVALID, S_AXI_ARVALID, S_AXI_RREADY, S_AXI_AWVALID, S_AXI_WVALID, S_AXI_BREADY)
   begin
      S_AXI_ARREADY <= '0';
      S_AXI_RRESP <= "--";
      S_AXI_RVALID <= '0';
      S_AXI_WREADY <= '0';
      S_AXI_BRESP <= "--";
      S_AXI_BVALID <= '0';
      S_AXI_WREADY <= '0';
      S_AXI_AWREADY <= '0';

      case current_state is
         when reset =>
            next_state <= idle;

         when idle =>
            next_state <= idle;
            case combined_S_AXI_AWVALID_S_AXI_ARVALID is
               when "01" => 
                  next_state <= read_transaction_in_progress;
                  local_address <= to_integer(unsigned(S_AXI_ARADDR(C_S_AXI_ADDR_WIDTH-1 downto 0)));
               when "10" => 
                  next_state <= write_transaction_in_progress;
                  local_address <= to_integer(unsigned(S_AXI_AWADDR(C_S_AXI_ADDR_WIDTH-1 downto 0)));
               when others => NULL;
            end case;

         when read_transaction_in_progress =>
            next_state <= read_transaction_in_progress;
            S_AXI_ARREADY <= S_AXI_ARVALID;
            S_AXI_RVALID <= '1';
            S_AXI_RRESP <= "00";
            if local_address < C_MEM_SIZE*4 then
               S_AXI_RDATA <= register_array(local_address/4);
            end if;
            if S_AXI_RREADY = '1' then
               next_state <= complete;
            end if;

         when write_transaction_in_progress =>
            S_AXI_AWREADY <= S_AXI_AWVALID;
            S_AXI_WREADY <= S_AXI_WVALID;
            if S_AXI_WVALID = '1' then
               S_AXI_BRESP <= "00";
               S_AXI_BVALID <= '1';
               if local_address < C_MEM_SIZE*4 then
                  register_array(local_address/4) <= S_AXI_WDATA;
               end if;
               next_state <= write_transaction_in_progress;
            end if;
            if S_AXI_BREADY = '1' then
               next_state <= complete;
            end if;

         when complete =>
            case combined_S_AXI_AWVALID_S_AXI_ARVALID is
               when "00" => next_state <= idle;
               when others => next_state <= complete;
            end case;

         when others =>
            next_state <= reset;
      end case;
   end process;

end rtl;
