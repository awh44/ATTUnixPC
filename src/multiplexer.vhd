library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types.all;

entity multiplexer is
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
end multiplexer;

architecture multiplexer of multiplexer is
begin
	output <= inputs(to_integer(unsigned(sel)));
end multiplexer;
