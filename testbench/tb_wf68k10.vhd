library ieee;
use ieee.std_logic_1164.all;

entity tb_wf68k10 is
end entity;

architecture tb_wf68k10 of tb_wf68k10 is
	component wf68k10_top is
		port
		(
			CLK             : in std_logic;

			-- Address and data:
			ADR_OUT         : out std_logic_vector(31 downto 0);
			DATA_IN         : in std_logic_vector(15 downto 0);
			DATA_OUT        : out std_logic_vector(15 downto 0);
			DATA_EN         : out std_logic; -- Enables the data port.

			-- System control:
			BERRn           : in std_logic;
			RESET_INn       : in std_logic;
			RESET_OUT       : out std_logic; -- Open drain.
			HALT_INn        : in std_logic;
			HALT_OUTn       : out std_logic; -- Open drain.

			-- Processor status:
			FC_OUT          : out std_logic_vector(2 downto 0);

			-- Interrupt control:
			AVECn           : in std_logic;
			IPLn            : in std_logic_vector(2 downto 0);

			-- Aynchronous bus control:
			DTACKn          : in std_logic;
			ASn             : out std_logic;
			RWn             : out std_logic;
			RMCn            : out std_logic;
			UDSn            : out std_logic;
			LDSn            : out std_logic;
			DBENn           : out std_logic; -- Data buffer enable.
			BUS_EN          : out std_logic; -- Enables ADR, ASn, UDSn, LDSn, RWn, RMCn and FC.

			-- Synchronous peripheral control:
			E               : out std_logic;
			VMAn            : out std_logic;
			VMA_EN          : out std_logic;
			VPAn            : in std_logic;

			-- Bus arbitration control:
			BRn             : in std_logic;
			BGn             : out std_logic;
			BGACKn          : in std_logic;

			-- Other controls:
			K6800n          : in std_logic -- Assert for 68K00 compatibility.
		);
	end component;

	component address_decoder is
		port
		(
			enabled_n: in std_logic;
			address_in: in std_logic_vector(23 downto 1);
			address_out: out integer;
			rom_enabled: out std_logic;
			ram_enabled: out std_logic;
			romlmap_enabled: out std_logic;
			serial_enabled_n: out std_logic
		);
	end component;

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

	component rom is
		port
		(
			enabled: in std_logic;
			address: in integer;
			data_out: out std_logic_vector(15 downto 0)
		);
	end component;

	component romlmap is
		port
		(
			reset_n: in std_logic;
			inval: in std_logic_vector(15 downto 0);
			enabled: in std_logic;
			romlmap_n: out std_logic
		);
	end component;

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

	signal CLK             : std_logic;

	-- Address and data:
	signal ADR_OUT         : std_logic_vector(31 downto 0);
	signal DATA_IN         : std_logic_vector(15 downto 0);
	signal DATA_OUT        : std_logic_vector(15 downto 0);
	signal DATA_EN         : std_logic; -- Enables the data port.

	-- System control:
	signal BERRn           : std_logic;
	signal RESET_INn       : std_logic;
	signal RESET_OUT       : std_logic; -- Open drain.
	signal HALT_INn        : std_logic;
	signal HALT_OUTn       : std_logic; -- Open drain.

	-- Processor status:
	signal FC_OUT          : std_logic_vector(2 downto 0);

	-- Interrupt control:
	signal AVECn           : std_logic;
	signal IPLn            : std_logic_vector(2 downto 0);

	-- Aynchronous bus control:
	signal DTACKn          : std_logic;
	signal ASn             : std_logic;
	signal RWn             : std_logic;
	signal RMCn            : std_logic;
	signal UDSn            : std_logic;
	signal LDSn            : std_logic;
	signal DBENn           : std_logic; -- Data buffer enable.
	signal BUS_EN          : std_logic; -- Enables ADR, ASn, UDSn, LDSn, RWn, RMCn and FC.

	-- Synchronous peripheral control:
	signal E               : std_logic;
	signal VMAn            : std_logic;
	signal VMA_EN          : std_logic;
	signal VPAn            : std_logic;

	-- Bus arbitration control:
	signal BRn             : std_logic;
	signal BGn             : std_logic;
	signal BGACKn          : std_logic;

	-- Other controls:
	signal K6800n          : std_logic; -- Assert for 68K00 compatibility.

	signal process_clock: std_logic := '0';

	signal ad_address_in: std_logic_vector(23 downto 1);
	signal ad_address_out: integer;
	signal ad_rom_enabled: std_logic;
	signal ad_ram_enabled: std_logic;
	signal ad_romlmap_enabled: std_logic;

	signal romlmap_romlmap_n: std_logic;

	signal s7201_clock: std_logic := '0';
	signal s7201_dcd_n: std_logic_vector(1 downto 0);
	signal s7201_rxc_n: std_logic_vector(1 downto 0);
	signal s7201_txc_n: std_logic_vector(1 downto 0);
	signal s7201_txd: std_logic_vector(1 downto 0);
	signal s7201_rxd: std_logic_vector(1 downto 0);
	signal s7201_cts_n: std_logic_vector(1 downto 0);
	signal s7201_rts_n: std_logic_vector(1 downto 0);
	signal s7201_sync_n: std_logic_vector(1 downto 0);
	signal s7201_data: std_logic_vector(7 downto 0);
	signal s7201_read_n: std_logic;
	signal s7201_chip_select_n: std_logic;
	signal s7201_dtr_n: std_logic_vector(1 downto 0);
	signal s7201_int_ack_n: std_logic;
	signal s7201_int_n: std_logic;

	signal low0: std_logic;
