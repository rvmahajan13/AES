library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Utilities.all;

entity mixcolumns is
	port (
		A: in matrix;
		Y: out matrix
	) ;
end mixcolumns;

architecture a of mixcolumns is 

component multiply is
	port (
		A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		Y: out std_logic_vector(7 downto 0)
	) ;
end component;

begin
l1 : for i in 0 to 3 generate
signal t1, t2, t3, t4, t5, t6, t7, t8 : std_logic_vector(7 downto 0);
begin
	inst1 : multiply port map(A=>"00000010", B=>A(0, i), Y=>t1);
	inst2 : multiply port map(A=>"00000010", B=>A(1, i), Y=>t2);
	inst3 : multiply port map(A=>"00000010", B=>A(2, i), Y=>t3);
	inst4 : multiply port map(A=>"00000010", B=>A(3, i), Y=>t4);
	
	inst5 : multiply port map(A=>"00000011", B=>A(0, i), Y=>t8);
	inst6 : multiply port map(A=>"00000011", B=>A(1, i), Y=>t5);
	inst7 : multiply port map(A=>"00000011", B=>A(2, i), Y=>t6);
	inst8 : multiply port map(A=>"00000011", B=>A(3, i), Y=>t7);
	
	Y(0, i) <= t1 xor t5 xor A(2, i) xor A(3, i);
	Y(1, i) <= A(0, i) xor t2 xor t6 xor A(3, i);
	Y(2, i) <= A(0, i) xor A(1, i) xor t3 xor t7;
	Y(3, i) <= t8 xor A(1, i) xor A(2, i) xor t4;
end generate l1;
end architecture;
