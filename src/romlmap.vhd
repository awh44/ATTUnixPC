library ieee;
use ieee.std_logic_1164.all;

entity romlmap is
	port
	(
		reset_n: in std_logic;
		inval: in std_logic_vector(15 downto 0);
		enabled: in std_logic;
		romlmap_n: out std_logic
	);
end romlmap;

architecture romlmap of romlmap is
	signal romlmap_n_internal: std_logic;
begin
	process (reset_n, enabled)
	begin
		-- If processor has been reset, this signal will be asserted, and we
		-- need to drive the address line high again
		if reset_n'event and reset_n = '0'
		then
			romlmap_n <= '0';
		elsif enabled'event and enabled = '1'
		then
			-- If data value 0x8000 is written to us, then we need to deassert
			-- the address line
			if inval = x"8000" then
				romlmap_n <= '1';
			end if;
		end if;
	end process;
end romlmap;
