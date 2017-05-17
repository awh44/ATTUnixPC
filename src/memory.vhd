library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
	port
	(
		enabled_n: in std_logic;
		address: in std_logic_vector(23 downto 1);
		read_writen: in std_logic;
		data_in: in std_logic_vector(15 downto 0);
		data_out: out std_logic_vector(15 downto 0)
	);
end memory;

architecture memory of memory is
	type memory_array is array(0 to 32) of std_logic_vector(7 downto 0);
	signal rom: memory_array :=
	(
		0 => x"00",
		1 => x"00",
		2 => x"00",
		3 => x"00",
		4 => x"00", -- Program counter highest byte
		5 => x"00", -- Program counter second byte
		6 => x"00", -- Program counter third byte
		7 => x"08", -- Program counter lowest byte
		8 => x"70", -- MOVE.L #3, D0 high byte
		9 => x"03", -- MOVE.L #3, D0 low byte
		10 => x"30", -- MOVE.W #14, A0
		11 => x"7C", -- MOVE.W #14, A0
		12 => x"00", -- MOVE.W #14, A0
		13 => x"14", -- MOVE.W #14, A0
		14 => x"30", -- MOVE.W D0, (A0) high byte
		15 => x"80", -- MOVE.W D0, (A0) low byte
		16 => x"32", -- MOVE.W (A0), D1
		17 => x"10", -- MOVE.W (A0), D1
		others => x"00"
	);

	signal mem0x14: std_logic_vector(15 downto 0);
begin
	mem0x14 <= rom(20) & rom(21);

	process (enabled_n)
		variable addr: integer;
	begin
		if enabled_n'event and enabled_n = '0' then
			addr := to_integer(unsigned(address & '0'));
			if (addr > 30) then
				addr := 30;
			end if;

			if read_writen = '1' then
				data_out <= rom(addr) & rom(addr + 1);
			else
				data_out <= (others => 'Z');
				rom(addr) <= data_in(15 downto 8) ;
				rom(addr + 1) <= data_in(7 downto 0);
			end if;
		else
			data_out <= (others => 'Z');
		end if;
	end process;

end memory;
