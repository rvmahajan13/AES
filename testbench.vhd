library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Utilities.all;
use ieee.numeric_std.all;


entity testbench is
end entity;

architecture arch of testbench is
   signal inp : std_logic_vector(127 downto 0) := (others => '0');
	signal key : std_logic_vector(127 downto 0) := (others => '0');
	signal op : std_logic_vector(127 downto 0);
   
   component cipher is
	port (
		inp: in std_logic_vector(127 downto 0);
		key: in std_logic_vector(127 downto 0);
		op: out std_logic_vector(127 downto 0)
	) ;
end component;

begin
   uut: cipher port map (inp, key, op);
   
   inp_proc : process
   begin
      inp <= std_logic_vector(unsigned(inp)+1);
		wait for 50 ns;
	end process;
		
--	reset_process : process
--	begin
--		reset<='0';
--		wait for 10000000ns;
--		reset<='1';
--		wait for 5ns;
--   end process;
end architecture;

