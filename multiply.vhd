library ieee;
use ieee.std_logic_1164.all;

entity multiply is
	port (
		A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		Y: out std_logic_vector(7 downto 0)
	) ;
end multiply;

architecture arc of multiply is
signal t1, t2, t4, t8, t10, t20, t40, t80 : std_logic_vector(7 downto 0); 
signal y0, y1, y2, y3, y4, y5, y6, y7: std_logic_vector(7 downto 0); 
--signal b_sel : std_logic;

component xtimes is
	port (
		A: in std_logic_vector(7 downto 0);
		Y: out std_logic_vector(7 downto 0)
	) ;
end component;

component eight_mux is 
	port(a, b:in std_logic_vector(7 downto 0);
			s: in std_logic;
			y : out std_logic_vector(7 downto 0));
end component;

begin 
t1 <= A;
inst1 : xtimes port map(A=>t1, Y=>t2);
inst2 : xtimes port map(A=>t2, Y=>t4);
inst3 : xtimes port map(A=>t4, Y=>t8);
inst4 : xtimes port map(A=>t8, Y=>t10);
inst5 : xtimes port map(A=>t10, Y=>t20);
inst6 : xtimes port map(A=>t20, Y=>t40);
inst7 : xtimes port map(A=>t40, Y=>t80);

--b_sel <= 

inst8: eight_mux port map(a=>t80, b=>"00000000", s=>b(7), y=>y7); 
inst9: eight_mux port map(a=>t40, b=>"00000000", s=>b(6), y=>y6); 
inst10: eight_mux port map(a=>t20, b=>"00000000", s=>b(5), y=>y5); 
inst11: eight_mux port map(a=>t10, b=>"00000000", s=>b(4), y=>y4); 
inst12: eight_mux port map(a=>t8, b=>"00000000", s=>b(3), y=>y3); 
inst13: eight_mux port map(a=>t4, b=>"00000000", s=>b(2), y=>y2); 
inst14: eight_mux port map(a=>t2, b=>"00000000", s=>b(1), y=>y1); 
inst15: eight_mux port map(a=>t1, b=>"00000000", s=>b(0), y=>y0); 

Y<= y0 xor y1 xor y2 xor y3 xor y4 xor y5 xor y6 xor y7;
end architecture;