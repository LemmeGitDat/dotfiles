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
