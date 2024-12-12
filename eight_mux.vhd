library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity eight_mux is 
	port(a, b:in std_logic_vector(7 downto 0);
			s: in std_logic;
			y : out std_logic_vector(7 downto 0));
end entity;

architecture struct of eight_mux is 
	--signal s0, s1, s2: std_logic;
	
	component two_one_mux is 
	port(a, b, s:in std_logic;
			y : out std_logic);
	end component;
	
begin
	lop : for i in 0 to 7 generate
	inst1: two_one_mux port map(a=>a(i), b=>b(i), s=>s, y=>y(i));
	end generate;
end architecture;