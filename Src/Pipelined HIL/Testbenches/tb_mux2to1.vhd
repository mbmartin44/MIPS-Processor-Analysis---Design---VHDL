LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux2to1_tb IS
END;

ARCHITECTURE bench OF mux2to1_tb IS

  COMPONENT mux2to1
    PORT (
      A0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      A1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      sel : IN STD_LOGIC;
      F : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;

  -- Clock period
  CONSTANT clk_period : TIME := 5 ns;
  -- Generics

  -- Ports
  SIGNAL A0 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '1');
  SIGNAL A1 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
  SIGNAL sel : STD_LOGIC := '1';
  SIGNAL F : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

  mux2to1_inst : mux2to1
  PORT MAP(
    A0 => A0,
    A1 => A1,
    sel => sel,
    F => F
  );

  DUT : PROCESS
  BEGIN
    WAIT FOR 10 ns;
    sel <= '0';
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