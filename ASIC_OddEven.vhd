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
			address_in	 : in std_logic_vector(address_length-1 downto 0 );
			address_out	 : out std_logic_vector(address_length-1 downto 0 );
			data_to_up   : out std_logic_vector(data_length-1 downto 0);
			data_from_up : in std_logic_vector(data_length-1 downto 0);
			we_from_up   : in std_logic;
			we_to_up     : out std_logic
);
end ASIC_OddEven;

architecture Behavioral of ASIC_OddEven is
signal data_to_l   : grid_data;
signal we_to_l     : std_logic_vector(num_PE-1 downto 0);
signal data_from_l : grid_data;
signal data_to_r   : grid_data;
signal data_from_r : grid_data;
signal we_from_r   : std_logic_vector(num_PE-1 downto 0);
signal done_int    : std_logic_vector(num_PE-1 downto 0);	
begin

done <= and_reduce(done_int);

cores:  for i in 0 to num_PE-1 generate
		pe_i:entity work.PE
			Port map(
				clk			 => clk,
				rst			 => rst,
				start   	 => start,
				done		 => done_int(i), 
				we_to_l      => we_to_l(i),
				data_to_l    => data_to_l(i),
				data_from_l  => data_from_l(i),
				data_to_r	 => data_to_r(i),
				we_from_r	 => we_from_r(i),
				data_from_r  => data_from_r(i),
				we_from_up	 => we_from_up,
				we_to_up	 => we_to_up,
				address_in	 => address_in,
				address_out	 => address_out,
				data_from_up => data_from_up,
				data_to_up   => data_to_up
				);
				
				connections_cent1 : if i/=0 and i/=(num_PE-1)  generate	
					data_from_l(i) <= data_to_r(i-1) ;
					data_from_r(i) <= data_to_l(i+1);
					we_from_r(i)   <= we_to_l(i+1)	;
				end generate connections_cent1;									
						
				left_borderline : if i= 0 generate
					data_from_l(i) <= (others => '0');
					data_from_r(i) <= data_to_l(i+1);
					we_from_r(i)   <= we_to_l(i+1)	;
				end generate left_borderline;
				
				right_borderline : if i=(num_PE-1) generate	
					data_from_l(i) <= data_to_r(i-1) ;
					data_from_r(i) <= (others => '0');
					we_from_r(i)   <= '0';
				end generate right_borderline;	
end generate cores;

end Behavioral;
