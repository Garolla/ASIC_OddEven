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
	
	data_from_up(32) <= conv_std_logic_vector(62, data_length);
	data_from_up(33) <= conv_std_logic_vector(62, data_length);
	data_from_up(34) <= conv_std_logic_vector(62, data_length);
	data_from_up(35) <= conv_std_logic_vector(87, data_length);	
	data_from_up(36) <= conv_std_logic_vector(103, data_length);
	data_from_up(37) <= conv_std_logic_vector(109, data_length);
	data_from_up(38) <= conv_std_logic_vector(144, data_length);
	data_from_up(39) <= conv_std_logic_vector(100, data_length);	
	
	data_from_up(40) <= conv_std_logic_vector(99, data_length);
	data_from_up(41) <= conv_std_logic_vector(98, data_length);
	data_from_up(42) <= conv_std_logic_vector(195, data_length);
	data_from_up(43) <= conv_std_logic_vector(77, data_length);	
	data_from_up(44) <= conv_std_logic_vector(119, data_length);
	data_from_up(45) <= conv_std_logic_vector(8, data_length);
	data_from_up(46) <= conv_std_logic_vector(4, data_length);
	data_from_up(47) <= conv_std_logic_vector(20, data_length);
	
	data_from_up(48) <= conv_std_logic_vector(29, data_length);
	data_from_up(49) <= conv_std_logic_vector(35, data_length);
	data_from_up(50) <= conv_std_logic_vector(32, data_length);
	data_from_up(51) <= conv_std_logic_vector(169, data_length);	
	data_from_up(52) <= conv_std_logic_vector(123, data_length);
	data_from_up(53) <= conv_std_logic_vector(27, data_length);
	data_from_up(54) <= conv_std_logic_vector(244, data_length);
	data_from_up(55) <= conv_std_logic_vector(246, data_length);	
	
	data_from_up(56) <= conv_std_logic_vector(3, data_length);
	data_from_up(57) <= conv_std_logic_vector(72, data_length);
	data_from_up(58) <= conv_std_logic_vector(60, data_length);
	data_from_up(59) <= conv_std_logic_vector(88, data_length);	
	data_from_up(60) <= conv_std_logic_vector(9, data_length);
	data_from_up(61) <= conv_std_logic_vector(239, data_length);
	data_from_up(62) <= conv_std_logic_vector(222, data_length);
	data_from_up(63) <= conv_std_logic_vector(254, data_length);
	

	data_from_up(64) <= conv_std_logic_vector(300, data_length);
	data_from_up(65) <= conv_std_logic_vector(301, data_length);
	data_from_up(66) <= conv_std_logic_vector(302, data_length);
	data_from_up(67) <= conv_std_logic_vector(303, data_length);	
	data_from_up(68) <= conv_std_logic_vector(304, data_length);
	data_from_up(69) <= conv_std_logic_vector(305, data_length);
	data_from_up(70) <= conv_std_logic_vector(306, data_length);
	data_from_up(71) <= conv_std_logic_vector(307, data_length);	
	
	data_from_up(72) <= conv_std_logic_vector(308, data_length);
	data_from_up(73) <= conv_std_logic_vector(309, data_length);
	data_from_up(74) <= conv_std_logic_vector(310, data_length);
	data_from_up(75) <= conv_std_logic_vector(311, data_length);	
	data_from_up(76) <= conv_std_logic_vector(312, data_length);
	data_from_up(77) <= conv_std_logic_vector(313, data_length);
	data_from_up(78) <= conv_std_logic_vector(314, data_length);
	data_from_up(79) <= conv_std_logic_vector(315, data_length);
	
	data_from_up(80) <= conv_std_logic_vector(316, data_length);
	data_from_up(81) <= conv_std_logic_vector(317, data_length);
	data_from_up(82) <= conv_std_logic_vector(318, data_length);
	data_from_up(83) <= conv_std_logic_vector(319, data_length);	
	data_from_up(84) <= conv_std_logic_vector(320, data_length);
	data_from_up(85) <= conv_std_logic_vector(321, data_length);
	data_from_up(86) <= conv_std_logic_vector(322, data_length);
	data_from_up(87) <= conv_std_logic_vector(323, data_length);	
	
	data_from_up(88) <= conv_std_logic_vector(324, data_length);
	data_from_up(89) <= conv_std_logic_vector(325, data_length);
	data_from_up(90) <= conv_std_logic_vector(326, data_length);
	data_from_up(91) <= conv_std_logic_vector(327, data_length);	
	data_from_up(92) <= conv_std_logic_vector(328, data_length);
	data_from_up(93) <= conv_std_logic_vector(329, data_length);
	data_from_up(94) <= conv_std_logic_vector(330, data_length);
	data_from_up(95) <= conv_std_logic_vector(331, data_length);
	
	data_from_up(96) <= conv_std_logic_vector(531, data_length);
	data_from_up(97) <= conv_std_logic_vector(530, data_length);
	data_from_up(98) <= conv_std_logic_vector(529, data_length);
	data_from_up(99) <= conv_std_logic_vector(528, data_length);	
	data_from_up(100) <= conv_std_logic_vector(527, data_length);
	data_from_up(101) <= conv_std_logic_vector(526, data_length);
	data_from_up(102) <= conv_std_logic_vector(525, data_length);
	data_from_up(103) <= conv_std_logic_vector(524, data_length);	
	
	data_from_up(104) <= conv_std_logic_vector(523, data_length);
	data_from_up(105) <= conv_std_logic_vector(522, data_length);
	data_from_up(106) <= conv_std_logic_vector(521, data_length);
	data_from_up(107) <= conv_std_logic_vector(520, data_length);	
	data_from_up(108) <= conv_std_logic_vector(519, data_length);
	data_from_up(109) <= conv_std_logic_vector(518, data_length);
	data_from_up(110) <= conv_std_logic_vector(517, data_length);
	data_from_up(111) <= conv_std_logic_vector(516, data_length);
	
	data_from_up(112) <= conv_std_logic_vector(515, data_length);
	data_from_up(113) <= conv_std_logic_vector(514, data_length);
	data_from_up(114) <= conv_std_logic_vector(513, data_length);
	data_from_up(115) <= conv_std_logic_vector(512, data_length);	
	data_from_up(116) <= conv_std_logic_vector(511, data_length);
	data_from_up(117) <= conv_std_logic_vector(510, data_length);
	data_from_up(118) <= conv_std_logic_vector(509, data_length);
	data_from_up(119) <= conv_std_logic_vector(508, data_length);	
	
	data_from_up(120) <= conv_std_logic_vector(507, data_length);
	data_from_up(121) <= conv_std_logic_vector(506, data_length);
	data_from_up(122) <= conv_std_logic_vector(505, data_length);
	data_from_up(123) <= conv_std_logic_vector(504, data_length);	
	data_from_up(124) <= conv_std_logic_vector(503, data_length);
	data_from_up(125) <= conv_std_logic_vector(502, data_length);
	data_from_up(126) <= conv_std_logic_vector(501, data_length);
	data_from_up(127) <= conv_std_logic_vector(500, data_length);	
	
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
