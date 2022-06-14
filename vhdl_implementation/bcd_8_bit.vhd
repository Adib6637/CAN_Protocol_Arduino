
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_8_bit is
    port (
        input_8_bit:    in  bit_vector (7 downto 0);
        bcd:    out bit_vector (11 downto 0)
    );
end entity;

architecture behavioural of bcd_8_bit is

	signal add3_0 : bit_vector ( 3 downto 0);
	signal add3_1 : bit_vector ( 3 downto 0);
	signal add3_2 : bit_vector ( 3 downto 0);
	signal add3_3 : bit_vector ( 3 downto 0);
	signal add3_4 : bit_vector ( 3 downto 0);
	signal add3_5 : bit_vector ( 3 downto 0);
	signal add3_6 : bit_vector ( 3 downto 0);

	signal add3_0_input : bit_vector ( 3 downto 0);
	signal add3_1_input : bit_vector ( 3 downto 0);
	signal add3_2_input : bit_vector ( 3 downto 0);
	signal add3_3_input : bit_vector ( 3 downto 0);
	signal add3_4_input : bit_vector ( 3 downto 0);
	signal add3_5_input : bit_vector ( 3 downto 0);
	signal add3_6_input : bit_vector ( 3 downto 0);

	component add3 is
		port(	input: in bit_vector(3 downto 0);
			output : out bit_vector(3 downto 0));
	end component;
	
	begin

		add30 : add3 port map ( 	input => add3_0_input,
						output => add3_0 );

		add31 : add3 port map ( 	input => add3_1_input,
						output => add3_1 );

		add32 : add3 port map ( 	input => add3_2_input,
						output => add3_2 );

		add33 : add3 port map ( 	input => add3_3_input,
						output => add3_3 );

		add34 : add3 port map ( 	input => add3_4_input,
						output => add3_4 );

		add35 : add3 port map ( 	input => add3_5_input,
						output => add3_5 );

		add36 : add3 port map ( 	input => add3_6_input,
						output => add3_6 );


		add3_0_input <= '0' & input_8_bit(7) & input_8_bit(6) & input_8_bit(5);
		add3_1_input <= add3_0(2) & add3_0(1) & add3_0(0) & input_8_bit(4);
		add3_2_input <= add3_1(2) & add3_1(1) & add3_1(0) & input_8_bit(3);
		add3_3_input <= add3_2(2) & add3_2(1) & add3_2(0) & input_8_bit(2);
		add3_4_input <= add3_3(2) & add3_3(1) & add3_3(0) & input_8_bit(1);
		add3_5_input <= '0' & add3_0(3) & add3_1(3) & add3_2(3);
		add3_6_input <= add3_5(2) & add3_5(1) & add3_5(0) & add3_3(3);
		bcd <= '0' & '0' & add3_5(3) & add3_6(3) & add3_6(2) & add3_6(1) & add3_6(0) & add3_4(3) & add3_4(2) & add3_4(1) & add3_4(0) & input_8_bit(0);

end architecture;