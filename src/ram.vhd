library ieee;
use ieee.std_logic_1164.all;

entity ram is
	port
	(
		enabled: in std_logic;
		address: in integer;
		read_writen: in std_logic;
		data_in: in std_logic_vector(15 downto 0);
		data_out: out std_logic_vector(15 downto 0)
	);
end ram;

architecture ram of ram is
	type memory_array is array(0 to 32) of std_logic_vector(7 downto 0);
	signal ram_array: memory_array :=
	(
		others => x"00"
	);

	signal mem0x02: std_logic_vector(15 downto 0);
begin
	mem0x02 <= ram_array(2) & ram_array(3);

	process (enabled)
	begin
		if enabled = '1' and address <= 30
		then
			if read_writen = '1' then
				data_out <= ram_array(address) & ram_array(address + 1);
			else
				ram_array(address) <= data_in(15 downto 8);
				ram_array(address + 1) <= data_in(7 downto 0);
			end if;
		else
			data_out <= (others => 'Z');
		end if;
	end process;
end ram;
