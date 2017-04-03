library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types.all;

entity tb_multiplexer is
end entity;

architecture tb_multiplexer of tb_multiplexer is
	component multiplexer is
		generic
		(
			sel_width: positive;
			bus_width: positive
		);

		port
		(
			sel: in std_logic_vector(sel_width - 1 downto 0);
			inputs: in bus_array(0 to 2 ** sel_width - 1); --(bus_width - 1 downto 0);
			output: out std_logic_vector(bus_width - 1 downto 0)
		);

	end component;

	signal s: std_logic_vector(1 downto 0);
	signal i: bus_array(0 to 3);
	signal o: std_logic_vector(0 downto 0);
begin

	multiplexer_instantiation: multiplexer
		generic map
		(
			sel_width => 2,
			bus_width => 1
		)

		port map
		(
			sel => s,
			inputs => i,
			output => o
		);

	s <= "00" after 0 ns, "01" after 10 ns, "10" after 20 ns, "11" after 30 ns, "00" after 40 ns;
	i(0) <= "0" after 0 ns, "1" after 5 ns;
	i(1) <= "0" after 0 ns, "1" after 15 ns;
	i(2) <= "0" after 0 ns, "1" after 25 ns;
	i(3) <= "0" after 0 ns, "1" after 35 ns;
end tb_multiplexer;
