type states is (IDLE, S1);
signal ps : states;

--! State Machine
-- {{{
process(clk)
begin
   if (rising_edge(clk)) then
      if (rst = '1') then
         ps <= IDLE;
         output <= "00";
      else
         case ps is 
            when IDLE =>
               output <= "00";
               ps <= S1;
            when S1 =>
               output <= input;
               ps <= S1;
         end case;
      end if;
   end if;
end process;
--}}}
