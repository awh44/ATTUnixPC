library ieee;
use ieee.std_logic_1164;

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
		dcc_b_n: in std_logic;
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
		-- 29 - interrupt priority input
		priority_in_n: in std_logic;
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
begin

end serial7201;
