library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_tb is
end;

architecture bench of top_level_tb is

  component top_level
      port (
      clk : in std_logic;
      branchEnable : out std_logic;
      pc_out : out std_logic_vector(31 downto 0);
      instructionOUT : out std_logic_vector(31 downto 0);
     -- instruction : out std_logic_vector(31 downto 0);
      MEMWB_dataMemory_out : out std_logic_vector(31 downto 0);
      stallBit : out std_logic;
      --EXMEM_dataMemWriteEnable : out std_logic;
      --EXMEM_dataMemWriteData : out std_logic_vector(31 downto 0);
      WB_writeData : out std_logic_vector(31 downto 0);
      --EXEC_ALUin2 : out std_logic_vector(31 downto 0);
      --DEx_ALUSrc : out std_logic;
      MEMWB_regWrite : out std_logic;
      --ALUResult : out std_logic_vector(31 downto 0);
      --EXMEM_ALUResult : out std_logic_vector(31 downto 0);
     -- MEMWB_ALUResult : out std_logic_vector(31 downto 0);
      ALU_operation : out std_logic_vector(3 downto 0);
      MEMWB_writeReg_sel : out std_logic_vector(4 downto 0);
      MEMWB_memToReg : out std_logic;
      --instructionDE_RT_probe : out std_logic_vector(4 downto 0);
      --instructionFD_RS_probe          : out std_logic_vector(4 downto 0);
      --instructionFD_RT_probe          : out std_logic_vector(4 downto 0);
      --instructionDE_memRead_probe     : out std_logic;
      instructionDE_readData1_probe : out std_logic_vector(31 downto 0);
      instructionDE_readData2_probe : out std_logic_vector(31 downto 0);
      instructionDE_signExtend_probe : out std_logic_vector(31 downto 0);
      --instructionDE_RD_probe : out std_logic_vector(4 downto 0);
      --instructionEM_branch_probe : out std_logic;
      --instructionEM_registerInfo_probe : out std_logic_vector(4 downto 0);
      forwardAval : out std_logic_vector(1 downto 0);
      forwardBval : out std_logic_vector(1 downto 0)
    );
  end component;

  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics

  -- Ports
  signal clk : std_logic := '0';
  signal branchEnable : std_logic;
  signal pc_out : std_logic_vector(31 downto 0);
  --signal instruction : std_logic_vector(31 downto 0);
  signal MEMWB_dataMemory_out : std_logic_vector(31 downto 0);
  signal stallBit : std_logic;
  --signal EXMEM_dataMemWriteEnable : std_logic;
  --signal EXMEM_dataMemWriteData : std_logic_vector(31 downto 0);
  signal WB_writeData : std_logic_vector(31 downto 0);
 -- signal EXEC_ALUin2 : std_logic_vector(31 downto 0);
  --signal DEx_ALUSrc : std_logic;
  signal MEMWB_regWrite : std_logic;
 -- signal ALUResult : std_logic_vector(31 downto 0);
 -- signal EXMEM_ALUResult : std_logic_vector(31 downto 0);
 -- signal MEMWB_ALUResult : std_logic_vector(31 downto 0);
  signal ALU_operation : std_logic_vector(3 downto 0);
  signal MEMWB_writeReg_sel : std_logic_vector(4 downto 0);
  signal MEMWB_memToReg : std_logic;
  signal instructionOUT : std_logic_vector(31 downto 0);
  --signal instructionDE_RT_probe : std_logic_vector(4 downto 0);
  --signal instructionFD_RS_probe : std_logic_vector(4 downto 0);
  --signal instructionFD_RT_probe : std_logic_vector(4 downto 0);
  --signal instructionDE_memRead_probe : std_logic;
  signal instructionDE_readData1_probe : std_logic_vector(31 downto 0);
  signal instructionDE_readData2_probe : std_logic_vector(31 downto 0);
  signal instructionDE_signExtend_probe : std_logic_vector(31 downto 0);
 -- signal instructionDE_RD_probe : std_logic_vector(4 downto 0);
  --signal instructionEM_branch_probe : std_logic;
  --signal instructionEM_registerInfo_probe : std_logic_vector(4 downto 0);
  signal forwardAval : std_logic_vector(1 downto 0);
  signal forwardBval : std_logic_vector(1 downto 0);

begin

  top_level_inst : top_level
    port map (
      clk => clk,
      branchEnable => branchEnable,
      pc_out => pc_out,
      instructionOUT => instructionOUT,
      --instruction => instruction,
      MEMWB_dataMemory_out => MEMWB_dataMemory_out,
      stallBit => stallBit,
      --EXMEM_dataMemWriteEnable => EXMEM_dataMemWriteEnable,
      --EXMEM_dataMemWriteData => EXMEM_dataMemWriteData,
      WB_writeData => WB_writeData,
     -- EXEC_ALUin2 => EXEC_ALUin2,
      --DEx_ALUSrc => DEx_ALUSrc,
      MEMWB_regWrite => MEMWB_regWrite,
     -- ALUResult => ALUResult,
     -- EXMEM_ALUResult => EXMEM_ALUResult,
      --MEMWB_ALUResult => MEMWB_ALUResult,
      ALU_operation => ALU_operation,
      MEMWB_writeReg_sel => MEMWB_writeReg_sel,
      MEMWB_memToReg => MEMWB_memToReg,
      --instructionDE_RT_probe => instructionDE_RT_probe,
      --instructionFD_RS_probe => instructionFD_RS_probe,
      --instructionFD_RT_probe => instructionFD_RT_probe,
      --instructionDE_memRead_probe => instructionDE_memRead_probe,
      instructionDE_readData1_probe => instructionDE_readData1_probe,
      instructionDE_readData2_probe => instructionDE_readData2_probe,
      instructionDE_signExtend_probe => instructionDE_signExtend_probe,
      --instructionDE_RD_probe => instructionDE_RD_probe,
      --instructionEM_branch_probe => instructionEM_branch_probe,
      --instructionEM_registerInfo_probe => instructionEM_registerInfo_probe,
      forwardAval => forwardAval,
      forwardBval => forwardBval
    );

    clk_process : process
    begin
     wait for clk_period / 2;
     for i in 0 to 40 loop
       clk <= not clk;
       wait for clk_period / 2;
     end loop; -- clock loop
       wait;
    end process clk_process;
 
 end bench;