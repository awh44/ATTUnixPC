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
	constant CHAN_A: integer := 0;
	constant CHAN_B: integer := 1;

	signal last_reset_n: std_logic;
	signal internal_reset: std_logic;

	-- Register declarations ---------------------------------------------------
	type register_array is array(0 to 7) of std_logic_vector(7 downto 0);
	type chan_registers is array(0 to 1) of register_array;
	signal control_registers: chan_registers;
	signal status_registers: chan_registers;
	----------------------------------------------------------------------------


	-- Tx/Rx declarations -----------------------------------------------------
	type serial_state is
	(
		STATE_IDLE,
		STATE_START,
		STATE_DATA,
		STATE_PARITY,
		STATE_STOP
	);
	-- Double-buffered
	type tx_array is array(0 to 1) of std_logic_vector(7 downto 0);
	type chan_tx_buffers is array(0 to 1) of tx_array;
	-- Quadruple buffered
	type rx_array is array(0 to 3) of std_logic_vector(7 downto 0);
	type chan_rx_buffers is array(0 to 1) of rx_array;

	type chan_state is array(0 to 1) of serial_state;
	type chan_latch is array(0 to 1) of std_logic_vector(7 downto 0);
	type chan_transferred is array(0 to 1) of integer;

	signal tx_buffers: chan_tx_buffers;
	signal tx_state: chan_state;
	signal tx_latch_data: chan_latch;
	signal tx_transferred: chan_transferred;
	signal rx_buffers: chan_rx_buffers;
	signal rx_state: chan_state;
	signal rx_transferred: chan_transferred;
	----------------------------------------------------------------------------

	signal chan_a_tx0: std_logic_vector(7 downto 0);
begin
	chan_a_tx0 <= tx_buffers(CHAN_A)(0);

	clock_process: process (clock)
	begin
		if (last_reset_n = '1' and reset_n = '1')
		then -- If we've been reset'ing for one full cycle, do a reset
			internal_reset <= '1';
		else
			last_reset_n <= reset_n;
			internal_reset <= '0';
		end if;
	end process clock_process;

	chip_select_process: process (internal_reset, chip_select_n)
		variable reg: integer;
		variable chan: integer;
		variable value: integer;
	begin
		if (internal_reset'event and internal_reset = '1')
		then
			-- TODO: reset the registers
		elsif (chip_select_n = '0')
		then
			if (channel_b_an = '0')
			then
				chan := CHAN_A;
			else
				chan := CHAN_B;
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
					tx_latch_data(chan) <= data_in;
				elsif (read_n = '0')
				then
					data_out <= rx_buffers(chan)(3);
				end if;
			end if;
		else
			data_out <= (others => 'Z');
		end if;
	end process chip_select_process;

	tx_a_process: process (internal_reset, tx_latch_data(0), txc_a_n)
	begin
		if (internal_reset'event and internal_reset = '1')
		then
			txd_a <= '1';
			tx_transferred(CHAN_A) <= 0;
			tx_state(CHAN_A) <= STATE_IDLE;
		elsif (tx_latch_data(CHAN_A)'event)
		then
			tx_buffers(CHAN_A)(0) <= tx_latch_data(0);
		elsif (cts_a_n = '0' and txc_a_n'event and txc_a_n = '0')
		then
			if (tx_state(CHAN_A) = STATE_IDLE)
			then
				-- Pull line low for start bit, go to data state
				txd_a <= '0';
				tx_state(CHAN_A) <= STATE_DATA;
			elsif (tx_state(CHAN_A) = STATE_DATA)
			then
				txd_a <= tx_buffers(CHAN_A)(0)(0);
				tx_buffers(CHAN_A)(0)(6 downto 0) <= tx_buffers(0)(0)(7 downto 1);
				-- TODO: Check against the transfer size in the registers
				if (tx_transferred(CHAN_A) + 1 = 8)
				then
					tx_buffers(CHAN_A)(0) <= tx_buffers(CHAN_A)(1);
					tx_transferred(CHAN_A) <= 0;
					if (false)
					then
						tx_state(CHAN_A) <= STATE_PARITY;
					else
						tx_state(CHAN_A) <= STATE_STOP;
					end if;
				else
					tx_transferred(CHAN_A) <= tx_transferred(CHAN_A) + 1;
				end if;
			elsif (tx_state(CHAN_A) = STATE_PARITY)
			then
				-- TODO
				tx_state(CHAN_A) <= STATE_STOP;
			elsif (tx_state(CHAN_A) = STATE_STOP)
			then
				txd_a <= '1';
				tx_state(CHAN_A) <= STATE_IDLE;
			end if;
		end if;
	end process tx_a_process;

--	rx_a_process: process (rxc_a_n)
--	begin
--		if (dcd_a_n = '0')
--		then
--			rx_buffers(0)(0) <= rx_buffers(0)(0)(6 downto 0) & rxd_a;
--		end if;
--	end process rx_a_process;

end serial7201;
