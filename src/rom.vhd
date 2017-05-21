library ieee;
use ieee.std_logic_1164.all;

entity rom is
	port
	(
		enabled: in std_logic;
		address: in integer;
		data_out: out std_logic_vector(15 downto 0)
	);
end rom;

architecture rom of rom is
	type memory_array is array(0 to 32) of std_logic_vector(7 downto 0);
	signal rom_array: memory_array :=
	(
		0 => x"00",
		1 => x"00",
		2 => x"00",
		3 => x"00",
		4 => x"00", -- Program counter highest byte
		5 => x"00", -- Program counter second byte
		6 => x"00", -- Program counter third byte
		7 => x"08", -- Program counter lowest byte
		8 => x"33", -- MOVE.W #$8000, $E43000 highest byte
		9 => x"FC", -- MOVE.W #$8000, $E43000 second byte
		10 => x"80", -- MOVE.W #$8000, $E43000 third byte
		11 => x"00", -- MOVE.W #$8000, $E43000 fourth byte
		12 => x"00", -- MOVE.W #$8000, $E43000 fifth byte
		13 => x"E4", -- MOVE.W #$8000, $E43000 sixth byte
		14 => x"30", -- MOVE.W #$8000, $E43000 seventh byte
		15 => x"00", -- MOVE.W #$8000, $E43000 lowest byte
--		8 => x"70", -- MOVE.L #3, D0 high byte
--		9 => x"03", -- MOVE.L #3, D0 low byte
--		10 => x"30", -- MOVE.W #$20, A0
--		11 => x"7C", -- MOVE.W #$20, A0
--		12 => x"00", -- MOVE.W #$20, A0
--		13 => x"20", -- MOVE.W #$20, A0
--		14 => x"30", -- MOVE.W D0, (A0) high byte
--		15 => x"80", -- MOVE.W D0, (A0) low byte
--		16 => x"32", -- MOVE.W (A0), D1
--		17 => x"10", -- MOVE.W (A0), D1
		others => x"00"
	);
begin
	process (enabled)
	begin
		if enabled = '1' and address <= 30
		then
			data_out <= rom_array(address) & rom_array(address + 1);
		else
			data_out <= (others => 'Z');
		end if;
	end process;
end rom;