begin

	low0 <= '0';

	wf68k10_instantiation: wf68k10_top
		port map
		(
			CLK => CLK,

			-- Address and data:
			ADR_OUT => ADR_OUT,
			DATA_IN => DATA_IN,
			DATA_OUT => DATA_OUT,
			DATA_EN => DATA_EN,

			-- System control:
			BERRn => BERRn,
			RESET_INn => RESET_INn,
			RESET_OUT => RESET_OUT,
			HALT_INn => HALT_INn,
			HALT_OUTn => HALT_OUTn,

			-- Processor status:
			FC_OUT => FC_OUT,

			-- Interrupt control:
			AVECn => AVECn,
			IPLn => IPLN,

			-- Aynchronous bus control:
			DTACKn => DTACKn,
			ASn => ASn,
			RWn => RWn,
			RMCn => RMCn,
			UDSn => UDSn,
			LDSn => LDSn,
			DBENn => DBENn,
			BUS_EN => BUS_EN,

			-- Synchronous peripheral control:
			E => E,
			VMAn => VMAn,
			VMA_EN => VMA_EN,
			VPAn => VPAn,

			-- Bus arbitration control:
			BRn => BRn,
			BGn => BGn,
			BGACKn => BGACKn,

			-- Other controls:
			K6800n => K6800n

		);

	address_decoder_instantiation: address_decoder
		port map
		(
			enabled_n => ASn,
			address_in => ad_address_in,
			address_out => ad_address_out,
			rom_enabled => ad_rom_enabled,
			ram_enabled => ad_ram_enabled,
			romlmap_enabled => ad_romlmap_enabled,
			serial_enabled_n => s7201_chip_select_n
		);

	ram_instantiation: ram
		port map
		(
			enabled => ad_ram_enabled,
			address => ad_address_out,
			read_writen => RWn,
			data_in => DATA_OUT,
			data_out => DATA_IN
		);

	rom_instantiation: rom
		port map
		(
			enabled => ad_rom_enabled,
			address => ad_address_out,
			data_out => DATA_IN
		);

	romlmap_instantiation: romlmap
		port map
		(
			reset_n => RESET_INn,
			inval => DATA_OUT,
			enabled => ad_romlmap_enabled,
			romlmap_n => romlmap_romlmap_n
		);

	serial7201_instantiation: serial7201
		port map
		(
			clock => s7201_clock,
			reset_n => RESET_INn,
			dcd_a_n => s7201_dcd_n(0),
			rxc_b_n => s7201_rxc_n(1),
			dcd_b_n => s7201_dcd_n(1),
			cts_b_n => s7201_cts_n(1),
			txc_b_n => s7201_txc_n(1),
			txd_b => s7201_txd(1),
			rxd_b => s7201_rxd(1),
			syn_b_n => s7201_sync_n(1),
			data_in => DATA_OUT(7 downto 0),
			data_out => DATA_IN(7 downto 0),
			write_n => RWn,
			read_n => s7201_read_n,
			chip_select_n => s7201_chip_select_n,
			control_datan => ADR_OUT(2),
			channel_b_an => ADR_OUT(1),
			dtr_b_n => s7201_dtr_n(1),
			int_ack_n => s7201_int_ack_n,
			int_n => s7201_int_n,
			dtr_a_n => s7201_dtr_n(0),
			syn_a_n => s7201_sync_n(0),
			rxd_a => s7201_rxd(0),
			rxc_a_n => s7201_rxc_n(0),
			txc_a_n => s7201_txc_n(0),
			txd_a => s7201_txd(0),
			rts_a_n => s7201_rts_n(0),
			cts_a_n => s7201_cts_n(0)
		);
	-- 2.45 MHz clock?
	s7201_clock_process: process(s7201_clock)
	begin
		s7201_clock <= not s7201_clock after 408 ns;
	end process s7201_clock_process;
	s7201_read_n <= not RWn;

	ad_address_in <=
		(ADR_OUT(23) or (not romlmap_romlmap_n)) & (ADR_OUT(22 downto 1));


	CLK <= process_clock;
	clock_process: process(process_clock)
	begin
		process_clock <= not process_clock after 50 ns;
	end process clock_process;

  	-- System control:
  	BERRn <= '1' after 0 ns;
  	RESET_INn <= '0' after 0 ns, '1' after 10 us;
  	HALT_INn <= '0' after 0 ns, '1' after 10 us;

  	-- Interrupt control:
  	AVECn <= '1' after 0 ns;
  	IPLn <= "111" after 0 ns;

  	-- Aynchronous bus control:
  	DTACKn <= '1' after 0 ns;

  	-- Synchronous peripheral control:
  	VPAn <= '0' after 0 ns;

  	-- Bus arbitration control:
  	BRn <= '1' after 0 ns;
  	BGACKn <= '1' after 0 ns;

  	-- Other controls:
  	K6800n <= '1' after 0 ns;


end tb_wf68k10;
