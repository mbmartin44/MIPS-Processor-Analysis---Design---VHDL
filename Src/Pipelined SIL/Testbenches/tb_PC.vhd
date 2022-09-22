LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY PC_tb IS
END;

ARCHITECTURE bench OF PC_tb IS

  COMPONENT PC
    PORT (
      clk : IN STD_LOGIC;
      load_address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      current_address : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;

  -- Clock period
  CONSTANT clk_period : TIME := 5 ns;
  -- Generics

  -- Ports
  SIGNAL clk : STD_LOGIC;
  SIGNAL load_address : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL current_address : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

  PC_inst : PC
  PORT MAP(
    clk => clk,
    load_address => load_address,
    current_address => current_address
  );

  --   clk_process : process
  --   begin
  --   clk <= '1';
  --   wait for clk_period/2;
  --   clk <= '0';
  --   wait for clk_period/2;
  --   end process clk_process;

END;