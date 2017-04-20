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

	component memory is
		port
		(
			enabled_n: in std_logic;
			address: in std_logic_vector(23 downto 0);
			--read_writen: out std_logic;
			data_in: in std_logic_vector(15 downto 0);
			data_out: out std_logic_vector(15 downto 0)
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

begin

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

	memory_instantiation: memory
		port map
		(
			enabled_n => ASn,
			address => ADR_OUT(23 downto 0),
			--read_writen => RWn,
			data_in => DATA_OUT,
			data_out => DATA_IN
		);

	CLK <= process_clock;
	clock_process: process(process_clock)
	begin
		process_clock <= not process_clock after 50 ns;
	end process clock_process;

  	-- Address and data:
  	--DATA_IN <= x"1111" after 0 ns;

  	-- System control:
  	BERRn <= '1' after 0 ns;
  	RESET_INn <= '0' after 0 ns, '1' after 101 ms;
  	HALT_INn <= '0' after 0 ns, '1' after 101 ms;

  	-- Interrupt control:
  	AVECn <= '1' after 0 ns;
  	IPLn <= "111" after 0 ns;

  	-- Aynchronous bus control:
  	DTACKn <= '1' after 0 ns; --, '0' after 100 us;

  	-- Synchronous peripheral control:
  	VPAn <= '0' after 0 ns;

  	-- Bus arbitration control:
  	BRn <= '0' after 0 ns, '1' after 100 ms;
  	BGACKn <= '1' after 0 ns;

  	-- Other controls:
  	K6800n <= '1' after 0 ns;


end tb_wf68k10;
