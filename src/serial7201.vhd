library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- References:
-- 	UNIXPC_Ref.pdf, page 275
-- 	UPD7201A-NEC.pdf, page 1

entity serial7201 is
	port
	(
		-- 1 - clock
		clock: in std_logic;
		-- 2 - reset
		reset_n: in std_logic;
		-- 3 - data carrier detect input for channel A
		dcd_a_n: in std_logic;
		-- 4 - receiver clock input for channel B
		rxc_b_n: in std_logic;
		-- 5 - data carrier detect input for channel B
		dcd_b_n: in std_logic;
		-- 6 - clear to send for channel B
		cts_b_n: in std_logic;
		-- 7 - transmitter clock for channel B
		txc_b_n: in std_logic;
		-- 8 - transmit data output for channel B
		txd_b: out std_logic;
		-- 9 - receie data input for channel B
		rxd_b: in std_logic;
		-- 10 - request to send/synchronization output for channel B
		syn_b_n: out std_logic;
		-- 11 - wait output for channel B; don't need
		-- 12-19 - data bus
		data_in: in std_logic_vector(7 downto 0);
		data_out: out std_logic_vector(7 downto 0);
		-- 20 - ground
		-- 21 - write strobe input
		write_n: in std_logic;
		-- 22 - read strobe input
		read_n: in std_logic;
		-- 23 - chip select input
		chip_select_n: in std_logic;
		-- 24 - control/data input
		control_datan: in std_logic;
		-- 25 - channel select input
		channel_b_an: in std_logic;
		-- 26 - data terminal output for channel B
		dtr_b_n: out std_logic;
		-- 27 - interrupt acknowledge
		int_ack_n: in std_logic;
		-- 28 - interrupt request
		int_n: out std_logic;
		-- 29 - interrupt priority input - just grounded, don't need
		--priority_in_n: in std_logic;
		-- 30 - interrupt priority output - don't need
		-- 31 - data terminal output for channel A
		dtr_a_n: out std_logic;
		-- 32 - wait output for channel A - don't need
		-- 33 - synchronization in/out for channel A
		syn_a_n: inout std_logic;
		-- 34 - receive data input for channel A
		rxd_a: in std_logic;
		-- 35 - receiver clock input for channel A
		rxc_a_n: in std_logic;
		-- 36 - transmitter clock input for channel A
		txc_a_n: in std_logic;
		-- 37 - transmit data output for channel A
		txd_a: out std_logic;
		-- 38 - request to send for channel A
		rts_a_n: out std_logic;
		-- 39 - clear to send input for channel A
		cts_a_n: in std_logic
	);
end serial7201;

architecture serial7201 of serial7201 is
	signal last_reset_n: std_logic;

	type register_array is array(0 to 7) of std_logic_vector(7 downto 0);
	type chan_registers is array(0 to 1) of register_array;
	signal control_registers: chan_registers;
	signal status_registers: chan_registers;

	-- Double-buffered
	type tx_array is array(0 to 1) of std_logic_vector(7 downto 0);
	type chan_tx_buffers is array(0 to 1) of tx_array;
	-- Quadruple buffered
	type rx_array is array(0 to 3) of std_logic_vector(7 downto 0);
	type chan_rx_buffers is array(0 to 1) of rx_array;

	signal tx_buffers: chan_tx_buffers;
	signal rx_buffers: chan_rx_buffers;
begin
	clock_process: process (clock)
	begin
		if (last_reset_n = '1' and reset_n = '1')
		then -- If we've been reset'ing for one full cycle, do a reset
			txd_a <= '1';
			txd_b <= '1';
			int_n <= '1';
			control_registers(0)(0)(0) <= '0';
			control_registers(0)(0)(1) <= '0';
			control_registers(0)(0)(2) <= '0';
			control_registers(1)(0)(0) <= '0';
			control_registers(1)(0)(1) <= '0';
			control_registers(1)(0)(2) <= '0';
		else
			last_reset_n <= reset_n;
		end if;
	end process clock_process;

	chip_select_process: process (chip_select_n)
		variable reg: integer;
		variable chan: integer;
		variable value: integer;
	begin
		if (chip_select_n = '0')
		then
			if (channel_b_an = '0')
			then
				chan := 0;
			else
				chan := 1;
			end if;

			if (control_datan = '1')
			then
				reg := to_integer(unsigned(control_registers(chan)(0)(2 downto 0)));
				if (write_n = '0')
				then
					control_registers(chan)(reg) <= data_in;
				elsif (read_n = '0')
				then
					data_out <= status_registers(chan)(reg);
				end if;
			else
				if (write_n = '0')
				then
					tx_buffers(chan)(1) <= data_in;
				elsif (read_n = '0')
				then
					data_out <= rx_buffers(chan)(3);
				end if;
			end if;
		else
			data_out <= (others => 'Z');
		end if;
	end process chip_select_process;

	rx_a_process: process (rxc_a_n)
	begin

	end process rx_a_process;

end serial7201;
