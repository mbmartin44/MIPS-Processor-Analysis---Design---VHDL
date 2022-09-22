LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY InstructionMemory_tb IS
END;

ARCHITECTURE bench OF InstructionMemory_tb IS

  COMPONENT InstructionMemory
    PORT (
      address : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      clock : IN STD_LOGIC;
      data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      wren : IN STD_LOGIC;
      q : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
  END COMPONENT;

  -- Clock period
  CONSTANT clk_period : TIME := 5 ns;
  -- Generics

  -- Ports
  SIGNAL address : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
  SIGNAL clock : STD_LOGIC := '0';
  SIGNAL data : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL wren : STD_LOGIC := '0';
  SIGNAL q : STD_LOGIC_VECTOR (31 DOWNTO 0);

BEGIN

  InstructionMemory_inst : InstructionMemory
  PORT MAP(
    address => address,
    clock => clock,
    data => data,
    wren => wren,
    q => q
  );
  DUT : PROCESS (ALL)
  BEGIN
    clock <= '1';
    WAIT FOR 10 ns;
    address <= STD_LOGIC_VECTOR(to_integer(4));
    clock <= '0';
    WAIT FOR 10 ns;
    clock <= '1';
    WAIT FOR 10 ns;
    address <= STD_LOGIC_VECTOR(to_integer(8));
    clock <= '0';
    WAIT FOR 10 ns;
    clock <= '1';
    WAIT;
  END PROCESS;
  --   clk_process : process
  --   begin
  --   clk <= '1';
  --   wait for clk_period/2;
  --   clk <= '0';
  --   wait for clk_period/2;
  --   end process clk_process;

END;