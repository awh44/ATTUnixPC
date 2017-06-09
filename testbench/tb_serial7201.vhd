library ieee;
use ieee.std_logic_1164.all;

entity tb_serial7201 is
end entity;

architecture tb_serial7201 of tb_serial7201 is
	component serial7201 is
		port
		(
			clock: in std_logic;
			reset_n: in std_logic;
			dcd_a_n: in std_logic;
			rxc_b_n: in std_logic;
			dcd_b_n: in std_logic;
			cts_b_n: in std_logic;
			txc_b_n: in std_logic;
			txd_b: out std_logic;
			rxd_b: in std_logic;
			syn_b_n: out std_logic;
			data_in: in std_logic_vector(7 downto 0);
			data_out: out std_logic_vector(7 downto 0);
			write_n: in std_logic;
			read_n: in std_logic;
			chip_select_n: in std_logic;
			control_datan: in std_logic;
			channel_b_an: in std_logic;
			dtr_b_n: out std_logic;
			int_ack_n: in std_logic;
			int_n: out std_logic;
			dtr_a_n: out std_logic;
			syn_a_n: inout std_logic;
			rxd_a: in std_logic;
			rxc_a_n: in std_logic;
			txc_a_n: in std_logic;
			txd_a: out std_logic;
			rts_a_n: out std_logic;
			cts_a_n: in std_logic
		);
	end component;

	signal clock: std_logic := '0';
	signal dclock: std_logic := '0';

	signal reset1: std_logic := '0';
	signal dcd1: std_logic_vector(1 downto 0);
	signal txd1: std_logic_vector(1 downto 0);
	signal rts1: std_logic_vector(1 downto 0);
	signal cts1: std_logic_vector(1 downto 0);
	signal syn1: std_logic_vector(1 downto 0);
	signal data_in1: std_logic_vector(7 downto 0);
	signal data_out1: std_logic_vector(7 downto 0);
	signal read1: std_logic;
	signal write1: std_logic;
	signal cs1: std_logic;
	signal cd1: std_logic;
	signal chan1: std_logic;
	signal dtr1: std_logic_vector(1 downto 0);
	signal int_ack1: std_logic;
	signal int1: std_logic;

	signal reset2: std_logic := '0';
	signal dcd2: std_logic_vector(1 downto 0);
	signal txd2: std_logic_vector(1 downto 0);
	signal rts2: std_logic_vector(1 downto 0);
	signal cts2: std_logic_vector(1 downto 0);
	signal syn2: std_logic_vector(1 downto 0);
	signal data_in2: std_logic_vector(7 downto 0);
	signal data_out2: std_logic_vector(7 downto 0);
	signal read2: std_logic;
	signal write2: std_logic;
	signal cs2: std_logic;
	signal cd2: std_logic;
	signal chan2: std_logic;
	signal dtr2: std_logic_vector(1 downto 0);
	signal int_ack2: std_logic;
	signal int2: std_logic;
begin

	serial1: serial7201
		port map
		(
			clock => clock,
			reset_n => reset1,
			dcd_a_n => dcd1(0),
			rxc_b_n => dclock,
			dcd_b_n => dcd1(1),
			cts_b_n => cts1(1),
			txc_b_n => dclock,
			txd_b => txd1(1),
			rxd_b => txd2(1),
			syn_b_n => syn1(1),
			data_in => data_in1,
			data_out => data_out1,
			write_n => write1,
			read_n => read1,
			chip_select_n => cs1,
			control_datan => cd1,
			channel_b_an => chan1,
			dtr_b_n => dtr1(1),
			int_ack_n => int_ack1,
			int_n => int1,
			dtr_a_n => dtr1(0),
			syn_a_n => syn1(0),
			rxd_a => txd2(0),
			rxc_a_n => dclock,
			txc_a_n => dclock,
			txd_a => txd1(0),
			rts_a_n => rts1(0),
			cts_a_n => cts1(0)
		);

	serial2: serial7201
		port map
		(
			clock => clock,
			reset_n => reset2,
			dcd_a_n => dcd2(0),
			rxc_b_n => dclock,
			dcd_b_n => dcd2(1),
			cts_b_n => cts2(1),
			txc_b_n => dclock,
			txd_b => txd2(1),
			rxd_b => txd1(1),
			syn_b_n => syn2(1),
			data_in => data_in2,
			data_out => data_out2,
			write_n => write2,
			read_n => read2,
			chip_select_n => cs2,
			control_datan => cd2,
			channel_b_an => chan2,
			dtr_b_n => dtr2(1),
			int_ack_n => int_ack2,
			int_n => int2,
			dtr_a_n => dtr2(0),
			syn_a_n => syn2(0),
			rxd_a => txd1(0),
			rxc_a_n => dclock,
			txc_a_n => dclock,
			txd_a => txd2(0),
			rts_a_n => rts2(0),
			cts_a_n => cts2(0)
		);

	-- 2.45 MHz clock?
	process(clock)
	begin
		clock <= not clock after 408 ns;
	end process;

	-- ~115,200 baud?
	process (dclock)
	begin
		dclock <= not dclock after 8 us;
	end process;

	reset1 <= '1' after 1 us;
	reset2 <= '1' after 1 us;

	cd1 <= '0' after 2 us;
	chan1 <= '0' after 2 us;
	write1 <= '0' after 2 us;
	data_in1 <= "01010101" after 2 ns;
	cs1 <= '0' after 3 us;

	cts1(0) <= '0' after 4 us, '1' after 168 us;

end tb_serial7201;
