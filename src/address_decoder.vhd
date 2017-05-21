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
		ram_enabled: out std_logic;
		romlmap_enabled: out std_logic
	);
end address_decoder;

architecture address_decoder of address_decoder is
	constant RAM_BASE: integer := 0;
	constant RAM_LIMIT: integer := RAM_BASE + 30;

	constant ROM_BASE: integer := 16#800000#;
	constant ROM_LIMIT: integer := ROM_BASE + 30; -- will eventually be 0xBFFFFF

	constant ROMLMAP_BASE: integer := 16#E43000#;
	constant ROMLMAP_LIMIT: integer := 16#E43000#;
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
			elsif addr >= RAM_BASE and addr <= RAM_LIMIT
			then
				ram_enabled <= '1';
				address_out <= addr - RAM_BASE;
			elsif addr >= ROMLMAP_BASE and addr <= ROMLMAP_LIMIT
			then
				romlmap_enabled <= '1';
				address_out <= addr - ROMLMAP_BASE;
			end if;
		else
			rom_enabled <= '0';
			ram_enabled <= '0';
			romlmap_enabled <= '0';
		end if;
	end process;

end address_decoder;
