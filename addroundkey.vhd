library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Utilities.all;
use ieee.numeric_std.all;

entity addroundkey is
	port (
		A: in matrix;
		round_key : in std_logic_vector(127 downto 0);
		Y: out matrix
	) ;
end addroundkey;

architecture a of addroundkey is 
begin
l1 : for i in 0 to 3 generate
	Y(0, i) <= A(0, i) xor round_key(32*i+31 downto 32*i+24);
	Y(1, i) <= A(1, i) xor round_key(32*i+23 downto 32*i+16);
	Y(2, i) <= A(2, i) xor round_key(32*i+15 downto 32*i+8);
	Y(3, i) <= A(3, i) xor round_key(32*i+7 downto 32*i);
end generate l1;
end architecture;
