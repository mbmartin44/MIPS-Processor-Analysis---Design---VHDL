LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decoder_tb IS
END;

ARCHITECTURE bench OF decoder_tb IS

  COMPONENT decoder
    PORT (
      A : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      F : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;

  -- Clock period
  CONSTANT clk_period : TIME := 5 ns;
  -- Generics

  -- Ports
  SIGNAL A : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL F : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

  decoder_inst : decoder
  PORT MAP(
    A => A,
    F => F
  );
  DUT : PROCESS
  BEGIN
    FOR i IN 0 TO 31 LOOP
      A <= STD_LOGIC_VECTOR(unsigned(i));
      WAIT FOR 5 ns;
    END LOOP;
    WAIT;
  END PROCESS;

END bench;