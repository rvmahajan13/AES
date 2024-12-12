library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity two_one_mux is 
	port(a, b, s:in std_logic;
			y : out std_logic);
end entity;

architecture struct of two_one_mux is 
	signal s0, s1, s2: std_logic;
	
begin
	inst1: INVERTER port map(a=>s, y=>s0);
	inst2: AND_2 port map(a=>b, b=>s0, y=>s1);
	inst3: AND_2 port map(a=>a, b=>s, y=>s2);
	inst4: OR_2 port map(a=>s1, b=>s2, y=>y);
end architecture;