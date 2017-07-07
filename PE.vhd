library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
use work.CONSTANTS.all;

entity PE is
	generic (parity   : integer range 0 to 1);
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
end PE;

architecture Behavioral of PE is
signal my_data: std_logic_vector(data_length-1 downto 0);
signal wait_even: std_logic := '0';
signal wait_odd: std_logic := '1';
signal cycles_counter: integer 0 to num_PE;

begin

data_to_up <= my_data when done = '1';

process(clk, rst, we_from_up, we_from_l)
begin
	if rst = '1' then
		my_data <= (others => '0');
		data_to_l <= (others => '0');
		we_to_l <= '0';
		wait_even <= '0';
		wait_odd  <= '1';			
	elsif rising_edge(clk) then				
        if we_from_up ='1' then
	    	my_data <= data_from_up; 
	    elsif start = '1' then 	 		
		if parity = 0 then
			if wait_even = '0' then
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
				wait_even <= '1';
			elsif wait_even = '1' then
				my_data <= my_data;
				data_to_l <= (others => '0');
				we_to_l <= '0';
				wait_even <= '0';
			end if;	
				
		elsif parity = 1 then
			if wait_odd = '0' then
				my_data <= my_data;
				data_to_l <= (others => '0');
				we_to_l <= '0';
				wait_odd <= '1';				
			elsif wait_odd = '1' then
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
				wait_odd <= '0';
			end if;	
		end if;	
	end if;
end process;
end Behavioral;
