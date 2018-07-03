library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity axi_slave_memory is
    generic
    (
        C_MEM_SIZE         : integer := 1024;
        -- AXI Parameters
        C_S_AXI_DATA_WIDTH : integer := 32;
        C_S_AXI_ADDR_WIDTH : integer := 32
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
end entity axi_slave_memory;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of axi_slave_memory is

   -- Type declarations
   type main_fsm_type is (reset, idle, read_transaction_in_progress, write_transaction_in_progress, complete);
   type register_array_type is array (C_MEM_SIZE-1 downto 0) of std_logic_vector(31 downto 0);

   -- Signal declarations
   signal local_address : integer range 0 to 2**C_S_AXI_ADDR_WIDTH;
   signal local_address_valid : std_logic;

   signal register_array : register_array_type := (others => x"00000000");
   signal register_address_valid : std_logic_vector(C_MEM_SIZE-1 downto 0);

   signal combined_S_AXI_AWVALID_S_AXI_ARVALID : std_logic_vector(1 downto 0);
   signal Local_Reset : std_logic;
   signal current_state, next_state : main_fsm_type;
   signal write_enable_registers : std_logic;
   signal send_read_data_to_AXI : std_logic;

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

   state_machine_decisions : process (current_state, combined_S_AXI_AWVALID_S_AXI_ARVALID, S_AXI_ARVALID, S_AXI_RREADY, S_AXI_AWVALID, S_AXI_WVALID, S_AXI_BREADY, local_address, local_address_valid)
   begin
       S_AXI_ARREADY <= '0';
       S_AXI_RRESP <= "--";
       S_AXI_RVALID <= '0';
       S_AXI_WREADY <= '0';
       S_AXI_BRESP <= "--";
       S_AXI_BVALID <= '0';
       S_AXI_WREADY <= '0';
       S_AXI_AWREADY <= '0';
       write_enable_registers <= '0';
       send_read_data_to_AXI <= '0';

      case current_state is
         when reset =>
            next_state <= idle;

         when idle =>
            next_state <= idle;
            case combined_S_AXI_AWVALID_S_AXI_ARVALID is
               when "01" => next_state <= read_transaction_in_progress;
               when "10" => next_state <= write_transaction_in_progress;
               when others => NULL;
            end case;

         when read_transaction_in_progress =>
               next_state <= read_transaction_in_progress;
               S_AXI_ARREADY <= S_AXI_ARVALID;
               S_AXI_RVALID <= '1';
               S_AXI_RRESP <= "00";
               send_read_data_to_AXI <= '1';
               if S_AXI_RREADY = '1' then
                   next_state <= complete;
               end if;

         when write_transaction_in_progress =>
               next_state <= write_transaction_in_progress;
            write_enable_registers <= '1';
               S_AXI_AWREADY <= S_AXI_AWVALID;
               S_AXI_WREADY <= S_AXI_WVALID;
               S_AXI_BRESP <= "00";
               S_AXI_BVALID <= '1';
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

   send_data_to_AXI_RDATA : process (send_read_data_to_AXI, local_address, register_array)
   begin
      S_AXI_RDATA <= (others => '-');
      if (local_address_valid = '1' and send_read_data_to_AXI = '1') then
         case (local_address) is
            when 0 to C_MEM_SIZE*4 =>
               S_AXI_RDATA <= register_array(local_address/4);
            when others => NULL;
         end case;
      end if;
   end process;

   local_address_capture_register : process (S_AXI_ACLK)
   begin
      if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
         if Local_Reset = '1' then
             local_address <= 0;
         else
            if local_address_valid = '1' then
               case (combined_S_AXI_AWVALID_S_AXI_ARVALID) is
                  when "10" => local_address <= to_integer(unsigned(S_AXI_AWADDR(C_S_AXI_ADDR_WIDTH-1 downto 0)));
                  when "01" => local_address <= to_integer(unsigned(S_AXI_ARADDR(C_S_AXI_ADDR_WIDTH-1 downto 0)));
                  when others => local_address <= local_address;
               end case;
            end if;
         end if;
      end if;
   end process;

   register_process : process (S_AXI_ACLK)
   begin
      for i in 0 to C_MEM_SIZE-1 loop
         if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
            if Local_Reset = '1' then
               register_array(i) <= x"00000000";
            else
               if (register_address_valid(i) = '1') then
                  register_array(i) <= S_AXI_WDATA;
               end if;
            end if;
         end if;
      end loop;
   end process;

   address_range_analysis : process (local_address, write_enable_registers)
   begin
      register_address_valid <= (others => '0');
      local_address_valid <= '1';

      if write_enable_registers = '1' then
         case (local_address) is
            when 0 to C_MEM_SIZE*4 =>
               register_address_valid(local_address/4) <= '1';
            when others =>
               local_address_valid <= '0';
         end case;
      end if;
   end process;

end IMP;
