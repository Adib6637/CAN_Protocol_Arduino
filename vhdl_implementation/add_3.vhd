entity add3 is
	port(	input: in bit_vector(3 downto 0);
		output : out bit_vector(3 downto 0));
end entity;

architecture behavioural of add3 is

	signal Cin_s: bit;
	signal Cout_s: bit;
	signal output_s : bit_vector(3 downto 0);
	signal fix_value : bit_vector(3 downto 0);
	signal condition: bit;

	component full_adder_4_bit is
	port(	A : in bit_vector(3 downto 0); 
		B : in bit_vector(3 downto 0); 
		Cin : in bit;
		S: out bit_vector (3 downto 0);
		Cout : out bit);

	end component;


	begin 

	adder1 : full_adder_4_bit port map (	A => input, 
							B => fix_value,
							Cin => Cin_s, 
							S => output_s,
							Cout => Cout_s);

        condition <= input(3) or (input(2) and (input(1) or input(0)));

	mode : process (condition)
		begin

        	if condition = '1' then
            		fix_value <= "0011";
        	else
            		fix_value <= "0000";
		end if;
	end process;

	output <=  output_s;
end architecture;
