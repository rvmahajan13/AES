library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Utilities.all;

entity subbytes is
	port (
		A: in matrix;
		Y: out matrix
	) ;
end subbytes;

architecture a of subbytes is 
--signal state : matrix;

component sbox is
	port (
		A: in std_logic_vector(7 downto 0);
		Y: out std_logic_vector(7 downto 0)
	) ;
end component;

begin
l1 : for i in 0 to 3 generate
	l2 : for j in 0 to 3 generate
		inst1 : sbox port map(A=>A(i, j), Y=>Y(i, j));
	end generate l2;
end generate l1;
end architecture;
