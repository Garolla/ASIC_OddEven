library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.CONSTANTS.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity TB_PE is
end entity;

architecture TEST of TB_PE is

	-- Clock period definitions
    constant clk_period : time := 10 ns;
	
    signal clk          : std_logic:='0';
    signal rst 		: std_logic:='0';
    signal start   	: std_logic:='0';
    signal done		: std_logic;
    signal we_to_l      : std_logic;
    signal data_to_l    : std_logic_vector(data_length-1 downto 0);
    signal we_from_l	: std_logic;
    signal data_from_l  : std_logic_vector(data_length-1 downto 0);
    signal data_to_up   : grid_data;
    signal data_from_up : grid_data := (others => (others => '0'));
    signal we_from_up   : std_logic_vector(num_PE-1 downto 0):= (others => '0');

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
	we_from_up(0) <= '1';
	data_from_up(0) <= conv_std_logic_vector(11, data_length);
	wait for clk_period; 
	we_from_up(0) <= '0';
	wait for clk_period;
	start	<= '1';
	wait for clk_period;
	wait;
end process;

	DUT_ODD : entity work.PE
		generic map(0)
		port map( clk, rst, start, done, we_to_l, data_from_l, data_to_up, data_from_up, we_from_up);	
	DUT_EVEN : entity work.PE
		generic map(1)
		port map( clk, rst, start, done, we_to_l, data_from_l, data_to_up, data_from_up, we_from_up);	
end architecture;
