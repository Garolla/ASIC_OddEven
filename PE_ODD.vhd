library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
use work.CONSTANTS.all;

entity PE_ODD is
	Port (
			clk          : in std_logic;
			rst          : in std_logic;
			start   	 : in std_logic;
			done		 : out std_logic;
			we_to_l      : out std_logic;
			data_to_l    : out std_logic_vector(data_length-1 downto 0);
			we_from_l	 : in std_logic;
			data_from_l  : in std_logic_vector(data_length-1 downto 0);
			we_from_up	 : in std_logic;
			data_from_up : in std_logic_vector(data_length-1 downto 0);
			data_to_up   : out std_logic_vector(data_length-1 downto 0)
	 );
end PE_ODD;

architecture Behavioral of PE_ODD is
signal my_data: std_logic_vector(data_length-1 downto 0);
signal curr_state, next_state: std_logic := '0';
signal cycles_counter: integer range 0 to num_PE;

begin

data_to_up <= my_data;
done <= '1' when (cycles_counter = num_of_cycles) else '0'; -- End of the algorithm		

process(clk,rst)
begin
if rst ='1' then
	curr_state<= '0';
elsif rising_edge(clk) then	
	curr_state<= next_state;
end if;
end process;


process(clk, rst, we_from_up, we_from_l,start, curr_state)
begin
	if rst = '1' then
		my_data <= (others => '0');
		data_to_l <= (others => '0');
		we_to_l <= '0';
		next_state <= '0';		
	elsif rising_edge(clk) then				
        if we_from_up ='1' then
	    	my_data <= data_from_up; 
	    elsif start = '1' then 
	    	cycles_counter <= cycles_counter+1;
			if curr_state = '0' then
				my_data <= my_data;
				data_to_l <= (others => '0');
				we_to_l <= '0';
				next_state <= '1';				
			elsif curr_state = '1' then
				-- if left is bigger than me => swap
				if  (we_from_l = '1' and to_integer(signed(data_from_l)) >= to_integer(signed(my_data))) then
					my_data <= data_from_l;
					data_to_l <= my_data;
					we_to_l <= '1';
				else
					my_data <= my_data;
					data_to_l <= (others => '0');
					we_to_l <= '0';
				end if;
				next_state <= '0';
			end if;
		end if;	
	end if;
end process;
end Behavioral;
