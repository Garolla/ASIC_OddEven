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
	we_from_up <= (others => '1');
	data_from_up(0) <= conv_std_logic_vector(11, data_length));
	data_from_up(1) <= conv_std_logic_vector(90, data_length));
	wait for 2*clk_period;
	start	<= '1';
	wait;
end process;

	DUT : entity work.ASIC_OddEven
		port map( clk, rst, start, done, data_to_up, data_from_up, we_from_up);	
end architecture;
