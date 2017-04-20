library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
	port
	(
		enabled_n: in std_logic;
		address: in std_logic_vector(23 downto 0);
		--read_writen: in std_logic;
		data_in: in std_logic_vector(15 downto 0);
		data_out: out std_logic_vector(15 downto 0)
	);
end memory;

architecture memory of memory is
begin
	data_out <= x"FFFF";
end memory;
