library ieee;
use ieee.std_logic_1164.all;

--! Entity Declaration
-- {{{
entity template is
    port (
             input	 : in std_logic_vector(1 downto 0);
             output  : out std_logic_vector(1 downto 0);
             reset   : in std_logic;
             clk 	 : in std_logic
         );
end template;
-- }}}
--! @brief Architecture Description
-- {{{
architecture arch of template is 
	--! @brief Signal Declarations
	-- {{{
    type states is (S0, S1);
    signal ps, ns : states;
	-- }}}

begin
	--! @brief Component Port Maps
	-- {{{
	-- }}}
	--! @brief RTL
	-- {{{
	-- }}}
    end arch;
--}}}
