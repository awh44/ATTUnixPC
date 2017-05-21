library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity address_decoder is
	port
	(
		enabled_n: in std_logic;
		address_in: in std_logic_vector(23 downto 1);
		address_out: out integer;
		rom_enabled: out std_logic;
		ram_enabled: out std_logic
	);
end address_decoder;

architecture address_decoder of address_decoder is
	constant ROM_BASE: integer := 16#000000#; -- will eventually be 0x800000
	constant ROM_LIMIT: integer := 30; -- will eventually be 0xBFFFFF

	constant RAM_BASE: integer := ROM_LIMIT + 2;
	constant RAM_LIMIT: integer := 62;
begin
	process (enabled_n)
		variable addr: integer;
	begin
		if enabled_n = '0' then
			addr := to_integer(unsigned(address_in & '0'));
			if addr >= ROM_BASE and addr <= ROM_LIMIT
			then
				rom_enabled <= '1';
				address_out <= addr - ROM_BASE;
			end if;

			if addr >= RAM_BASE and addr <= RAM_LIMIT
			then
				ram_enabled <= '1';
				address_out <= addr - RAM_BASE;
			end if;
		else
			rom_enabled <= '0';
			ram_enabled <= '0';
		end if;
	end process;

end address_decoder;
