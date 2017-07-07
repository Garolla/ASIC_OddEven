library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
use work.CONSTANTS.all;

entity ASIC_OddEven is
Port ( 
			clk          : in std_logic;
			rst 		 : in std_logic;
			start   	 : in std_logic;
			done		 : out std_logic;
			data_to_up   : out  grid_data;
			data_from_up : in  grid_data;
			we_from_up   : in std_logic_vector(num_PE-1 downto 0)
);
end ASIC_OddEven;

architecture Behavioral of ASIC_OddEven is
signal data_to_l   : grid_data;
signal we_to_l     : std_logic_vector(num_PE-1 downto 0);
signal data_from_l : grid_data;
signal we_from_l   : std_logic_vector(num_PE-1 downto 0);
signal done_int    : std_logic_vector(num_PE-1 downto 0);	
begin

done <= and_reduce(done_int);

cores:  for i in 0 to num_PE-1 generate
		pe_i:entity work.PE
			generic map (i mod 2)
			Port map(
				clk			 => clk,
				rst			 => rst,
				start   	 => start,
				done		 => done_int(i), 
				we_to_l      => we_to_l(i),
				data_to_l    => data_to_l(i),
				we_from_l	 => we_from_l(i),
				data_from_l  => data_from_l(i),
				we_from_up	 => we_from_up(i),
				data_from_up => data_from_up(i),
				data_to_up   => data_to_up(i)
				);
end generate cores;
end Behavioral;
