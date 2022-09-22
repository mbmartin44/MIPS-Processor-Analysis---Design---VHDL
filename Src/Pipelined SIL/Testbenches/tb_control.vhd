LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY control_tb IS
END;

ARCHITECTURE bench OF control_tb IS

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
      RegWrite : OUT STD_LOGIC
    );
  END COMPONENT;

  -- Clock period
  CONSTANT clk_period : TIME := 5 ns;
  -- Generics

  -- Ports
  SIGNAL opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL RegDst : STD_LOGIC;
  SIGNAL Branch : STD_LOGIC;
  SIGNAL MemRead : STD_LOGIC;
  SIGNAL MemWrite : STD_LOGIC;
  SIGNAL MemtoReg : STD_LOGIC;
  SIGNAL ALUOp : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL ALUSrc : STD_LOGIC;
  SIGNAL RegWrite : STD_LOGIC;

BEGIN

  control_inst : control
  PORT MAP(
    opcode => opcode,
    RegDst => RegDst,
    Branch => Branch,
    MemRead => MemRead,
    MemWrite => MemWrite,
    MemtoReg => MemtoReg,
    ALUOp => ALUOp,
    ALUSrc => ALUSrc,
    RegWrite => RegWrite
  );

  DUT : PROCESS
  BEGIN
    opcode <= "00000";
    WAIT FOR 10 ns;
    opcode <= "100011";
    WAIT FOR 10 ns;
    opcode <= "101011";
    WAIT FOR 10 ns;
    opcode <= "000100";
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