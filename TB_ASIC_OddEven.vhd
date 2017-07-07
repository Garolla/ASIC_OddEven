library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use work.CONSTANTS.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity TB_ASIC_OddEven is
end entity;

architecture TEST of TB_ASIC_OddEven is

	-- Clock period definitions
    constant clk_period : time := 10 ns;
	
	clk          : std_logic:='0';
    rst 		 : std_logic:='0';
    start   	 : std_logic:='0';
    done		 : std_logic;
    data_to_up   : grid_data;
    data_from_up : grid_data:=(others => (others => '0'));
    we_from_up   : std_logic_vector(num_PE-1 downto 0):=(others => '0');

	begin
		
	clock_pro :	process (clk) is
	begin
		clk	<=	NOT clk	after clk_period/2;
	end process;
	
inputs : process is
	FILE out_data : text open write_mode is "input.txt";
    variable l1: line;
begin
	wait for 2 ns;
	rst				<= '1';
	wait for clk_period; 	
	rst				<= '0';
	wait for clk_period; 
	
	ctrl(0) <= "1001"; --to all pillars of the first 9x9 block
	request_in(0) <= DATA_WRALL &"0000"& NODEST & conv_std_logic_vector(11, DATA_length);
	wait for clk_period; 
	ctrl(0) <= "1001"; --to all pillars of the first 9x9 block
	request_in(0) <= DATAPASS   &"0001"& SOU_EAST & conv_std_logic_vector(666, DATA_length);
	wait for clk_period; 
	-----------------------------------------------
	ctrl(0) <= "1001"; --to all pillars of the first 9x9 block
	request_in(0) <= INST_WRALL &"0000"& NODEST   &"0"&"0000"&"0000"& WRITE_A & LR &"0001"&  NODEST;			
	wait for clk_period;
	ctrl(0) <= "0111"; --to only pillar 7
	request_in(0) <= INSTPASS   &"0001"& SOU_EAST &"0"&"0000"&"0000"& READ_A  & TTW &"0000"& WEST;	
	wait for clk_period;
	ctrl <= (others => "1001") ;                 
	request_in <= (others => INST_WRALL &"1111"& NODEST &"1"&"0000"&"1111"& NOP     & NOTAG &"0000"& NODEST);	
	wait for clk_period; 	
	ctrl <= (others => "1001") ;    
	request_in <= (others => (others => '0'));
	wait for 2*clk_period;
	start	<= '1';
	wait;
end process;

	DUT : entity work.ASIC_OddEven
		port map( clk, rst, start, done, data_to_up, data_from_up, we_from_up);	
end architecture;
