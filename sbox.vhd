library ieee;
use ieee.std_logic_1164.all;

entity sbox is
	port (
		A: in std_logic_vector(7 downto 0);
		Y: out std_logic_vector(7 downto 0)
	) ;
end sbox;

architecture arc of sbox is
signal b, b2, b4, b8, b16, b32, b64, b128, b192, b224, b240, b248, b252, b254 : std_logic_vector(7 downto 0);
signal b_temp : std_logic_vector(7 downto 0);
signal b_sel : std_logic;
signal c : std_logic_vector(7 downto 0):= "01100011";

component multiply is
	port (
		A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		Y: out std_logic_vector(7 downto 0)
	) ;
end component;

component eight_mux is 
	port(a, b:in std_logic_vector(7 downto 0);
			s: in std_logic;
			y : out std_logic_vector(7 downto 0));
end component;
begin 
b <= A;
inst1 : multiply port map(A=>b, B=>b, Y=>b2);
inst2 : multiply port map(A=>b2, B=>b2, Y=>b4);
inst3 : multiply port map(A=>b4, B=>b4, Y=>b8);
inst4 : multiply port map(A=>b8, B=>b8, Y=>b16);
inst5 : multiply port map(A=>b16, B=>b16, Y=>b32);
inst6 : multiply port map(A=>b32, B=>b32, Y=>b64);
inst7 : multiply port map(A=>b64, B=>b64, Y=>b128);

inst8 : multiply port map(A=>b128, B=>b64, Y=>b192);
inst9 : multiply port map(A=>b192, B=>b32, Y=>b224);
inst10 : multiply port map(A=>b224, B=>b16, Y=>b240);
inst11 : multiply port map(A=>b240, B=>b8, Y=>b248);
inst12 : multiply port map(A=>b248, B=>b4, Y=>b252);
inst13 : multiply port map(A=>b252, B=>b2, Y=>b254);

b_sel <= A(7) or A(6) or A(5) or A(4) or A(3) or A(2) or A(1) or A(0);

inst14 : eight_mux port map(a=>b254, b=>"00000000", s=>b_sel, y=>b_temp);

lop : for i in 0 to 7 generate
Y(i) <= b_temp(i) xor b_temp((i+4) mod 8) xor b_temp((i+5) mod 8) xor b_temp((i+6) mod 8) xor b_temp((i+7) mod 8) xor c(i); 
end generate;
end architecture;