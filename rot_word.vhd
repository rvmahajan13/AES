library ieee;
use ieee.std_logic_1164.all;

entity rot_word is
	port (
		A: in std_logic_vector(31 downto 0);
		Y: out std_logic_vector(31 downto 0)
	) ;
end rot_word;

architecture arc of rot_word is 
begin
Y(31 downto 24) <= A(7 downto 0);
Y(23 downto 16) <= A(31 downto 24);
Y(15 downto 8) <= A(23 downto 16);
Y(7 downto 0) <= A(15 downto 8);
end architecture;