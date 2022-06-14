
library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity parkingLotSystem is
 	port (	rst, clk: in std_logic;
		input : in std_logic_vector(3 downto 0); 
		
		counter : out std_logic_vector(7 downto 0); 
		led_red : out std_logic;
		gate_close : out std_logic;
		led_green : out std_logic;
		gate_open : out std_logic;
		ready : in std_logic;
		
		digit3port : out bit_vector(6 downto 0);
		digit2port : out bit_vector(6 downto 0);
		digit1port : out bit_vector(6 downto 0)
		);
		
end entity parkingLotSystem;


architecture behavioral of parkingLotSystem is
 	type state is (idle, display, full);
 	signal current_state, next_state: state;				
	signal counter_s: std_logic_vector(7 downto 0):= x"00";
	signal counter_s_bit: bit_vector(7 downto 0);
	signal led_s, gate_s : std_logic := '1';  
	signal space_state : std_logic;

	signal bcd_3 : bit_vector(3 downto 0);
	signal bcd_2 : bit_vector(3 downto 0);
	signal bcd_1 : bit_vector(3 downto 0);
	signal bcd_full : bit_vector(11 downto 0);


	component bcd_8_bit is
    		port (	input_8_bit:    in  bit_vector (7 downto 0);
        		bcd:    out bit_vector (11 downto 0)
    	);
	end component;

	component LED_7segment is
	Port ( 	input : in bit_vector (3 downto 0);
		LED_out : out bit_vector (6 downto 0));
	end component;


	begin
		converter1 : bcd_8_bit port map ( 	input_8_bit => counter_s_bit,
							bcd => bcd_full );

		digit3 : LED_7segment port map (	input => bcd_3,
							LED_out => digit3port);
		digit2 : LED_7segment port map (	input => bcd_2,
							LED_out => digit2port);
		digit1 : LED_7segment port map (	input => bcd_1,
							LED_out => digit1port);

		state_memory: process(clk, rst)
 		begin
 			if rst = '1' then
 				current_state <= idle;
 			elsif (clk = '1' and clk'event) then
 				current_state <= next_state;
 			end if;
 		end process;


		sysInput: process(current_state, input,space_state)
		begin
 			case current_state is
				when idle => 	if input = "0001" then
							next_state <= display;
						elsif input = "0010" then
							next_state <= display;
						else 
							next_state <= idle;
						end if;






				when display => if (space_state = '1' and ready = '1') then
							next_state <= idle;
						elsif (space_state = '0' and ready = '1') then
							next_state <= full;
						else
							next_state <= display;
						end if;

	
				when full => 	if input = "0010" then
							next_state <= display;
						else 
							next_state <= full;
						end if;
 			end case;
		end process;



		ledProcess : process(current_state)
		begin
			case current_state is
				when idle => led_s <= '1';	
	
				when display =>	led_s <= '1';	

				when full => led_s <= '0';	
			end case;
		end process;
		gateProcess : process(current_state)
			begin
				case current_state is
					when idle => gate_s <= '1';	
	
					when display =>	gate_s <= '1';	

					when full => gate_s <= '0';	
				end case;
		end process;

		carCounter : process(current_state, input, clk)
			begin
				case current_state is
					when idle => 	if ( input="0001" and clk = '0' and clk'event  )  then		-- car enter
								counter_s <= counter_s + '1' ;   -- counting up
							elsif (input="0010"  and clk = '0' and clk'event  )  then		-- car leave
								counter_s <= counter_s - '1' ;   -- counting down
							end if;
					when display =>	counter_s <= counter_s ;	

					when full => 	if input="0010"  then		-- car leave
								counter_s <= counter_s - '1' after 100 ps;   -- counting down
							end if;
				end case;
		end process;
		
		space_checker : process(counter_s)
			begin
			if counter_s < "1101"  then
				space_state <= '1';
			else 
				space_state <= '0';
			end if;
			
		end process;
		

		counter_s_bit <= to_bitvector(counter_s);
		counter <= counter_s;
		gate_open <= gate_s;
		led_green <= led_s;
		gate_close <= not gate_s;
		led_red <= not led_s;

		bcd_3 <= bcd_full(11 downto 8);
		bcd_2 <= bcd_full(7 downto 4);
		bcd_1 <=  bcd_full(3 downto 0);
end architecture;