library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Utilities.all;


entity cipher is
	port (
		inp: in std_logic_vector(127 downto 0);
		key: in std_logic_vector(127 downto 0);
		op: out std_logic_vector(127 downto 0)
	) ;
end cipher;

architecture a of cipher is 
type arr is array(0 to 9) of matrix;
signal state, state1, state2, state3, state4 : arr;
signal w_int : std_logic_vector(1407 downto 0) := (others => '0');

component key_expansion is
	port (
		key: in std_logic_vector(127 downto 0);
		w: out std_logic_vector(1407 downto 0)
	) ;
end component;

component addroundkey is
	port (
		A: in matrix;
		round_key : in std_logic_vector(127 downto 0);
		Y: out matrix
	) ;
end component;

component subbytes is
	port (
		A: in matrix;
		Y: out matrix
	) ;
end component;

component shiftrows is
	port (
		A: in matrix;
		Y: out matrix
	) ;
end component;

component mixcolumns is
	port (
		A: in matrix;
		Y: out matrix
	) ;
end component;

begin

inst1 : key_expansion port map(key=>key, w=>w_int);

l1 : for i in 0 to 3 generate
	l2 : for j in 0 to 3 generate
		state(i, j) <= inp(8*i + 32*j + 7 downto 8*i+32*j);
	end generate l2;
end generate l1;

inst2 : addroundkey port map(A=>state, round_key=>w_int(127 downto 0), Y=>state1(0));

encrypt : for i in 1 to 9 generate
inst3 : subbytes port map(A=>state1(i-1), Y=>state2(i-1));
inst4 : shiftrows port map(A=>state2(i-1), Y=>state3(i-1));
inst5 : mixcolumns port map(A=>state3(i-1), Y=>state4(i-1));
inst6 : addroundkey port map(A=>state4(i-1), round_key=>w_int(128*i+127 downto 128*i), Y=>state1(i));
end generate encrypt;

inst7 : subbytes port map(A=>state1(9), Y=>state2(9));
inst8 : shiftrows port map(A=>state2(9), Y=>state3(9));
inst6 : addroundkey port map(A=>state3(9), round_key=>w_int(1407 downto 1280), Y=>state4(9));

l3 : for i in 0 to 3 generate
	l4 : for j in 0 to 3 generate
		op(8*i + 32*j + 7 downto 8*i+32*j) <= state4(9)(i, j);
	end generate l4;
end generate l3;

end architecture;
