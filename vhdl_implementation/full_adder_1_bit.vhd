
entity full_adder_1_bit is
	port(	A,B,Cin : in bit;
		S,Cout: out bit);
end entity;

architecture data of full_adder_1_bit is
	signal c0,s0,c1 : bit;

	component half_adder_1_bit
		port(	A,B : in bit;
			S,C : out bit);
	end component;

	begin
		U1 : half_adder_1_bit port map (A =>A, B=>B, C=>c0, S =>s0);
		U2 : half_adder_1_bit port map (A =>s0, B=>Cin, C=>c1, S =>S);
		U3 : Cout <= c0 or c1;
end architecture;