LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_level_tb IS
END;

ARCHITECTURE bench OF top_level_tb IS

  COMPONENT top_level
    PORT (
      clk : IN STD_LOGIC;
      branchEnable : OUT STD_LOGIC;
      pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ReadData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ReadData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      writeData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      EXEC_ALUin2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ALUSrc : OUT STD_LOGIC;
      RegWrite : OUT STD_LOGIC;
      ALU_operation : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      writeReg_sel : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
  END COMPONENT;

  -- Clock period
  CONSTANT clk_period : TIME := 5 ns;
  -- Generics

  -- Ports
  SIGNAL clk : STD_LOGIC;
  SIGNAL branchEnable : STD_LOGIC;
  SIGNAL pc_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ReadData1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ReadData2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL writeData : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL EXEC_ALUin2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ALUSrc : STD_LOGIC;
  SIGNAL RegWrite : STD_LOGIC;
  SIGNAL ALU_operation : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL writeReg_sel : STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN

  top_level_inst : top_level
  PORT MAP(
    clk => clk,
    branchEnable => branchEnable,
    pc_out => pc_out,
    instruction => instruction,
    ReadData1 => ReadData1,
    ReadData2 => ReadData2,
    writeData => writeData,
    EXEC_ALUin2 => EXEC_ALUin2,
    ALUSrc => ALUSrc,
    RegWrite => RegWrite,
    ALU_operation => ALU_operation,
    writeReg_sel => writeReg_sel
  );

  clk_process : PROCESS
  BEGIN
    clk <= '1';
    WAIT FOR clk_period/2;
    clk <= '0';
    WAIT FOR clk_period/2;
    clk <= '1';
    WAIT FOR clk_period/2;
    clk <= '0';
    WAIT FOR clk_period/2;
    clk <= '1';
    WAIT FOR clk_period/2;
    clk <= '0';
    WAIT FOR clk_period/2;
    clk <= '1';
    WAIT FOR clk_period/2;
    clk <= '0';
    WAIT FOR clk_period/2;
    clk <= '1';
    WAIT FOR clk_period/2;
    clk <= '0';
    WAIT FOR clk_period/2;
    clk <= '1';
    WAIT FOR clk_period/2;
    clk <= '0';
    WAIT FOR clk_period/2;
    clk <= '1';
    WAIT FOR clk_period/2;
    clk <= '0';
    WAIT FOR clk_period/2;

  END PROCESS clk_process;

END;