LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_level_tb IS
END;

ARCHITECTURE bench OF top_level_tb IS

  COMPONENT top_level
    PORT (
      clk : IN STD_LOGIC;
      to_writeData_sig_probe : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
      HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      LED : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
  END COMPONENT;

  -- Clock period
  CONSTANT clk_period : TIME := 5 ns;
  -- Generics

  -- Ports
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL to_writeData_sig_probe : STD_LOGIC_VECTOR(23 DOWNTO 0);
  SIGNAL HEX0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL HEX1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL HEX2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL HEX3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL HEX4 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL HEX5 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL LED : STD_LOGIC_VECTOR(9 DOWNTO 0);

BEGIN

  top_level_inst : top_level
  PORT MAP(
    clk => clk,
    to_writeData_sig_probe => to_writeData_sig_probe,
    HEX0 => HEX0,
    HEX1 => HEX1,
    HEX2 => HEX2,
    HEX3 => HEX3,
    HEX4 => HEX4,
    HEX5 => HEX5,
    LED => LED
  );

  clk_process : PROCESS
  BEGIN
    clk <= '0';
    WAIT FOR clk_period / 2;
    FOR i IN 0 TO 50 LOOP
      clk <= NOT clk;
      WAIT FOR clk_period / 2;
    END LOOP; -- clock loop
    WAIT;
  END PROCESS clk_process;
END;