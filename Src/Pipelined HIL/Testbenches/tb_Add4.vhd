LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Add4_tb IS
END;

ARCHITECTURE bench OF Add4_tb IS

  COMPONENT Add4
    PORT (
      ALU_in0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      ALU_in1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      ALU_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      zero : OUT STD_LOGIC
    );
  END COMPONENT;

  -- Clock period
  CONSTANT clk_period : TIME := 5 ns;
  -- Generics

  -- Ports
  SIGNAL ALU_in0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ALU_in1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ALU_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL zero : STD_LOGIC;

BEGIN

  Add4_inst : Add4
  PORT MAP(
    ALU_in0 => ALU_in0,
    ALU_in1 => ALU_in1,
    ALU_out => ALU_out,
    zero => zero
  );

  --   clk_process : process
  --   begin
  --   clk <= '1';
  --   wait for clk_period/2;
  --   clk <= '0';
  --   wait for clk_period/2;
  --   end process clk_process;

END;