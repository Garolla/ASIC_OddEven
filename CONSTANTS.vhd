library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package CONSTANTS is
function log2(i: natural) return integer;


constant num_PE			: integer := 4;  -- Must be a power of 2


constant algo_length			: integer := 2*num_PE; 
constant address_length			: integer := log2(num_PE) + 1; 
constant data_length			: integer := 8; 
type grid_data is array (num_PE -1 downto 0) of std_logic_vector(data_length-1 downto 0);
type grid_add is array (num_PE -1 downto 0) of std_logic_vector(address_length-1 downto 0);
end CONSTANTS;

package body CONSTANTS is

function log2(i: natural) return integer is
variable temp : integer := i;
variable ret_val : integer := 0;
begin
while temp > 1 loop
ret_val := ret_val +1;
temp := temp/2;
end loop;
return ret_val;
end function;

end CONSTANTS;
