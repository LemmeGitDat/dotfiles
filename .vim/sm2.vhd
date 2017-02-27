--! State Machine 2
-- {{{
process(reset, input, clk)
begin
        -- Default states
   output <= "00";
   ns <= S0;

   case ps is 
      when S0 =>
         output <= input;
         ns <= S1;
      when S1 =>
         output <= input;
         ns <= S0;
   end case;
end process;

process(reset, input, clk)
begin
   if (rising_edge(clk)) then
      if (reset = '1') then
         ps <= S0;
      else
         ps <= ns;
      end if;
   end if;
end process;
--}}}
