library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Utilities.all;

entity shiftrows is
	port (
		A: in matrix;
		Y: out matrix
	) ;
end shiftrows;

architecture a of shiftrows is 

begin
l1 : for i in 0 to 3 generate
	l2 : for j in 0 to 3 generate
		Y(i, j) <= A(i, (i+j) mod 4);
	end generate l2;
end generate l1;
end architecture;
