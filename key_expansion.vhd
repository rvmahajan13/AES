library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity key_expansion is
	port (
		key: in std_logic_vector(127 downto 0);
		w: out std_logic_vector(1407 downto 0)
	) ;
end key_expansion;

architecture a of key_expansion is

signal Rcon : std_logic_vector(319 downto 0):= (others => '0');
signal w_int : std_logic_vector(1407 downto 0):= (others => '0');

component rot_word is
	port(A: in std_logic_vector(31 downto 0);
			Y : out std_logic_vector(31 downto 0));
	end component;
	
	component sbox is
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
Rcon(24) <= '1';
Rcon(57) <= '1';
Rcon(90) <= '1';
Rcon(123) <= '1';
Rcon(156) <= '1';
Rcon(189) <= '1';
Rcon(222) <= '1';
Rcon(255) <= '1';
Rcon(287 downto 280) <= "00011011";
Rcon(319 downto 312) <= "00110110";

w_int(127 downto 0) <= key;

expand : for i in 4 to 43 generate
signal temp3_i : std_logic_vector(31 downto 0);
signal selv : std_logic_vector(1 downto 0);
signal sel : std_logic;
signal temp0, temp1, temp2, temp4 : std_logic_vector(31 downto 0);

begin
temp0 <= w_int(32*i-1 downto 32*(i-1));

inst1 : rot_word port map(A=>w_int(32*i-1 downto 32*(i-1)), Y=>temp1);
l1 : for j in 0 to 3 generate
inst2 : sbox port map(A=>temp1(8*j+7 downto 8*j), Y=>temp2(8*j+7 downto 8*j));
end generate l1;
temp3_i <= temp2 xor Rcon(32*(i/4)-1 downto 32*(i/4)-32);
selv <= std_logic_vector(to_unsigned(i mod 4, 2));
sel<= selv(0) or selv(1);

l2 : for j in 0 to 3 generate
inst3 : eight_mux port map(a=>temp0(8*j+7 downto 8*j), b=>temp3_i(8*j+7 downto 8*j), s=>sel, y=>temp4(8*j+7 downto 8*j));
end generate l2;

w_int(32*i+31 downto 32*i) <= temp4 xor w_int(32*(i-4)+31 downto 32*(i-4));
end generate expand;
w <= w_int;
end architecture;
