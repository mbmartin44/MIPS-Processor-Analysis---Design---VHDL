LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY registers_tb IS
END;

ARCHITECTURE bench OF registers_tb IS

  COMPONENT registerFile
    PORT (
      readreg1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      readreg2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      writeReg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      clk : IN STD_LOGIC;
      RegWrite : IN STD_LOGIC;
      readData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;

  -- Clock period
  CONSTANT clk_period : TIME := 5 ns;
  -- Generics

  -- Ports
  SIGNAL readreg1 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
  SIGNAL readreg2 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00001";
  SIGNAL writeReg : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00001";
  SIGNAL writeData : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000010";
  SIGNAL RegWrite : STD_LOGIC := '0';
  SIGNAL readData1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL readData2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL clk : STD_LOGIC := '0';

BEGIN

  registers_inst : registerFile
  PORT MAP(
    readreg1 => readreg1,
    readreg2 => readreg2,
    writeReg => writeReg,
    writeData => writeData,
    RegWrite => RegWrite,
    clk => clk,
    readData1 => readData1,
    readData2 => readData2
  );

  DUT : PROCESS
  BEGIN
    WAIT FOR 5 ns;
    RegWrite <= '1';
    clk <= '1';
    WAIT FOR 5 ns;
    clk <= '0';
    RegWrite <= '0';
    readreg2 <= "00010";
    writeReg <= "00010";
    WAIT FOR 5 ns;
    -- writeReg <= "00010";
    --readreg2 <= "00010";
    RegWrite <= '1';
    clk <= '1';
    WAIT FOR 5 ns;
    RegWrite <= '0';
    clk <= '0';
    WAIT;
  END PROCESS;
  --   clk_process : process
  --   begin
  --   clk <= '1';
  --   wait for clk_period/2;
  --   clk <= '0';
  --   wait for clk_period/2;
  --   end process clk_process;

END bench;