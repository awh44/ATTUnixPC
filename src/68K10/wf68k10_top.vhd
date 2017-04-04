------------------------------------------------------------------------
----                                                                ----
---- This is the top level structural design unit of the 68K10      ----
---- complex instruction set (CISC) microcontroller. It's program-  ----
---- ming model is (hopefully) fully compatible with Motorola's     ----
---- MC68010. This core features a pipelined architecture. In com-  ----
---- parision to the 68K10 the core supports a 32 bit wide adress   ----
---- bus. The processor generates the stack frame format 0, 2, A, B ----
---- according to the 68K30 CPU. There is also support for multi-   ----
---- processor environments due to the RMCn signal. In conjunction  ----
---- with the 32 bit wide address bus this core is fully feature    ----
---- complete in comparision to the MC68012 processors.             ----
----                                                                ----
---- Compatibility to the 68K00:                                    ----
---- The 68K10 is pin compatible with the 68K00 but it is not 100%  ----
---- software compatible due to differences in the programming      ----
---- model. The differences in detail are:                          ----
---- 1. The following differences are implemented in this core but  ----
----    do not affect the 68K00 compatibility:                      ----
----     The 68K00 does not feature A vector base register (VBR).   ----
----     The 68K00 does not feature the BKPT instruction.           ----
----     The 68K00 does not feature the MOVE_FROM_CCR instruction.  ----
----     The 68K00 does not feature the MOVEC instruction.          ----
----     The 68K00 does not feature the MOVES instruction.          ----
----     The 68K00 does not feature the RTD instruction.            ----
----     The 68K10 stack frames are more complex but backward       ----
----     compatible to the 68K00.                                   ----
---- 2. The following differences are implemented in this core and  ----
----    do affect the 68K00 compatibility:                          ----
----     The MOVE_FROM_SR instruction is priviledged for the 68K10  ----
----     but is not priviledged for the 68K00. To gain compati-     ----
----     bility the K6800n signal driven low deactivates the pri-   ----
----     viledged mechanism for this instruction.                   ----
----     This core features the loop operation mode of the 68010.   ----
----                                                                ----
---- Enjoy.                                                         ----
----                                                                ----
---- Author(s):                                                     ----
---- - Wolfgang Foerster, wf@experiment-s.de; wf@inventronik.de     ----
----                                                                ----
------------------------------------------------------------------------
----                                                                ----
---- Copyright © 2014 Wolfgang Foerster Inventronik GmbH.           ----
----                                                                ----
---- This documentation describes Open Hardware and is licensed     ----
---- under the CERN OHL v. 1.2. You may redistribute and modify     ----
---- this documentation under the terms of the CERN OHL v.1.2.      ----
---- (http://ohwr.org/cernohl). This documentation is distributed   ----
---- WITHOUT ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING OF          ----
---- MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A        ----
---- PARTICULAR PURPOSE. Please see the CERN OHL v.1.2 for          ----
---- applicable conditions                                          ----
----                                                                ----
------------------------------------------------------------------------
-- 
-- Revision History
-- 
-- Revision 2K14B 20141201 WF
--   Initial Release.
-- Revision 2K16A 20160620 WF
--   Control section: fixed a bug in the MOVEM operation. Thanks to Raymond Mounissamy.
--   Address section: minor optimizations.
--   Address section: fixed a bug in PC_LOAD.
--   Top level: fixed the AR_IN_1 multiplexer.
--   Control: Break the DBcc_LOOP when the exception handler is busy (see process P_LOOP).
--   Opcode decoder: Break the DBcc_LOOP when the exception handler is busy (see process P_LOOP).
--

library work;
use work.WF68K10_PKG.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity WF68K10_TOP is
    generic(VERSION     : std_logic_vector(15 downto 0) := x"1501"); -- CPU version number.
    port (
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
end entity WF68K10_TOP;
    
architecture STRUCTURE of WF68K10_TOP is
signal ADn                      : bit;
signal ADR_ATN                  : bit;
signal ADR_CPY_EXH              : std_logic_vector(31 downto 0);
signal ADR_EFF                  : std_logic_vector(31 downto 0);
signal ADR_EFF_WB               : std_logic_vector(31 downto 0);
signal ADR_L                    : std_logic_vector(31 downto 0);
signal ADR_LATCH                : std_logic_vector(31 downto 0);
signal ADR_MODE                 : std_logic_vector(2 downto 0);
signal ADR_MODE_MAIN            : std_logic_vector(2 downto 0);
signal ADR_IN_USE               : bit;
signal ADR_OFFSET               : std_logic_vector(7 downto 0);
signal ADR_OFFSET_EXH           : std_logic_vector(7 downto 0);
signal ADR_OFFSET_MAIN          : std_logic_vector(5 downto 0);
signal ADR_P                    : std_logic_vector(31 downto 0);
signal ADR_MARK_UNUSED          : bit;
signal ADR_MARK_UNUSED_MAIN     : bit;
signal ADR_MARK_USED            : bit;
signal AERR                     : bit;
signal ALU_ACK                  : bit;
signal ALU_BSY                  : bit;
signal ALU_COND                 : boolean;
signal ALU_INIT                 : bit;
signal ALU_LOAD_OP1             : bit;
signal ALU_LOAD_OP2             : bit;
signal ALU_LOAD_OP3             : bit;
signal ALU_OP1_IN               : std_logic_vector(31 downto 0);
signal ALU_OP2_IN               : std_logic_vector(31 downto 0);
signal ALU_OP3_IN               : std_logic_vector(31 downto 0);
signal ALU_REQ                  : bit;
signal ALU_RESULT               : std_logic_vector(63 downto 0);
signal AMODE_SEL                : std_logic_vector(2 downto 0);
signal AR_DEC_EXH               : bit;
signal AR_DEC                   : bit;
signal AR_DEC_MAIN              : bit;
signal AR_IN_1                  : std_logic_vector(31 downto 0);
signal AR_IN_2                  : std_logic_vector(31 downto 0);
signal AR_IN_USE                : bit;
signal AR_INC                   : bit;
signal AR_MARK_USED             : bit;
signal AR_OUT_1                 : std_logic_vector(31 downto 0);
signal AR_OUT_2                 : std_logic_vector(31 downto 0);
signal AR_SEL_RD_1              : std_logic_vector(3 downto 0);
signal AR_SEL_RD_1_MAIN         : std_logic_vector(3 downto 0);
signal AR_SEL_RD_2              : std_logic_vector(3 downto 0);
signal AR_SEL_WR_1              : std_logic_vector(2 downto 0);
signal AR_SEL_WR_2              : std_logic_vector(2 downto 0);
signal AR_WR_1                  : bit;
signal AR_WR_2                  : bit;
signal AVECn_BUSIF              : std_logic;
signal BERR_MAIN                : bit;
signal BERR_WR                  : bit;
signal BITPOS                   : std_logic_vector(4 downto 0);
signal BIW_0                    : std_logic_vector(15 downto 0);
signal BIW_1                    : std_logic_vector(15 downto 0);
signal BIW_2                    : std_logic_vector(15 downto 0);
signal BKPT_CYCLE               : bit;
signal BKPT_INSERT              : bit;
signal BUS_BSY                  : bit;
signal BUSY_EXH                 : bit;
signal BUSY_MAIN                : bit;
signal BUSY_OPD                 : bit;
signal CC_UPDT                  : bit;
signal CPU_SPACE                : bit;
signal CPU_SPACE_EXH            : bit;
signal DFC                      : std_logic_vector(2 downto 0);
signal DFC_RD                   : bit;
signal DFC_WR                   : bit;
signal DR_WR_1                  : bit;
signal DR_WR_2                  : bit;
signal DR_MARK_USED             : bit;
signal DATA_FROM_CORE           : std_logic_vector(31 downto 0);
signal DATA                     : std_logic_vector(31 downto 0);
signal DATA_IN_EXH              : std_logic_vector(31 downto 0);
signal DATA_IMMEDIATE           : std_logic_vector(31 downto 0);
signal DATA_EXH                 : std_logic_vector(31 downto 0);
signal DATA_RD                  : bit;
signal DATA_WR                  : bit;
signal DATA_RD_EXH              : bit;
signal DATA_WR_EXH              : bit;
signal DATA_RD_MAIN             : bit;
signal DATA_WR_MAIN             : bit;
signal DATA_RDY                 : bit;
signal DATA_TO_CORE             : std_logic_vector(31 downto 0);
signal DATA_RERUN_EXH           : bit;
signal DATA_VALID               : std_logic;
signal DISPLACEMENT             : std_logic_vector(31 downto 0);
signal DISPLACEMENT_MAIN        : std_logic_vector(31 downto 0);
signal DISPLACEMENT_EXH         : std_logic_vector(7 downto 0);
signal DATA_BUFFER              : std_logic_vector(31 downto 0);
signal DBcc_COND                : boolean;
signal DR_IN_1                  : std_logic_vector(31 downto 0);
signal DR_IN_2                  : std_logic_vector(31 downto 0);
signal DR_OUT_2                 : std_logic_vector(31 downto 0);
signal DR_OUT_1                 : std_logic_vector(31 downto 0);
signal DR_SEL_WR_1              : std_logic_vector(2 downto 0);
signal DR_SEL_WR_2              : std_logic_vector(2 downto 0);
signal DR_SEL_RD_1              : std_logic_vector(3 downto 0);
signal DR_SEL_RD_2              : std_logic_vector(3 downto 0);
signal DR_IN_USE                : bit;
signal EW_ACK                   : bit;
signal EX_TRACE                 : bit;
signal EXEC_RDY                 : bit;
signal EXT_WORD                 : std_logic_vector(15 downto 0);
signal EW_REQ_MAIN              : bit;
signal FB                       : std_logic;
signal FC                       : std_logic;
signal FC_I                     : std_logic_vector(2 downto 0);
signal FC_LATCH                 : std_logic_vector(2 downto 0);
signal FC_OUT_EXH               : std_logic_vector(2 downto 0);
signal FC_OUT_I                 : std_logic_vector(2 downto 0);
signal IBUFFER                  : std_logic_vector(31 downto 0);
signal INBUFFER                 : std_logic_vector(31 downto 0);
signal IPL                      : std_logic_vector(2 downto 0);
signal ISP_LOAD                 : bit;
signal INT_VECT                 : std_logic_vector(31 downto 0);
signal IVECT_OFFS               : std_logic_vector(9 downto 0);
signal IPEND_In                 : bit;
signal IRQ_PEND                 : std_logic_vector(2 downto 0);
signal IPIPE_FLUSH              : bit;
signal IPIPE_FLUSH_EXH          : bit;
signal IPIPE_FLUSH_MAIN         : bit;
signal IPIPE_OFFESET            : std_logic_vector(2 downto 0);
signal LOOP_BSY                 : bit;
signal LOOP_EXIT                : bit;
signal LOOP_EXIT_EXH            : bit;
signal LOOP_EXIT_MAIN           : bit;
signal MOVEP_PNTR               : integer range 0 to 4;
signal OPCODE_RD                : bit;
signal OPCODE_RDY               : bit;
signal OPCODE_VALID             : std_logic;
signal OPCODE_TO_CORE           : std_logic_vector(15 downto 0);
signal OPCODE_DATA_OPD          : std_logic_vector(15 downto 0);
signal OP_SIZE                  : OP_SIZETYPE;
signal OP_SIZE_BUS              : OP_SIZETYPE;
signal OP_SIZE_EXH              : OP_SIZETYPE;
signal OP_SIZE_MAIN             : OP_SIZETYPE;
signal OP_SIZE_WB               : OP_SIZETYPE; -- Writeback.
signal OPCODE_REQ               : bit;
signal OPCODE_REQ_I             : bit;
signal OW_VALID                 : std_logic;
signal OPD_ACK_MAIN             : bit;
signal OP                       : OP_68K;
signal OW_REQ_MAIN              : bit;
signal OUTBUFFER                : std_logic_vector(31 downto 0);
signal PC                       : std_logic_vector(31 downto 0);
signal PC_ADD_DISPL             : bit;
signal PC_ADR_OFFSET            : std_logic_vector(7 downto 0);
signal PC_EW_OFFSET             : std_logic_vector(2 downto 0);
signal PC_INC                   : bit;
signal PC_INC_EXH               : bit;
signal PC_INC_OPCODE            : bit;
signal PC_L                     : std_logic_vector(31 downto 0);
signal PC_LOAD                  : bit;
signal PC_LOAD_EXH              : bit;
signal PC_LOAD_MAIN             : bit;
signal PC_OFFSET                : std_logic_vector(7 downto 0);
signal PC_OFFSET_EXH            : std_logic_vector(2 downto 0);
signal PC_OFFSET_OPD            : std_logic_vector(7 downto 0);
signal PC_REG                   : std_logic_vector(31 downto 0);
signal PC_RESTORE_EXH           : bit;
signal RB                       : std_logic;
signal RC                       : std_logic;
signal RD_REQ                   : bit;
signal RD_REQ_I                 : bit;
signal RMC                      : bit;
signal REST_BIW_0               : bit;
signal RERUN_RMC                : bit;
signal RESTORE_ISP_PC           : bit;
signal RESET_CPU                : bit;
signal RESET_IN                 : std_logic;
signal RESET_STRB               : bit;
signal RTE_INIT                 : bit;
signal RTE_RESUME               : bit;
signal SP_ADD_DISPL             : bit;
signal SP_ADD_DISPL_EXH         : bit;
signal SP_ADD_DISPL_MAIN        : bit;
signal SBIT                     : std_logic;
signal SBIT_AREG                : std_logic;
signal SSW_80                   : std_logic_vector(8 downto 0);
signal SFC                      : std_logic_vector(2 downto 0);
signal SFC_RD                   : bit;
signal SFC_WR                   : bit;
signal SR_CPY                   : std_logic_vector(15 downto 0);
signal SR_RD                    : bit;
signal SR_INIT                  : bit;
signal SR_WR                    : bit;
signal SR_WR_EXH                : bit;
signal SR_WR_MAIN               : bit;
signal STACK_FORMAT             : std_logic_vector(3 downto 0);
signal STACK_POS                : integer range 0 to 46;
signal STATUS_REG               : std_logic_vector(15 downto 0);
signal STORE_ADR_FORMAT         : bit;
signal STORE_ABS_HI             : bit;
signal STORE_ABS_LO             : bit;
signal STORE_D16                : bit;
signal STORE_DISPL              : bit;
signal STORE_IDATA_B1           : bit;
signal STORE_IDATA_B2           : bit;
signal TRAP_BERR                : bit;
signal TRAP_AERR                : bit;
signal TRAP_ILLEGAL             : bit;
signal TRAP_CODE_OPC            : TRAPTYPE_OPC;
signal TRAP_CHK                 : bit;
signal TRAP_DIVZERO             : bit;
signal TRAP_V                   : bit;
signal UNMARK                   : bit;
signal USE_APAIR                : boolean;
signal USE_DFC                  : bit;
signal USE_SFC                  : bit;
signal USE_DPAIR                : boolean;
signal USP_RD                   : bit;
signal USP_WR                   : bit;
signal VBIT                     : std_logic;
signal VBR                      : std_logic_vector(31 downto 0);
signal VBR_WR                   : bit;
signal VBR_RD                   : bit;
signal WR_REQ                   : bit;
signal WR_REQ_I                 : bit;
begin
    IDATA_BUFFER : process
    -- This register stores the immediate data.
    begin
        wait until CLK = '1' and CLK' event;
        if STORE_IDATA_B2 = '1' then
            IBUFFER(31 downto 16) <= EXT_WORD;
        elsif STORE_IDATA_B1 = '1' then
            IBUFFER(15 downto 0) <= EXT_WORD;
        end if;
    end process IDATA_BUFFER;

    DATA_IMMEDIATE <= BIW_1 & BIW_2 when OP = ADDI and OP_SIZE = LONG else
                      BIW_1 & BIW_2 when OP = ANDI and OP_SIZE = LONG else
                      BIW_1 & BIW_2 when OP = CMPI and OP_SIZE = LONG else
                      BIW_1 & BIW_2 when OP = EORI and OP_SIZE = LONG else
                      BIW_1 & BIW_2 when OP = SUBI and OP_SIZE = LONG else
                      BIW_1 & BIW_2 when OP = ORI and OP_SIZE = LONG else
                      x"0000" & BIW_1 when OP = ANDI_TO_SR else
                      x"0000" & BIW_1 when OP = EORI_TO_SR else
                      x"0000" & BIW_1 when OP = ORI_TO_SR else
                      x"0000" & BIW_1 when OP = STOP else
                      x"0000" & BIW_1 when OP = ADDI and OP_SIZE = WORD else
                      x"0000" & BIW_1 when OP = ANDI and OP_SIZE = WORD else
                      x"0000" & BIW_1 when OP = CMPI and OP_SIZE = WORD else
                      x"0000" & BIW_1 when OP = EORI and OP_SIZE = WORD else
                      x"0000" & BIW_1 when OP = SUBI and OP_SIZE = WORD else
                      x"0000" & BIW_1 when OP = ORI and OP_SIZE = WORD else
                      x"000000" & BIW_1(7 downto 0) when OP = ANDI_TO_CCR else
                      x"000000" & BIW_1(7 downto 0) when OP = EORI_TO_CCR else
                      x"000000" & BIW_1(7 downto 0) when OP = ORI_TO_CCR else
                      x"000000" & BIW_1(7 downto 0) when OP = ADDI and OP_SIZE = BYTE else
                      x"000000" & BIW_1(7 downto 0) when OP = ANDI and OP_SIZE = BYTE else
                      x"000000" & BIW_1(7 downto 0) when OP = CMPI and OP_SIZE = BYTE else
                      x"000000" & BIW_1(7 downto 0) when OP = EORI and OP_SIZE = BYTE else
                      x"000000" & BIW_1(7 downto 0) when OP = SUBI and OP_SIZE = BYTE else
                      x"000000" & BIW_1(7 downto 0) when OP = ORI and OP_SIZE = BYTE else
                      x"000000" & "00000" & BIW_0(11 downto 9) when OP = ADDQ or OP = SUBQ else
                      x"000000" & BIW_0(7 downto 0) when OP = MOVEQ else
                      x"00000001" when OP = DBcc else
                      IBUFFER when OP_SIZE = LONG else x"0000" & IBUFFER(15 downto 0);

    -- Internal registers are place holders written as zeros.
    DATA_EXH <= -- Exception handler multiplexing:
                DATA_TO_CORE when DATA_RERUN_EXH = '1' else -- Rerun the write cycle.
                SR_CPY & PC(31 downto 16) when STACK_POS = 2 else
                PC(15 downto 0) & STACK_FORMAT & "00" & IVECT_OFFS when STACK_POS = 4 else
                PC_REG when STACK_FORMAT = x"2" and STACK_POS = 6 else
                PC_REG when STACK_FORMAT = x"9" and STACK_POS = 6 else
                x"0000" & FC & FB & RC & RB & "000" & SSW_80 when STACK_POS = 6 else -- Format A and B.
                x"0000" & BIW_0 when STACK_FORMAT = x"9" and STACK_POS = 8 else
                BIW_1 & BIW_2 when STACK_POS = 8 else -- Format A and B.
                ADR_EFF when STACK_FORMAT = x"9" and STACK_POS = 10 else -- ADR_EFF_cp.
                ADR_CPY_EXH when STACK_POS = 10 else
                OUTBUFFER when STACK_POS = 14 else
                PC_REG + "100" when STACK_POS = 20 else --STAGE B address.
                INBUFFER when STACK_POS = 24 else
                x"0000" & VERSION when STACK_POS = 28 else x"00000000";

    DATA_IN_EXH <= ALU_RESULT(31 downto 0) when OP = MOVEC else DATA_TO_CORE;

    DATA_FROM_CORE <= DATA_EXH when BUSY_EXH = '1' and BUSY_MAIN = '0' else
                      ALU_RESULT(31 downto 0);

    AR_DEC <= AR_DEC_MAIN or AR_DEC_EXH;
 
    AR_SEL_RD_1 <= "1111" when BUSY_EXH = '1' and BUSY_MAIN = '0' else AR_SEL_RD_1_MAIN; --(ISP)

    AR_IN_1 <= DATA_TO_CORE when PC_RESTORE_EXH = '1' else
               DATA_TO_CORE when ISP_LOAD = '1' else
               INT_VECT when PC_LOAD_EXH = '1' else
               ADR_EFF when OP = JMP or OP = JSR else
               AR_OUT_1 when OP = LINK or OP = UNLK else 
               AR_OUT_1 when OP = EXG and BIW_0(7 downto 3) = "01001" else -- Two address registers.
               DR_OUT_2 when OP = EXG and BIW_0(7 downto 3) = "10001" else -- Address- and data register.
               DATA_TO_CORE when OP = RTD or OP = RTR or OP = RTS else
               ALU_RESULT(31 downto 0);

    AR_IN_2 <= AR_OUT_2 when OP = EXG else DATA_TO_CORE;

    DR_IN_1 <= DR_OUT_1 when OP = EXG and BIW_0(7 downto 3) = "01000" else -- Two data registers.
               AR_OUT_1 when OP = EXG and BIW_0(7 downto 3) = "10001"else -- Address and data registers.
               ALU_RESULT(31 downto 0);

    DR_IN_2 <= DR_OUT_2 when OP = EXG and BIW_0(7 downto 3) = "01000" else -- Two data registers.
               ALU_RESULT(63 downto 32);

    ALU_OP1_IN <= DATA_TO_CORE when SR_WR_EXH = '1' else
                  DATA_IMMEDIATE when OP = DBcc else
                  DR_OUT_1 when (OP = ABCD or OP = SBCD) and BIW_0(3) = '0' else
                  DATA_TO_CORE when OP = ABCD or OP = SBCD else
                  DR_OUT_1 when (OP = ADD or OP = SUB) and BIW_0(8) = '1' else
                  DR_OUT_1 when (OP = AND_B or OP = EOR or  OP = OR_B) and BIW_0(8) = '1' else
                  DR_OUT_1 when (OP = ADDX or OP = SUBX) and BIW_0(3) = '0' else
                  DATA_TO_CORE when OP = ADDX or OP = SUBX else
                  DR_OUT_1 when OP = ASL or OP = ASR or OP = LSL or OP = LSR else
                  DR_OUT_1 when OP = ROTL or OP = ROTR or OP = ROXL or OP = ROXR else
                  DATA_TO_CORE when OP = CMPM else
                  PC + PC_EW_OFFSET when OP = BSR or OP = JSR else
                  ADR_EFF when OP = LEA or OP = PEA else
                  AR_OUT_1 when OP = MOVE_USP else
                  VBR when OP = MOVEC and VBR_RD = '1' else
                  x"0000000" & '0' & SFC when OP = MOVEC and SFC_RD = '1' else
                  x"0000000" & '0' & DFC when OP = MOVEC and DFC_RD = '1' else
                  AR_OUT_1 when OP = MOVEC and BIW_1(15) = '1' else
                  DR_OUT_1 when OP = MOVEC else
                  DR_OUT_1 when OP = MOVEM and BIW_0(10) = '0' and ADn = '0' else -- Register to memory.
                  AR_OUT_2 when OP = MOVEM and BIW_0(10) = '0' else -- Register to memory.
                  DR_OUT_1 when OP = MOVES and BIW_1(11) = '1' and BIW_1(15) = '0' else -- Register to Memory.
                  AR_OUT_2 when OP = MOVES and BIW_1(11) = '1' else -- Register to memory.
                  x"000000" & DR_OUT_1(31 downto 24) when OP = MOVEP and MOVEP_PNTR = 4 and BIW_0(7 downto 6) > "01" else
                  x"000000" & DR_OUT_1(23 downto 16) when OP = MOVEP and MOVEP_PNTR = 3 and BIW_0(7 downto 6) > "01"  else
                  x"000000" & DR_OUT_1(15 downto 8) when OP = MOVEP and MOVEP_PNTR = 2 and BIW_0(7 downto 6) > "01"  else
                  x"000000" & DR_OUT_1(7 downto 0) when OP = MOVEP and BIW_0(7 downto 6) > "01"  else
                  DATA_TO_CORE(7 downto 0) & DR_OUT_1(23 downto 0) when OP = MOVEP and MOVEP_PNTR = 3 else
                  DR_OUT_1(31 downto 24) & DATA_TO_CORE(7 downto 0) & DR_OUT_1(15 downto 0)  when OP = MOVEP and MOVEP_PNTR = 2 else
                  DR_OUT_1(31 downto 16) & DATA_TO_CORE(7 downto 0) & DR_OUT_1(7 downto 0)  when OP = MOVEP and MOVEP_PNTR = 1 else
                  DR_OUT_1(31 downto 8) & DATA_TO_CORE(7 downto 0) when OP = MOVEP else
                  x"0000" & STATUS_REG(15 downto 5) & DR_OUT_1(4 downto 0) when OP = MOVE_TO_CCR and BIW_0(5 downto 3) = "000" else
                  x"0000" & STATUS_REG(15 downto 5) & DATA_IMMEDIATE(4 downto 0) when OP = MOVE_TO_CCR and BIW_0(5 downto 0) = "111100" else
                  x"0000" & STATUS_REG(15 downto 5) & DATA_TO_CORE(4 downto 0) when OP = MOVE_TO_CCR else
                  x"0000" & DR_OUT_1(15 downto 0) when OP = MOVE_TO_SR and BIW_0(5 downto 3) = "000" else
                  x"0000" & DATA_IMMEDIATE(15 downto 0) when OP = MOVE_TO_SR and BIW_0(5 downto 0) = "111100" else
                  x"0000" & DATA_TO_CORE(15 downto 0) when OP = MOVE_TO_SR else
                  x"000000" & "000" & STATUS_REG(4 downto 0) when OP = MOVE_FROM_CCR else
                  x"0000" & STATUS_REG when OP = MOVE_FROM_SR else
                  DATA_IMMEDIATE when OP = STOP else -- Status register information.
                  DATA_IMMEDIATE when OP = MOVEQ else
                  DATA_IMMEDIATE when OP = ADDI or OP = CMPI or OP = SUBI or OP = ANDI or OP = EORI or OP = ORI else
                  DATA_IMMEDIATE when OP = ADDQ or OP = SUBQ else
                  DATA_IMMEDIATE when OP = ANDI_TO_CCR or OP = ANDI_TO_SR else
                  DATA_IMMEDIATE when OP = EORI_TO_CCR or OP = EORI_TO_SR else 
                  DATA_IMMEDIATE when OP = ORI_TO_CCR or OP = ORI_TO_SR else 
                  DR_OUT_1 when BIW_0(5 downto 3) = "000" else
                  AR_OUT_1 when BIW_0(5 downto 3) = "001" else
                  DATA_IMMEDIATE when BIW_0(5 downto 0) = "111100" else DATA_TO_CORE;

    ALU_OP2_IN <= DR_OUT_2 when (OP = ABCD or OP = SBCD) and BIW_0(3) = '0' else
                  DATA_TO_CORE when OP = ABCD or OP = SBCD else
                  DR_OUT_2 when (OP = ADDX or OP = SUBX) and BIW_0(3) = '0' else
                  DATA_TO_CORE when OP = ADDX or OP = SUBX else
                  DR_OUT_2 when (OP = ADD or OP = CMP or OP = SUB) and BIW_0(8) = '0' else
                  DR_OUT_2 when (OP = AND_B or OP = OR_B) and BIW_0(8) = '0' else
                  AR_OUT_2 when (OP = ADDA or OP = CMPA or OP = SUBA) else
                  DR_OUT_2 when (OP = ASL or OP = ASR) and BIW_0(7 downto 6) /= "11" else -- Register shifts.
                  DR_OUT_2 when (OP = LSL or OP = LSR) and BIW_0(7 downto 6) /= "11" else -- Register shifts.
                  DR_OUT_2 when (OP = ROTL or OP = ROTR) and BIW_0(7 downto 6) /= "11" else -- Register shifts.
                  DR_OUT_2 when (OP = ROXL or OP = ROXR) and BIW_0(7 downto 6) /= "11" else -- Register shifts.
                  x"0000" & STATUS_REG when(OP = ANDI_TO_CCR or OP = ANDI_TO_SR) else
                  x"0000" & STATUS_REG when(OP = EORI_TO_CCR or OP = EORI_TO_SR) else
                  x"0000" & STATUS_REG when(OP = ORI_TO_CCR or OP = ORI_TO_SR) else 
                  AR_OUT_2 when OP = CHK else
                  DATA_TO_CORE when OP = CMPM else
                  DR_OUT_2 when OP = DBcc or OP = SWAP else
                  DR_OUT_2 when OP = DIVS or OP = DIVU else
                  DR_OUT_2 when OP = MULS or OP = MULU else
                  AR_OUT_1 when OP = LINK else
                  DR_OUT_2 when BIW_0(5 downto 3) = "000" else
                  AR_OUT_2 when BIW_0(5 downto 3) = "001" else DATA_TO_CORE;

    ALU_OP3_IN <= DR_OUT_1;

    OP_SIZE <= OP_SIZE_EXH when BUSY_EXH = '1' and BUSY_MAIN = '0' else OP_SIZE_MAIN;
    OP_SIZE_BUS <= OP_SIZE_WB when DATA_WR_MAIN = '1' else OP_SIZE;


    FC_OUT <= FC_OUT_EXH when DATA_RERUN_EXH = '1' else FC_OUT_I;

    PC_OFFSET <= PC_OFFSET_OPD + PC_OFFSET_EXH;
    PC_L <= PC + PC_ADR_OFFSET + PC_OFFSET_EXH;

    ADR_MODE <= "010" when BUSY_EXH = '1' and BUSY_MAIN = '0' else ADR_MODE_MAIN; --(ISP)

    -- The bit field offset is byte aligned
    ADR_OFFSET <= ADR_OFFSET_EXH when BUSY_EXH = '1' and BUSY_MAIN = '0' else
                  "00" & ADR_OFFSET_MAIN;

    DBcc_COND <= true when OP = DBcc and ALU_RESULT(15 downto 0) = x"FFFF" else false;

    LOOP_EXIT <= LOOP_EXIT_EXH or LOOP_EXIT_MAIN;

    DATA_RD <= DATA_RD_EXH or DATA_RD_MAIN;
    DATA_WR <= DATA_WR_EXH or DATA_WR_MAIN;

    P_BUSREQ: process
    begin
        wait until CLK = '1' and CLK' event;
        -- We need these flip flops to avoid combinatorial loops:
        -- The requests are valid until the bus controller enters
        -- its START_CYCLE bus phase and asserts there the BUS_BSY.
        -- After the bus controller enters the bus access state,
        -- the requests are withdrawn.
        if BUS_BSY = '0' then
            RD_REQ_I <= DATA_RD and not ADR_ATN;
            WR_REQ_I <= DATA_WR;
            OPCODE_REQ_I <= OPCODE_RD;
        elsif BUS_BSY = '1' then
            RD_REQ_I <= '0';
            WR_REQ_I <= '0';
            OPCODE_REQ_I <= '0';
        end if;
    end process P_BUSREQ;

    RD_REQ <= DATA_RD and not ADR_ATN when BUS_BSY = '0' else RD_REQ_I;
    WR_REQ <= DATA_WR when BUS_BSY = '0' else WR_REQ_I;
    OPCODE_REQ <= OPCODE_RD when BUS_BSY = '0' else OPCODE_REQ_I;

    DISPLACEMENT <= DISPLACEMENT_MAIN when BUSY_MAIN = '1' else x"000000" & DISPLACEMENT_EXH;

    OPCODE_DATA_OPD <= DATA_TO_CORE(15 downto 0) when REST_BIW_0 = '1' else OPCODE_TO_CORE;

    SR_WR <= SR_WR_EXH or SR_WR_MAIN;

    IPIPE_FLUSH <= IPIPE_FLUSH_EXH or IPIPE_FLUSH_MAIN;

    SP_ADD_DISPL <= SP_ADD_DISPL_EXH or SP_ADD_DISPL_MAIN;

    PC_INC <= PC_INC_OPCODE or PC_INC_EXH;

    AVECn_BUSIF <= AVECn when BUSY_EXH = '1' else '1';

    CPU_SPACE <= '1' when OP = BKPT and DATA_RD_MAIN = '1' else
                 CPU_SPACE_EXH when BUSY_EXH = '1' and BUSY_MAIN = '0' else '0';

    -- The BITPOS is valid for bit operations and bit field operations. For BCHG, BCLR, BSET and BTST
    -- the BITPOS spans o to 31 bytes, when it is in register direct mode. It is modulo  in memory
    -- manipulation mode. For the bit field operations in register direct mode it also isin the 
    -- range 0 to 31. For bit fields in memory the value is byte wide (0 to 7) because the bit
    -- field from a memory location are loaded from byte boundaries.
    BITPOS <= BIW_1(4 downto 0) when (OP = BCHG or OP = BCLR or OP = BSET or OP = BTST) and BIW_0(8) = '0' and ADR_MODE = "000" else
              "00" & BIW_1(2 downto 0) when (OP = BCHG or OP = BCLR or OP = BSET or OP = BTST) and BIW_0(8) = '0' else
              DR_OUT_1(4 downto 0) when (OP = BCHG or OP = BCLR or OP = BSET or OP = BTST) and ADR_MODE = "000" else
              "00" & DR_OUT_1(2 downto 0) when OP = BCHG or OP = BCLR or OP = BSET or OP = BTST else
              BIW_1(10 downto 6) when BIW_1(11) = '0' and ADR_MODE = "000" else
              "00" & BIW_1(8 downto 6) when BIW_1(11) = '0' else
              DR_OUT_1(4 downto 0) when ADR_MODE = "000" else "00" & DR_OUT_1(2 downto 0);

    TRAP_AERR <= AERR when BUSY_EXH = '0' else '0'; -- No address error froim the system during exception processing.
    TRAP_BERR <= BERR_WR or BERR_MAIN;

    USE_DFC <= '1' when OP = MOVES and DATA_WR_MAIN = '1' else '0';
    USE_SFC <= '1' when OP = MOVES and DATA_RD_MAIN = '1' else '0';

    PC_LOAD <= PC_LOAD_EXH or PC_LOAD_MAIN;

    RESET_IN <= not RESET_INn;
    IPL <= not IPLn;
    
    -- We need these signals to mark the USP but not the active stack as 
    -- used register during MOVE_USP or MOVEC.
    SBIT_AREG <= '0' when USP_WR = '1' else STATUS_REG(13);
    SBIT <= STATUS_REG(13);

    ADR_L <= x"000000" & "000" & BIW_0(2 downto 0) & "00" when BKPT_CYCLE = '1' else
             x"FFFFFFF" & IRQ_PEND & '1' when CPU_SPACE_EXH = '1' else
             ADR_CPY_EXH when DATA_RERUN_EXH = '1' else 
             ADR_EFF_WB when DATA_WR_MAIN = '1' else ADR_EFF; -- Exception handler uses ADR_EFF.

    ADR_P <= ADR_LATCH when BUS_BSY = '1' else
             ADR_L when (DATA_RD = '1' and ADR_ATN = '0') or DATA_WR = '1' else PC_L;

    P_ADR_LATCH: process
    -- This register stores the address during a running bus cycle.
    -- The signals RD_DATA, WR_DATA and RD_OPCODE may change during
    -- the cycle. Opcode read is lower prioritized.
    begin
        wait until CLK = '1' and CLK' event;
        if BUS_BSY = '0' then
            ADR_LATCH <= ADR_P;
        end if;
    end process P_ADR_LATCH;

    P_FC_LATCH  : process
    -- This register stores the function code during a running bus cycle. 
    begin
        wait until CLK = '1' and CLK' event;
        if BUS_BSY = '0' then
            FC_LATCH <= FC_I;
        end if;
    end process P_FC_LATCH;

    FC_I <= FC_LATCH when BUS_BSY = '1' else
            SFC when USE_SFC = '1' else
            DFC when USE_DFC = '1' else
            "111" when ((DATA_RD = '1' and ADR_ATN = '0') or DATA_WR = '1') and CPU_SPACE = '1' else
            "101" when ((DATA_RD = '1' and ADR_ATN = '0') or DATA_WR = '1') and SBIT = '1' else
            "001" when (DATA_RD = '1' and ADR_ATN = '0') or DATA_WR = '1' else
            "110" when OPCODE_RD = '1' and SBIT = '1' else "010"; -- Default is OPCODE_RD and SBIT = '0'.

    I_ADRESSREGISTERS: WF68K10_ADDRESS_REGISTERS
        port map(
            CLK                     => CLK,
            RESET                   => RESET_CPU,
            AR_IN_1                 => AR_IN_1,
            AR_IN_2                 => AR_IN_2,
            AR_OUT_1                => AR_OUT_1,
            AR_OUT_2                => AR_OUT_2,
            INDEX_IN                => DR_OUT_1,
            PC                      => PC,
            PC_REG_OUT              => PC_REG,
            STORE_ADR_FORMAT        => STORE_ADR_FORMAT,
            STORE_ABS_HI            => STORE_ABS_HI,
            STORE_ABS_LO            => STORE_ABS_LO,
            STORE_D16               => STORE_D16,
            STORE_DISPL             => STORE_DISPL,
            OP_SIZE                 => OP_SIZE,
            OP_SIZE_WB              => OP_SIZE_WB,
            AR_MARK_USED            => AR_MARK_USED,
            USE_APAIR               => USE_APAIR,
            AR_IN_USE               => AR_IN_USE,
            AR_SEL_RD_1             => AR_SEL_RD_1,
            AR_SEL_RD_2             => AR_SEL_RD_2,
            AR_SEL_WR_1             => AR_SEL_WR_1,
            AR_SEL_WR_2             => AR_SEL_WR_2,
            DATA_RDY                => DATA_RDY,
            ADR_ATN                 => ADR_ATN,
            ADR_OFFSET              => ADR_OFFSET, -- Byte aligned.
            ADR_MARK_UNUSED         => ADR_MARK_UNUSED,
            ADR_MARK_USED           => ADR_MARK_USED,
            ADR_IN_USE              => ADR_IN_USE,
            ADR_MODE                => ADR_MODE,
            AMODE_SEL               => AMODE_SEL,
            ADR_EFF                 => ADR_EFF,
            ADR_EFF_WB              => ADR_EFF_WB,
            DFC                     => DFC,
            DFC_WR                  => DFC_WR,
            SFC                     => SFC,
            SFC_WR                  => SFC_WR,
            ISP_WR                  => ISP_LOAD,
            USP_RD                  => USP_RD,
            USP_WR                  => USP_WR,
            AR_DEC                  => AR_DEC,
            AR_INC                  => AR_INC,
            AR_WR_1                 => AR_WR_1,
            AR_WR_2                 => AR_WR_2,
            UNMARK                  => UNMARK,
            EXT_WORD                => EXT_WORD,
            SBIT                    => SBIT_AREG,
            SP_ADD_DISPL            => SP_ADD_DISPL,
            RESTORE_ISP_PC          => RESTORE_ISP_PC,
            DISPLACEMENT            => DISPLACEMENT,
            PC_ADD_DISPL            => PC_ADD_DISPL,
            PC_EW_OFFSET            => PC_EW_OFFSET,
            PC_INC                  => PC_INC,
            PC_LOAD                 => PC_LOAD,
            PC_RESTORE              => PC_RESTORE_EXH,
            PC_OFFSET               => PC_OFFSET
        );

    I_ALU: WF68K10_ALU
        port map(
            CLK                     => CLK,
            LOAD_OP2                => ALU_LOAD_OP2,
            LOAD_OP3                => ALU_LOAD_OP3,
            LOAD_OP1                => ALU_LOAD_OP1,
            OP1_IN                  => ALU_OP1_IN,
            OP2_IN                  => ALU_OP2_IN,
            OP3_IN                  => ALU_OP3_IN,
            BITPOS_IN               => BITPOS,
            RESULT                  => ALU_RESULT,
            ADR_MODE_IN             => ADR_MODE,
            OP_SIZE_IN              => OP_SIZE,
            OP_IN                   => OP,
            BIW_0_IN                => BIW_0(11 downto 0),
            BIW_1_IN                => BIW_1,
            SR_WR                   => SR_WR,
            SR_INIT                 => SR_INIT,
            CC_UPDT                 => CC_UPDT,
            STATUS_REG_OUT          => STATUS_REG,
            ALU_COND                => ALU_COND,
            ALU_INIT                => ALU_INIT,
            ALU_BSY                 => ALU_BSY,
            ALU_REQ                 => ALU_REQ,
            ALU_ACK                 => ALU_ACK,
            IRQ_PEND                => IRQ_PEND,
            TRAP_CHK                => TRAP_CHK,
            TRAP_DIVZERO            => TRAP_DIVZERO
        );

    I_BUS_IF: WF68K10_BUS_INTERFACE
        port map(
            CLK                 => CLK,

            ADR_IN_P            => ADR_P,
            ADR_OUT_P           => ADR_OUT,

            FC_IN               => FC_I,
            FC_OUT              => FC_OUT_I,

            DATA_PORT_IN        => DATA_IN,
            DATA_PORT_OUT       => DATA_OUT,
            DATA_FROM_CORE      => DATA_FROM_CORE,
            DATA_TO_CORE        => DATA_TO_CORE,
            OPCODE_TO_CORE      => OPCODE_TO_CORE,

            DATA_PORT_EN        => DATA_EN,
            BUS_EN              => BUS_EN,

            OP_SIZE             => OP_SIZE_BUS,

            RD_REQ              => RD_REQ,
            WR_REQ              => WR_REQ,
            DATA_RDY            => DATA_RDY,
            DATA_VALID          => DATA_VALID,
            OPCODE_REQ          => OPCODE_REQ,
            OPCODE_RDY          => OPCODE_RDY,
            OPCODE_VALID        => OPCODE_VALID,
            RMC                 => RMC,
            BUSY_EXH            => BUSY_EXH,
            SSW_80              => SSW_80,
            INBUFFER            => INBUFFER,
            OUTBUFFER           => OUTBUFFER,

            DTACKn              => DTACKn,
            ASn                 => ASn,
            UDSn                => UDSn,
            LDSn                => LDSn,
            RWn                 => RWn,
            RMCn                => RMCn,
            DBENn               => DBENn,

            E                   => E,
            VMAn                => VMAn,
            VMA_EN              => VMA_EN,
            VPAn                => VPAn,

            BRn                 => BRn,
            BGACKn              => BGACKn,
            BGn                 => BGn,

            RESET_STRB          => RESET_STRB,
            RESET_IN            => RESET_IN,
            RESET_OUT           => RESET_OUT,
            RESET_CPU           => RESET_CPU,

            AVECn               => AVECn_BUSIF,
            HALTn               => HALT_INn,
            BERRn               => BERRn,
            AERR                => AERR,
            BERR_WR             => BERR_WR,

            BUS_BSY             => BUS_BSY
        );

    I_CONTROL: WF68K10_CONTROL
        port map(
            CLK                     => CLK,
            RESET_CPU               => RESET_CPU,
            BUSY                    => BUSY_MAIN,
            BUSY_EXH                => BUSY_EXH,
            BUSY_OPD                => BUSY_OPD,
            EW_REQ                  => EW_REQ_MAIN,
            OW_REQ                  => OW_REQ_MAIN,
            OW_VALID                => OW_VALID,
            OPD_ACK                 => OPD_ACK_MAIN,
            RERUN_RMC               => RERUN_RMC,
            EW_ACK                  => EW_ACK,
            ADR_MARK_UNUSED         => ADR_MARK_UNUSED,
            ADR_MARK_USED           => ADR_MARK_USED,
            ADR_IN_USE              => ADR_IN_USE,
            ADR_OFFSET              => ADR_OFFSET_MAIN,
            DATA_RD                 => DATA_RD_MAIN,
            DATA_WR                 => DATA_WR_MAIN,
            DATA_RDY                => DATA_RDY,
            DATA_VALID              => DATA_VALID,
            RMC                     => RMC,
            LOAD_OP1                => ALU_LOAD_OP1,
            LOAD_OP2                => ALU_LOAD_OP2,
            LOAD_OP3                => ALU_LOAD_OP3,
            STORE_ADR_FORMAT        => STORE_ADR_FORMAT,
            STORE_ABS_HI            => STORE_ABS_HI,
            STORE_ABS_LO            => STORE_ABS_LO,
            STORE_D16               => STORE_D16,
            STORE_DISPL             => STORE_DISPL,
            STORE_IDATA_B1          => STORE_IDATA_B1,
            STORE_IDATA_B2          => STORE_IDATA_B2,
            OP                      => OP,
            OP_SIZE                 => OP_SIZE_MAIN,
            BIW_0                   => BIW_0(13 downto 0),
            BIW_1                   => BIW_1,
            BIW_2                   => BIW_2,
            EXT_WORD                => EXT_WORD,
            ADR_MODE                => ADR_MODE_MAIN,
            AMODE_SEL               => AMODE_SEL,
            OP_SIZE_WB              => OP_SIZE_WB,
            AR_MARK_USED            => AR_MARK_USED,
            AR_IN_USE               => AR_IN_USE,
            AR_SEL_RD_1             => AR_SEL_RD_1_MAIN,
            AR_SEL_RD_2             => AR_SEL_RD_2,
            AR_SEL_WR_1             => AR_SEL_WR_1,
            AR_SEL_WR_2             => AR_SEL_WR_2,
            AR_INC                  => AR_INC,
            AR_DEC                  => AR_DEC_MAIN,
            AR_WR_1                 => AR_WR_1,
            AR_WR_2                 => AR_WR_2,
            DR_MARK_USED            => DR_MARK_USED,
            USE_APAIR               => USE_APAIR,
            USE_DPAIR               => USE_DPAIR,
            DR_IN_USE               => DR_IN_USE,
            DR_SEL_WR_1             => DR_SEL_WR_1,
            DR_SEL_WR_2             => DR_SEL_WR_2,
            DR_SEL_RD_1             => DR_SEL_RD_1,
            DR_SEL_RD_2             => DR_SEL_RD_2,
            DR_WR_1                 => DR_WR_1,
            DR_WR_2                 => DR_WR_2,
            UNMARK                  => UNMARK,
            DISPLACEMENT            => DISPLACEMENT_MAIN,
            PC_ADD_DISPL            => PC_ADD_DISPL,
            PC_LOAD                 => PC_LOAD_MAIN,
            SP_ADD_DISPL            => SP_ADD_DISPL_MAIN,
            DFC_RD                  => DFC_RD,
            DFC_WR                  => DFC_WR,
            SFC_RD                  => SFC_RD,
            SFC_WR                  => SFC_WR,
            VBR_RD                  => VBR_RD,
            VBR_WR                  => VBR_WR,
            USP_RD                  => USP_RD,
            USP_WR                  => USP_WR,
            IPIPE_FLUSH             => IPIPE_FLUSH_MAIN,
            ALU_INIT                => ALU_INIT,
            ALU_BSY                 => ALU_BSY,
            ALU_REQ                 => ALU_REQ,
            ALU_ACK                 => ALU_ACK,
            BKPT_CYCLE              => BKPT_CYCLE,
            BKPT_INSERT             => BKPT_INSERT,
            LOOP_BSY                => LOOP_BSY,
            LOOP_EXIT               => LOOP_EXIT_MAIN,
            SR_WR                   => SR_WR_MAIN,
            MOVEM_ADn               => ADn,
            MOVEP_PNTR              => MOVEP_PNTR,
            CC_UPDT                 => CC_UPDT,
            TRACE_EN                => STATUS_REG(15),
            VBIT                    => STATUS_REG(1),
            ALU_COND                => ALU_COND,
            DBcc_COND               => DBcc_COND,
            RESET_STRB              => RESET_STRB,
            IPENDn                  => IPEND_In,
            BERR                    => BERR_MAIN,
            EX_TRACE                => EX_TRACE,
            TRAP_V                  => TRAP_V,
            TRAP_ILLEGAL            => TRAP_ILLEGAL,
            RTE_INIT                => RTE_INIT,
            RTE_RESUME              => RTE_RESUME
        );

    I_DATA_REGISTERS: WF68K10_DATA_REGISTERS
        port map(
            CLK                     => CLK,
            RESET                   => RESET_CPU,
            DR_IN_1                 => DR_IN_1,
            DR_IN_2                 => DR_IN_2,
            DR_OUT_2                => DR_OUT_2,
            DR_OUT_1                => DR_OUT_1,
            DR_SEL_WR_1             => DR_SEL_WR_1,
            DR_SEL_WR_2             => DR_SEL_WR_2,
            DR_SEL_RD_1             => DR_SEL_RD_1,
            DR_SEL_RD_2             => DR_SEL_RD_2,
            DR_WR_1                 => DR_WR_1,
            DR_WR_2                 => DR_WR_2,
            DR_MARK_USED            => DR_MARK_USED,
            USE_DPAIR               => USE_DPAIR,
            DR_IN_USE               => DR_IN_USE,
            UNMARK                  => UNMARK,
            OP_SIZE                 => OP_SIZE_WB
        );

    I_EXC_HANDLER: WF68K10_EXCEPTION_HANDLER
        generic map(VERSION         => VERSION)
        port map(   
            CLK                     => CLK,
            RESET_CPU               => RESET_CPU,
            BUSY_EXH                => BUSY_EXH,
            BUSY_MAIN               => BUSY_MAIN,
    
            ADR_IN                  => ADR_EFF,
            ADR_CPY                 => ADR_CPY_EXH,
            ADR_OFFSET              => ADR_OFFSET_EXH,
            FC_OUT                  => FC_OUT_EXH,
            CPU_SPACE               => CPU_SPACE_EXH,
    
            DATA_0                  => DATA_TO_CORE(0),
            DATA_RD                 => DATA_RD_EXH,
            DATA_WR                 => DATA_WR_EXH,
            DATA_RERUN              => DATA_RERUN_EXH,
            DATA_IN                 => DATA_IN_EXH,
    
            OP_SIZE                 => OP_SIZE_EXH,
            DATA_RDY                => DATA_RDY,
            DATA_VALID              => DATA_VALID,
            RERUN_RMC               => RERUN_RMC,
    
            OPCODE_RDY              => OPCODE_RDY,
            OPD_ACK                 => OPD_ACK_MAIN,
            OW_VALID                => OW_VALID,
    
            STATUS_REG_IN           => STATUS_REG,
            SR_CPY                  => SR_CPY,
            SR_INIT                 => SR_INIT,
    
            SR_WR                   => SR_WR_EXH,
            ISP_LOAD                => ISP_LOAD,
            PC_LOAD                 => PC_LOAD_EXH,
            PC_INC                  => PC_INC_EXH,
            PC_RESTORE              => PC_RESTORE_EXH,
            PC_OFFSET               => PC_OFFSET_EXH,
    
            STACK_FORMAT            => STACK_FORMAT,
            STACK_POS               => STACK_POS,
            REST_BIW_0              => REST_BIW_0,
                
            AR_DEC                  => AR_DEC_EXH,
            ADD_DISPL               => SP_ADD_DISPL_EXH,
            DISPLACEMENT            => DISPLACEMENT_EXH,
            IPIPE_FLUSH             => IPIPE_FLUSH_EXH,
            RESTORE_ISP_PC          => RESTORE_ISP_PC,
            RTE_INIT                => RTE_INIT,
            RTE_RESUME              => RTE_RESUME,
    
            HALT_OUTn               => HALT_OUTn,
            LOOP_EXIT               => LOOP_EXIT_EXH,
    
            IRQ_IN                  => IPL,
            IRQ_PEND                => IRQ_PEND,
            AVECn                   => AVECn,
            IPENDn                  => IPEND_In,
            INT_VECT                => INT_VECT,
            IVECT_OFFS              => IVECT_OFFS,

            TRAP_AERR               => TRAP_AERR,
            TRAP_BERR               => TRAP_BERR,
            TRAP_CHK                => TRAP_CHK,
            TRAP_DIVZERO            => TRAP_DIVZERO,
            TRAP_ILLEGAL            => TRAP_ILLEGAL,
            TRAP_CODE_OPC           => TRAP_CODE_OPC,
            TRAP_VECTOR             => BIW_0(3 downto 0),
            TRAP_V                  => TRAP_V,
            EX_TRACE_IN             => EX_TRACE,
            VBR_WR                  => VBR_WR,
            VBR                     => VBR
        );

    I_OPCODE_DECODER: WF68K10_OPCODE_DECODER
        port map(
            CLK                     => CLK,
            K6800n                  => K6800n,

            OW_REQ_MAIN             => OW_REQ_MAIN,
            EW_REQ_MAIN             => EW_REQ_MAIN,
            BUSY_EXH                => BUSY_EXH,
            BUSY_MAIN               => BUSY_MAIN,
            BUSY_OPD                => BUSY_OPD,

            BKPT_INSERT             => BKPT_INSERT,
            BKPT_DATA               => DATA_TO_CORE(15 downto 0),
            LOOP_EXIT               => LOOP_EXIT,
            LOOP_BSY                => LOOP_BSY,

            OPD_ACK_MAIN            => OPD_ACK_MAIN,
            EW_ACK                  => EW_ACK,

            ADR_IN_PC_1             => PC_L(1),
            PC_INC                  => PC_INC_OPCODE,
            PC_INC_EXH              => PC_INC_EXH,
            PC_ADR_OFFSET           => PC_ADR_OFFSET,
            PC_EW_OFFSET            => PC_EW_OFFSET,
            PC_OFFSET               => PC_OFFSET_OPD,

            OPCODE_RD               => OPCODE_RD,
            OPCODE_RDY              => OPCODE_RDY,
            OPCODE_VALID            => OPCODE_VALID,
            OPCODE_DATA             => OPCODE_DATA_OPD,

            IPIPE_FLUSH             => IPIPE_FLUSH,

            -- Fault logic:
            OW_VALID                => OW_VALID,
            RC                      => RC,
            RB                      => RB,
            FC                      => FC,
            FB                      => FB,

            -- Trap logic:
            SBIT                    => SBIT,
            TRAP_CODE               => TRAP_CODE_OPC,

            -- System control:
            OP                      => OP,
            BIW_0                   => BIW_0,
            BIW_1                   => BIW_1,
            BIW_2                   => BIW_2,
            EXT_WORD                => EXT_WORD,
            REST_BIW_0              => REST_BIW_0
        );
end STRUCTURE;
