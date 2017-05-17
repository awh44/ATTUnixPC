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
	constant ROM_BASE: integer := 16#000000#; -- will eventually be 0x800000
	constant ROM_LIMIT: integer := 30; -- will eventually be 0xBFFFFF
	component rom is
		port
		(
			enabled: in std_logic;
			address: in integer;
			data_out: out std_logic_vector(15 downto 0)
		);
	end component;
	signal rom_enabled: std_logic;
	signal rom_address: integer;

	constant RAM_BASE: integer := ROM_LIMIT + 2;
	constant RAM_LIMIT: integer := 62;
	component ram is
		port
		(
			enabled: in std_logic;
			address: in integer;
			read_writen: in std_logic;
			data_in: in std_logic_vector(15 downto 0);
			data_out: out std_logic_vector(15 downto 0)
		);
	end component;
	signal ram_enabled: std_logic;
	signal ram_address: integer;
begin
	rom_instantiation: rom
		port map
		(
			enabled => rom_enabled,
			address => rom_address,
			data_out => data_out
		);

	ram_instantiation: ram
		port map
		(
			enabled => ram_enabled,
			address => ram_address,
			read_writen => read_writen,
			data_in => data_in,
			data_out => data_out
		);

	process (enabled_n)
		variable addr: integer;
	begin
		if enabled_n = '0' then
			addr := to_integer(unsigned(address & '0'));
			if addr >= ROM_BASE and addr <= ROM_LIMIT
			then
				rom_enabled <= '1';
				rom_address <= addr - ROM_BASE;
			end if;

			if addr >= RAM_BASE and addr <= RAM_LIMIT
			then
				ram_enabled <= '1';
				ram_address <= addr - RAM_BASE;
			end if;
		else
			rom_enabled <= '0';
			ram_enabled <= '0';
			data_out <= (others => 'Z');
		end if;
	end process;

end memory;
