library ieee;
use ieee.std_logic_1164.all;

entity xtimes is
	port (
		A: in std_logic_vector(7 downto 0);
		Y: out std_logic_vector(7 downto 0)
	) ;
end xtimes;

architecture arc of xtimes is
signal temp : std_logic_vector(7 downto 0):= (others => '0');
signal temp2 : std_logic_vector(7 downto 0); 

component eight_mux is 
	port(a, b:in std_logic_vector(7 downto 0);
			s: in std_logic;
			y : out std_logic_vector(7 downto 0));
end component;

begin 
lop : for i in 1 to 7 generate
temp(i) <= A(i-1);
end generate;

temp2 <= temp xor "00011011";
inst1 : eight_mux port map(a=>temp2, b=>temp, s=>A(7), y=>Y);
end architecture;