library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
use work.CONSTANTS.all;

entity PE is
	Port (
			clk          : in std_logic;
			rst          : in std_logic;
			start   	 : in std_logic;
			done		 : out std_logic;
			we_to_l      : out std_logic;
			data_to_l    : out std_logic_vector(data_length-1 downto 0);
			data_from_l  : in std_logic_vector(data_length-1 downto 0);
			data_to_r    : out std_logic_vector(data_length-1 downto 0);
			we_from_r	 : in std_logic;
			data_from_r  : in std_logic_vector(data_length-1 downto 0);
			we_from_up	 : in std_logic;
			we_to_up	 : out std_logic;
			address_in	 : in std_logic_vector(address_length-1 downto 0 );
			address_out  : out std_logic_vector(address_length-1 downto 0 );
			data_from_up : in std_logic_vector(data_length-1 downto 0);
			data_to_up   : out std_logic_vector(data_length-1 downto 0)
	 );
end PE;

architecture Behavioral of PE is
signal my_data: std_logic_vector(data_length-1 downto 0);
signal state: std_logic := '0';
signal cycles_counter: integer range 0 to num_PE;

begin

process(clk, rst, we_from_up, we_from_r)
begin
	if rst = '1' then
		my_data <= (others => '0');
		data_to_l <= (others => '0');
		data_to_r <= (others => '0');
		we_to_l <= '0';
		cycles_counter <= 0;
		state <= '0';		
	elsif rising_edge(clk) then	
		we_to_up <= we_from_up;
		data_to_up  <= data_from_up;
		if unsigned(address_in) /= 0 then
			address_out <= std_logic_vector(signed(address_in)-1); 
		else 
			address_out <= (others => '0');
		end if;
	
        if we_from_up ='1' then
        	if unsigned(address_in) = 1 then 
	    		my_data <= data_from_up;
	    		cycles_counter <= 0;
	    	end if;
	    --Starting the algo	
	    elsif start = '1' then 
	    if  (cycles_counter = algo_length) then
	    	done <= '1'; -- End of the algorithms
	    else
	    	done <= '0';
	    end if;	
	    cycles_counter <= cycles_counter+1;	
		if state = '0' then
			-- if left is bigger than me => swap
			if  (to_integer(unsigned(data_from_l)) > to_integer(unsigned(my_data))) then
				my_data <= data_from_l;
				data_to_l <= my_data;
				we_to_l <= '1';
			else
				my_data <= my_data;
				data_to_l <= (others => '0');
				we_to_l <= '0';
			end if;
			--data_to_r <= (others => '0');
			state <= '1';
		elsif state = '1' then
			if  (we_from_r = '1') then
				my_data <= data_from_r;
			end if;
			data_to_r <= my_data;
			--data_to_l <= (others => '0');
			--we_to_l <= '0';
			state <= '0';
		end if;	
	end if;
	end if;
end process;
end Behavioral;
