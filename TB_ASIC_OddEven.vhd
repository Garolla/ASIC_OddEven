library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;
use work.CONSTANTS.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity TB_ASIC_OddEven is
end entity;

architecture TEST of TB_ASIC_OddEven is

	-- Clock period definitions
    constant clk_period : time := 10 ns;
	
	signal clk          : std_logic:='0';
    signal rst 		    : std_logic:='0';
    signal start   	    : std_logic:='0';
    signal done		    : std_logic;
    signal data_to_up   : grid_data;
    signal data_from_up : grid_data:=(others => (others => '0'));
    signal we_from_up   : std_logic_vector(num_PE-1 downto 0):=(others => '0');

	begin
		
	clock_pro :	process (clk) is
	begin
		clk	<=	NOT clk	after clk_period/2;
	end process;
	
inputs : process is
	FILE out_data : text open write_mode is "input.txt";
    variable l1: line;
    variable seed1, seed2 : positive;
    variable rand: real;
    variable range_of_rand: real := 255.0; --Change according to data_lenght
    variable number_rand: integer;
    variable inputs : grid_data; 
begin
	uniform(seed1,seed2,rand);
	wait for 2 ns;
	rst				<= '1';
	wait for clk_period; 	
	rst				<= '0';
	wait for clk_period; 
	we_from_up <= (others => '1');
	data_from_up(0) <= conv_std_logic_vector(2, data_length);
	data_from_up(1) <= conv_std_logic_vector(90, data_length);
	data_from_up(2) <= conv_std_logic_vector(33, data_length);
	data_from_up(3) <= conv_std_logic_vector(77, data_length);	
	data_from_up(4) <= conv_std_logic_vector(103, data_length);
	data_from_up(5) <= conv_std_logic_vector(11, data_length);
	data_from_up(6) <= conv_std_logic_vector(33, data_length);
	data_from_up(7) <= conv_std_logic_vector(189, data_length);	
	
	data_from_up(8) <= conv_std_logic_vector(54, data_length);
	data_from_up(9) <= conv_std_logic_vector(67, data_length);
	data_from_up(10) <= conv_std_logic_vector(82, data_length);
	data_from_up(11) <= conv_std_logic_vector(77, data_length);	
	data_from_up(12) <= conv_std_logic_vector(119, data_length);
	data_from_up(13) <= conv_std_logic_vector(8, data_length);
	data_from_up(14) <= conv_std_logic_vector(4, data_length);
	data_from_up(15) <= conv_std_logic_vector(240, data_length);
	
	data_from_up(16) <= conv_std_logic_vector(21, data_length);
	data_from_up(17) <= conv_std_logic_vector(80, data_length);
	data_from_up(18) <= conv_std_logic_vector(99, data_length);
	data_from_up(19) <= conv_std_logic_vector(178, data_length);	
	data_from_up(20) <= conv_std_logic_vector(141, data_length);
	data_from_up(21) <= conv_std_logic_vector(15, data_length);
	data_from_up(22) <= conv_std_logic_vector(200, data_length);
	data_from_up(23) <= conv_std_logic_vector(53, data_length);	
	
	data_from_up(24) <= conv_std_logic_vector(101, data_length);
	data_from_up(25) <= conv_std_logic_vector(72, data_length);
	data_from_up(26) <= conv_std_logic_vector(123, data_length);
	data_from_up(27) <= conv_std_logic_vector(44, data_length);	
	data_from_up(28) <= conv_std_logic_vector(9, data_length);
	data_from_up(29) <= conv_std_logic_vector(239, data_length);
	data_from_up(30) <= conv_std_logic_vector(1, data_length);
	data_from_up(31) <= conv_std_logic_vector(253, data_length);
	wait for clk_period;
	we_from_up <= (others => '0');
	wait for clk_period;
	start	<= '1';
--	wait for clk_period; 
--	we_from_up <= (others => '1');
--	data_from_up(0) <= conv_std_logic_vector(55, data_length);
--	data_from_up(1) <= conv_std_logic_vector(33, data_length);
--	wait for clk_period;
--	we_from_up <= (others => '0');
--	wait for clk_period;
	wait;
end process;

	DUT : entity work.ASIC_OddEven
		port map( clk, rst, start, done, data_to_up, data_from_up, we_from_up);	
end architecture;
