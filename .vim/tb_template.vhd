library ieee;
use ieee.std_logic_1164.all;

--! Entity Declaration
-- {{{
entity tb_template is
	end tb_template;
-- }}}

--! @brief Architecture Description
-- {{{
architecture arch of tb_template is 
   --! @brief Signal Declarations                                                                            
   -- {{{  
   constant clk_period : time := 100 ns;
   signal input : std_logic_vector(1 downto 0);
   signal output : std_logic_vector(1 downto 0);
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   -- }}}
begin

   --! @brief DUT Port Map
   -- {{{
   DUT_inst : entity work.dut port map(
                                         input => input,
                                         output => output,
                                         clk => clk,
                                         reset => reset
                                      );
   -- }}}

   --! @brief Clock Creation
   -- {{{
   clk <= not clk after clk_period/2;
   -- }}}

   --! Stimulus process
   --{{{
   stim_proc: process
   begin         
      wait for 3 ns;
      reset <='1';
      wait for 20 ns;
      reset <='0';
      -- Do something interesting.
      wait;
   end process;
   --}}}

end arch;
--}}}
