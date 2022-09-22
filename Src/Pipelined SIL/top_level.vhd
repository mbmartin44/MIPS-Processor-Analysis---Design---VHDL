-- Top Level Design File
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
------------------------------------------------------------------
ENTITY top_level IS -- 2 to 1 multiplexer
  PORT (
    clk : IN STD_LOGIC;
    branchEnable : OUT STD_LOGIC;
    pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stallBit : OUT STD_LOGIC;
    MEMWB_dataMemory_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    WB_writeData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    MEMWB_regWrite : OUT STD_LOGIC;
    ALU_operation : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    MEMWB_writeReg_sel : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    MEMWB_memToReg : OUT STD_LOGIC;
    instructionOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    instructionDE_readData1_probe : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- new probe
    instructionDE_readData2_probe : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- new probe
    instructionDE_signExtend_probe : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- new probe
    forwardAval : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    forwardBval : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
  );
END ENTITY;
------------------------------------------------------------------
ARCHITECTURE top_level_architecture OF top_level IS

  --SIGNALS
  -- ALU signals:
  SIGNAL ALU_in_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ALU_add_by_sig : STD_LOGIC_VECTOR(2 DOWNTO 0) := "100"; -- add by 4
  SIGNAL ALU_out_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL zero_sig : STD_LOGIC;
  SIGNAL ALUSRC_sig : STD_LOGIC;

  -- Control Signals
  SIGNAL opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL RegDst : STD_LOGIC;
  SIGNAL Branch : STD_LOGIC;
  SIGNAL MemRead : STD_LOGIC;
  SIGNAL MemWrite : STD_LOGIC;
  SIGNAL MemtoReg : STD_LOGIC;
  SIGNAL Jump : STD_LOGIC;
  SIGNAL RegWrite_sig : STD_LOGIC;
  SIGNAL branch_and_zero_signal : STD_LOGIC;

  -- ALU Control Signals
  SIGNAL func : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL Operation : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL ALUop_sig : STD_LOGIC_VECTOR(1 DOWNTO 0);

  --Datapath Signals
  SIGNAL aluMuxIn : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL readData1_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL readData2_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL muxToALU_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL writeReg_select : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL dataMemory_out_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL to_writeData_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);

  -- PC signals:
  SIGNAL PC_in_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL PC_out_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL incremented_PC_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL signExtenderOut_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL shiftLeft2_out_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL branch_plus_PC_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL branch_control_signal : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL mux_to_pc_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);

  --Instruction Memory Signals:
  SIGNAL instruction_in_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instruction_out_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL data_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL wren_sig : STD_LOGIC := '0';

  --Intermediate Register Signals
  --Instruction Fetch Decode
  SIGNAL instructionFD_incremented_PC_sig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instructionFD_instructOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
  --Instruction Decode Execution
  SIGNAL instructionDE_regWrite : STD_LOGIC;
  SIGNAL instructionDE_memToReg : STD_LOGIC;
  SIGNAL instructionDE_branch : STD_LOGIC;
  SIGNAL instructionDE_memWriteRead : STD_LOGIC;
  SIGNAL instructionDE_memRead : STD_LOGIC;
  SIGNAL instructionDE_regDst : STD_LOGIC;
  SIGNAL instructionDE_ALUOpOut : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL instructionDE_ALUSrcOUT : STD_LOGIC;
  SIGNAL instructionDE_PC : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instructionDE_readData1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instructionDE_readData2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instructionDE_signExtend : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instructionDE_RS : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL instructionDE_RT : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL instructionDE_RD : STD_LOGIC_VECTOR(4 DOWNTO 0);
  --Instruction Execution Memory
  SIGNAL instructionEM_regWrite : STD_LOGIC;
  SIGNAL instructionEM_memToReg : STD_LOGIC;
  SIGNAL instructionEM_branch : STD_LOGIC;
  SIGNAL instructionEM_memWriteRead : STD_LOGIC;
  SIGNAL instructionEM_PC : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instructionEM_zero : STD_LOGIC;
  SIGNAL instructionEM_ALUResult : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instructionEM_readData2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instructionEM_registerInfo : STD_LOGIC_VECTOR(4 DOWNTO 0);
  --Instruction Memory WriteBack
  SIGNAL instructionMW_memToReg : STD_LOGIC;
  SIGNAL instructionMW_regWrite : STD_LOGIC;
  SIGNAL instructionMW_memReadData : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instructionMW_ALUResult : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instructionMW_registerInfo : STD_LOGIC_VECTOR(4 DOWNTO 0);

  --Forward Unit Signals
  SIGNAL forwardA : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL forwardB : STD_LOGIC_VECTOR(1 DOWNTO 0);
  --Forward MuxA Output
  SIGNAL muxAout : STD_LOGIC_VECTOR(31 DOWNTO 0);
  --Forward MuxB Output
  SIGNAL muxBout : STD_LOGIC_VECTOR(31 DOWNTO 0);

  --Hazard Unit Signals
  SIGNAL stallSig : STD_LOGIC;
  SIGNAL ifidWrite : STD_LOGIC;
  SIGNAL PCWrite : STD_LOGIC;

  --megaMux Signals
  SIGNAL megaRegDst : STD_LOGIC;
  SIGNAL megaBranch : STD_LOGIC;
  SIGNAL megaMemWrite : STD_LOGIC;
  SIGNAL megaMemRead : STD_LOGIC;
  SIGNAL megaMemToReg : STD_LOGIC;
  SIGNAL megaALUOp : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL megaALUSrc : STD_LOGIC;
  SIGNAL megaRegWrite : STD_LOGIC;
  ------------------------------------------------------------------------------------------------------
  -- Primitives:
  --------------------------------------------------------------------------------------------
  COMPONENT Adder
    GENERIC (
      N : INTEGER;
      M : INTEGER
    );
    PORT (
      ALU_in : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
      ALU_add_by : IN STD_LOGIC_VECTOR(M - 1 DOWNTO 0);
      ALU_out : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
      zero : OUT STD_LOGIC
    );
  END COMPONENT;

  -----------------------------------------------------------------------------------------------------
  COMPONENT PC IS
    PORT (
      PC_Write : IN STD_LOGIC;
      clk : IN STD_LOGIC;
      PC_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      PC_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;
  -----------------------------------------------------------------------------------------------------
  COMPONENT and2c
    PORT (
      A : IN STD_LOGIC;
      B : IN STD_LOGIC;
      F : OUT STD_LOGIC
    );
  END COMPONENT;
  --------------------------------------------------------------------------------------------------------
  COMPONENT mux_generic32
    GENERIC (
      N : INTEGER
    );
    PORT (
      mux_in0 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
      mux_in1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
      mux_ctl : IN STD_LOGIC;
      mux_out : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
    );
  END COMPONENT;
  --------------------------------------------------------------------------------------------------------
  COMPONENT megaMux
    PORT (
      ctrl : IN STD_LOGIC;
      RegDstIN : IN STD_LOGIC;
      BranchIN : IN STD_LOGIC;
      MemReadIN : IN STD_LOGIC;
      MemWriteIN : IN STD_LOGIC;
      MemtoRegIN : IN STD_LOGIC;
      ALUOpIN : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      ALUSrcIN : IN STD_LOGIC;
      RegWriteIN : IN STD_LOGIC;
      JumpIN : IN STD_LOGIC;
      RegDstOUT : OUT STD_LOGIC;
      BranchOUT : OUT STD_LOGIC;
      MemReadOUT : OUT STD_LOGIC;
      MemWriteOUT : OUT STD_LOGIC;
      MemToRegOUT : OUT STD_LOGIC;
      ALUOpOUT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      ALUSrcOUT : OUT STD_LOGIC;
      RegWriteOUT : OUT STD_LOGIC;
      JumpOUT : OUT STD_LOGIC
    );
  END COMPONENT;
  -------------------------------------------------------------------------------------------------------
  COMPONENT mux32_3to1
    GENERIC (
      N : INTEGER
    );
    PORT (
      A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      C : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      Y : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;
  --------------------------------------------------------------------------------------------------------
  COMPONENT shift_left_2
    PORT (
      in_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      out_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;
  --------------------------------------------------------------------------------------------------------
  COMPONENT and_generic
    GENERIC (
      DATA_WIDTH : INTEGER;
      NUM_OUTPUTS : INTEGER
    );
    PORT (
      in_data1 : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
      in_data2 : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
      out_data : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
  END COMPONENT;
  ---------------------------------------------------------------------------------------------------------
  COMPONENT instructionFD
    PORT (
      ifidWrite : IN STD_LOGIC;
      clk : IN STD_LOGIC;
      PCIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      instructionIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      PCOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      instructionOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;
  -------------------------------------------------------------------------------------------------------------
  COMPONENT instructionDE
    PORT (
      clk : IN STD_LOGIC;
      regWriteIN : IN STD_LOGIC;
      memToRegIN : IN STD_LOGIC;
      branchIN : IN STD_LOGIC;
      memWriteReadIN : IN STD_LOGIC;
      memReadIN : IN STD_LOGIC;
      regDstIN : IN STD_LOGIC;
      ALUOpIN : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      ALUSrcIN : IN STD_LOGIC;
      PCIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      readData1IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      readData2IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      signExtendIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      rsIN : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      rtIN : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      rdIN : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      regWriteOUT : OUT STD_LOGIC;
      memtoRegOUT : OUT STD_LOGIC;
      branchOUT : OUT STD_LOGIC;
      memWriteReadOUT : OUT STD_LOGIC;
      memReadOUT : OUT STD_LOGIC;
      regDstOUT : OUT STD_LOGIC;
      ALUOpOUT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      ALUSrcOUT : OUT STD_LOGIC;
      PCOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      readData1OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      readData2OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      signExtendOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      rsOUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      rtOUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      rdOUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
  END COMPONENT;
  -----------------------------------------------------------------------------------------------------------------
  COMPONENT instructionEM
    PORT (
      clk : IN STD_LOGIC;
      regWriteIN : IN STD_LOGIC;
      memToRegIN : IN STD_LOGIC;
      branchIN : IN STD_LOGIC;
      memWriteReadIN : IN STD_LOGIC;
      addRIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      zeroIN : IN STD_LOGIC;
      ALUResultIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      readData2IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      registerInfoIN : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      regWriteOUT : OUT STD_LOGIC;
      memToRegOUT : OUT STD_LOGIC;
      branchOUT : OUT STD_LOGIC;
      memWriteReadOUT : OUT STD_LOGIC;
      addROUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      zeroOUT : OUT STD_LOGIC;
      ALUResultOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      readData2OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      registerInfoOUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
  END COMPONENT;
  -----------------------------------------------------------------------------------------------------
  COMPONENT instructionMW
    PORT (
      clk : IN STD_LOGIC;
      memToRegIN : IN STD_LOGIC;
      regWriteIN : IN STD_LOGIC;
      memReadDataIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      ALUResultIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      registerInfoIN : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      memToRegOUT : OUT STD_LOGIC;
      regWriteOUT : OUT STD_LOGIC;
      memReadDataOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ALUResultOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      registerInfoOUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
  END COMPONENT;
  -----------------------------------------------------------------------------------------------------
  -- DATAPATH COMPONENTS:
  COMPONENT InstructionMemory IS
    PORT (
      address : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      clock : IN STD_LOGIC := '1';
      data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      wren : IN STD_LOGIC;
      q : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
  END COMPONENT;
  -----------------------------------------------------------------------------------------------------
  COMPONENT dataMemoryFile
    PORT (
      address : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      clock : IN STD_LOGIC;
      data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      wren : IN STD_LOGIC;
      q : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
  END COMPONENT;

  -----------------------------------------------------------------------------------------------------
  COMPONENT registerFile
    PORT (
      readreg1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      readreg2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      writeReg_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      clk : IN STD_LOGIC;
      RegWrite : IN STD_LOGIC;
      readData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;
  ---------------------------------------------------------------------------------------------------------
  COMPONENT ALU
    PORT (
      ALU_in0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      ALU_in1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      ALU_cntl : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      ALU_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      zero : OUT STD_LOGIC
    );
  END COMPONENT;
  ----------------------------------------------------------------------------------------------------------
  COMPONENT signExtender
    PORT (
      signExtendIn : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      signExtendOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;
  ---------------------------------------------------------------------------------------------------------
  -- CONTROL UNIT COMPONENTS
  COMPONENT ALUControl
    PORT (
      func : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      ALUop : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      Operation : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT;
  ----------------------------------------------------------------------------------------------------------
  COMPONENT control
    PORT (
      opcode : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      RegDst : OUT STD_LOGIC;
      Branch : OUT STD_LOGIC;
      MemRead : OUT STD_LOGIC;
      MemWrite : OUT STD_LOGIC;
      MemtoReg : OUT STD_LOGIC;
      ALUOp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      ALUSrc : OUT STD_LOGIC;
      RegWrite : OUT STD_LOGIC;
      Jump : OUT STD_LOGIC
    );
  END COMPONENT;
  ------------------------------------------------------------------------------------------------------------------
  COMPONENT forward
    PORT (
      idexRT : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      idexRS : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      exmemRD : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      memwbRD : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      exmemRegWrite : IN STD_LOGIC;
      memwbRegWrite : IN STD_LOGIC;
      forwardA : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      forwardB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
  END COMPONENT;
  ----------------------------------------------------------------------------------------------------------------------
  COMPONENT hazardUnit
    PORT (
      idexRT : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      idexMemRead : IN STD_LOGIC;
      ifidRS : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      ifidRT : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      stallSig : OUT STD_LOGIC;
      ifidWrite : OUT STD_LOGIC;
      PCWrite : OUT STD_LOGIC
    );
  END COMPONENT;

BEGIN
  --********************************************************************************************************************
  -- PRIMTIIVE INSTANCES:
  ----------------------------------------------------------------------------------------------------------------------
  -- Increment the PC by 4:
  first_add : Adder
  GENERIC MAP(
    N => 32,
    M => 3
  )
  PORT MAP(
    ALU_in => PC_out_sig,
    ALU_out => incremented_PC_sig,
    ALU_add_by => ALU_add_by_sig, -- Constant integer -> 4
    zero => OPEN -- Zero signal not used here
  );
  ----------------------------------------------------------------------------------------------------------------------
  -- Add the PC and the shifted offset address:
  second_add : Adder
  GENERIC MAP(
    N => 32,
    M => 32
  )
  PORT MAP(
    ALU_in => instructionDE_PC,
    ALU_out => branch_plus_PC_sig,
    ALU_add_by => shiftLeft2_out_sig,
    zero => OPEN
  );

  BranchANDZero : and2c
  PORT MAP(
    A => instructionEM_branch,
    B => instructionEM_zero,
    F => branch_and_zero_signal
  );
  ----------------------------------------------------------------------------------------------------------------------
  left2_shifter : shift_left_2
  PORT MAP(
    in_data => signExtenderOut_sig,
    out_data => shiftLeft2_out_sig
  );
  ----------------------------------------------------------------------------------------------------------------------
  MUX1 : mux_generic32
  GENERIC MAP(
    N => 5
  )
  PORT MAP(
    mux_in0 => instructionDE_RT,
    mux_in1 => instructionDE_RD,
    mux_ctl => instructionDE_regDst,
    mux_out => writeReg_select
  );
  ----------------------------------------------------------------------------------------------------------------------
  MUX2 : mux_generic32
  GENERIC MAP(
    N => 32
  )
  PORT MAP(
    mux_in0 => muxBout,
    mux_in1 => instructionDE_signExtend,
    mux_ctl => instructionDE_ALUSrcOUT,
    mux_out => muxToALU_sig
  );
  ----------------------------------------------------------------------------------------------------------------------
  MUX3 : mux_generic32
  GENERIC MAP(
    N => 32
  )
  PORT MAP(
    mux_in0 => instructionMW_ALUResult,
    mux_in1 => instructionMW_memReadData,
    mux_ctl => instructionMW_memToReg,
    mux_out => to_writeData_sig
  );
  ------------------------------------------------------------------------------------------------
  MUX4 : mux_generic32
  GENERIC MAP(
    N => 32
  )
  PORT MAP(
    mux_in0 => incremented_PC_sig,
    mux_in1 => instructionEM_PC,
    mux_ctl => branch_and_zero_signal,
    mux_out => pc_in_sig
  );

  -----------------------------------------------------------------------------------------------
  mux32_3to1_forwardA : mux32_3to1
  GENERIC MAP(
    N => 32
  )
  PORT MAP(
    A => instructionDE_readData1,
    B => to_writeData_sig,
    C => instructionEM_ALUResult,
    S => forwardA,
    Y => muxAout
  );
  ---------------------------------------------------------------------------------------------------
  mux32_3to1_forwardB : mux32_3to1
  GENERIC MAP(
    N => 32
  )
  PORT MAP(
    A => instructionDE_readData2,
    B => to_writeData_sig,
    C => instructionEM_ALUResult,
    S => forwardB,
    Y => muxBout
  );
  ------------------------------------------------------------------------------------------------------
  megaMux_inst : megaMux
  PORT MAP(
    ctrl => stallSig,
    RegDstIN => RegDst,
    BranchIN => Branch,
    MemReadIN => MemRead,
    MemWriteIN => MemWrite,
    MemtoRegIN => MemtoReg,
    ALUOpIN => ALUOp_sig,
    ALUSrcIN => ALUSrc_sig,
    RegWriteIN => RegWrite_sig,
    JumpIN => Jump,
    RegDstOUT => megaRegDst,
    BranchOUT => megaBranch,
    MemReadOUT => megaMemRead,
    MemWriteOUT => megaMemWrite,
    MemToRegOUT => megaMemToReg,
    ALUOpOUT => megaALUOp,
    ALUSrcOUT => megaALUSrc,
    RegWriteOUT => megaRegWrite,
    JumpOUT => OPEN
  );

  --------------------------------------------------------------------------------------------
  signExtender_inst : signExtender
  PORT MAP(
    signExtendIn => instructionFD_instructOut(15 DOWNTO 0),
    signExtendOut => signExtenderOut_sig
  );
  ------------------------------------------------------------------------------------------------
  instructionFetch_Decode : instructionFD
  PORT MAP(
    ifidWrite => ifidWrite,
    clk => clk,
    PCIN => incremented_PC_sig,
    instructionIN => instruction_out_sig,
    PCOUT => instructionFD_incremented_PC_sig,
    instructionOUT => instructionFD_instructOut
  );
  ------------------------------------------------------------------------------------------------
  instructionDecode_Excecution : instructionDE
  PORT MAP(
    clk => clk,
    regWriteIN => megaRegWrite,
    memToRegIN => megaMemToReg,
    branchIN => megaBranch,
    memWriteReadIN => megaMemWrite,
    memReadIN => megaMemRead,
    regDstIN => megaRegDst,
    ALUOpIN => megaALUOp,
    ALUSrcIN => megaALUSrc,
    PCIN => instructionFD_incremented_PC_sig,
    readData1IN => readData1_sig,
    readData2IN => readData2_sig,
    signExtendIN => signExtenderOut_sig,
    rsIN => instructionFD_instructOut(25 DOWNTO 21),
    rtIN => instructionFD_instructOut(20 DOWNTO 16),
    rdIN => instructionFD_instructOut(15 DOWNTO 11),
    regWriteOUT => instructionDE_regWrite,
    memtoRegOUT => instructionDE_memToReg,
    branchOUT => instructionDE_branch,
    memWriteReadOUT => instructionDE_memWriteRead,
    memReadOUT => instructionDE_memRead,
    regDstOUT => instructionDE_regDst,
    ALUOpOUT => instructionDE_ALUOpOut,
    ALUSrcOUT => instructionDE_ALUSrcOUT,
    PCOUT => instructionDE_PC,
    readData1OUT => instructionDE_readData1,
    readData2OUT => instructionDE_readData2,
    signExtendOUT => instructionDE_signExtend,
    rsOUT => instructionDE_RS,
    rtOUT => instructionDE_RT,
    rdOUT => instructionDE_RD
  );
  -----------------------------------------------------------------------------------------------------
  instructionExecution_Memory : instructionEM
  PORT MAP(
    clk => clk,
    regWriteIN => instructionDE_regWrite,
    memToRegIN => instructionDE_memToReg,
    branchIN => instructionDE_branch,
    memWriteReadIN => instructionDE_memWriteRead,
    addRIN => branch_plus_PC_sig,
    zeroIN => zero_sig,
    ALUResultIN => ALU_out_sig,
    readData2IN => muxBout,
    registerInfoIN => writeReg_select,
    regWriteOUT => instructionEM_regWrite,
    memToRegOUT => instructionEM_memToReg,
    branchOUT => instructionEM_branch,
    memWriteReadOUT => instructionEM_memWriteRead,
    addROUT => instructionEM_PC,
    zeroOUT => instructionEM_zero,
    ALUResultOUT => instructionEM_ALUResult,
    readData2OUT => instructionEM_readData2,
    registerInfoOUT => instructionEM_registerInfo
  );
  --------------------------------------------------------------------------------------------
  instructionMemory_writeback : instructionMW
  PORT MAP(
    clk => clk,
    memToRegIN => instructionEM_memToReg, --Fix in reg pipeline
    regWriteIN => instructionEM_regWrite,
    memReadDataIN => dataMemory_out_sig,
    ALUResultIN => instructionEM_ALUResult,
    registerInfoIN => instructionEM_registerInfo,
    memToRegOUT => instructionMW_memToReg,
    regWriteOUT => instructionMW_regWrite,
    memReadDataOUT => instructionMW_memReadData,
    ALUResultOUT => instructionMW_ALUResult,
    registerInfoOUT => instructionMW_registerInfo
  );

  --*******************************************************************************************************************
  -- SUBCOMPONENTS:
  ------------------------------------------------------------------------------------------------
  -- Instantiate PC (Program Counter):
  ProgramCounter : PC
  PORT MAP(
    PC_Write => PCWrite,
    clk => clk,
    PC_in => PC_in_sig,
    PC_out => PC_out_sig
  );
  ---------------------------------------------------------------------------------------------------
  -- Instantiate Instruction Memory:
  Instruction_Memory : InstructionMemory
  PORT MAP(
    address => PC_out_sig(7 DOWNTO 0),
    clock => NOT clk,
    data => data_sig, -- no write operations occur, so leave on empty signal
    wren => wren_sig, -- no write operations occur
    q => Instruction_out_sig
  );
  ----------------------------------------------------------------------------------------------------
  dataMemoryFile_inst : dataMemoryFile
  PORT MAP(
    address => instructionEM_ALUResult(7 DOWNTO 0),
    clock => NOT clk,
    data => instructionEM_readData2,
    wren => instructionEM_memWriteRead,
    q => dataMemory_out_sig
  );

  -----------------------------------------------------------------------------------------------
  registerFile_inst : registerFile
  PORT MAP(
    readreg1 => instructionFD_instructOut(25 DOWNTO 21),
    readreg2 => instructionFD_instructOut(20 DOWNTO 16),
    writeReg_sel => instructionMW_registerInfo,
    writeData => to_writeData_sig, -- rewired
    clk => clk,
    RegWrite => instructionMW_regWrite,
    readData1 => readData1_sig,
    readData2 => readData2_sig
  );
  -----------------------------------------------------------------------------------------------
  ALU_inst : ALU
  PORT MAP(
    ALU_in0 => muxAout,
    ALU_in1 => muxToALU_sig,
    ALU_cntl => Operation,
    ALU_out => ALU_out_sig,
    zero => zero_sig
  );
  -----------------------------------------------------------------------------------------------
  ALUControl_inst : ALUControl
  PORT MAP(
    func => instructionDE_signExtend(5 DOWNTO 0),
    ALUop => instructionDE_ALUOpOut,
    Operation => Operation
  );
  ---------------------------------------------------------------------------------------------------
  control_inst : control
  PORT MAP(
    opcode => opcode,
    RegDst => RegDst,
    Branch => Branch,
    MemRead => MemRead,
    MemWrite => MemWrite,
    MemtoReg => MemtoReg,
    ALUOp => ALUop_sig,
    ALUSrc => ALUSRC_sig,
    RegWrite => RegWrite_sig,
    Jump => Jump
  );
  ----------------------------------------------------------------------------------------------------
  forward_inst : forward
  PORT MAP(
    idexRT => instructionDE_RT,
    idexRS => instructionDE_RS,
    exmemRD => instructionEM_registerInfo,
    memwbRD => instructionMW_registerInfo,
    exmemRegWrite => instructionEM_regWrite,
    memwbRegWrite => instructionMW_regWrite,
    forwardA => forwardA,
    forwardB => forwardB
  );
  ----------------------------------------------------------------------------------------------------
  hazardUnit_inst : hazardUnit
  PORT MAP(
    idexRT => instructionDE_RT,
    idexMemRead => instructionDE_memRead,
    ifidRS => instructionFD_instructOut(25 DOWNTO 21),
    ifidRT => instructionFD_instructOut(20 DOWNTO 16),
    stallSig => stallSig,
    ifidWrite => ifidWrite,
    PCWrite => PCWrite
  );
  --*************************************************************************************************
  -- ASSIGNMENTS:
  ---------------------------------------------------------------------------------------------------
  -- ALU Assignments
  --func     <= instruction_out_sig(5 downto 0);
  opcode <= instructionFD_instructOut(31 DOWNTO 26);
  pc_out <= PC_out_sig;
  WB_writeData <= to_writeData_sig; -- write back data
  MEMWB_dataMemory_out <= instructionMW_memReadData; -- data memory output
  MEMWB_writeReg_sel <= instructionMW_registerInfo;
  ALU_operation <= Operation;
  MEMWB_regWrite <= instructionMW_regWrite;
  branchEnable <= branch_and_zero_signal;
  instructionOUT <= instruction_out_sig;
  instructionDE_readData2_probe <= instructionDE_readData2;
  instructionDE_readData1_probe <= instructionDE_readData1;
  instructionDE_signExtend_probe <= instructionDE_signExtend;
  forwardAval <= forwardA;
  forwardBval <= forwardB;
  MEMWB_memToReg <= instructionMW_memToReg;
  stallBit <= stallSig;
  -----------------------------------------------------------------------------------------------
END ARCHITECTURE;