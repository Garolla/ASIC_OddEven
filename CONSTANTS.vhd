library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package CONSTANTS is

constant num_PE					: integer := 2; 
constant num_of_cycles			: integer := num_PE/2; 
constant position_length		: integer := 10; 
constant address_length			: integer := 6; 
constant data_length			: integer := 16; 

type grid_data is array (num_PE -1 downto 0) of std_logic_vector(data_length-1 downto 0);

end package CONSTANTS;
