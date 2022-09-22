library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_tb is
end;

architecture bench of control_tb is

  component control
      port (
      opcode : in std_logic_vector(5 downto 0);
      RegDst : out std_logic;
      Branch : out std_logic;
      MemRead : out std_logic;
      MemWrite : out std_logic;
      MemtoReg : out std_logic;
      ALUOp : out std_logic_vector(1 downto 0);
      ALUSrc : out std_logic;
      RegWrite : out std_logic
    );
  end component;

  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics

  -- Ports
  signal opcode : std_logic_vector(5 downto 0);
  signal RegDst : std_logic;
  signal Branch : std_logic;
  signal MemRead : std_logic;
  signal MemWrite : std_logic;
  signal MemtoReg : std_logic;
  signal ALUOp : std_logic_vector(1 downto 0);
  signal ALUSrc : std_logic;
  signal RegWrite : std_logic;

begin

  control_inst : control
    port map (
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

DUT: process
begin
    opcode <= "00000";
    wait for 10 ns;
    opcode <= "100011";
    wait for 10 ns;
    opcode <= "101011";
    wait for 10 ns;
    opcode <= "000100";
    wait;
end process;
--   clk_process : process
--   begin
--   clk <= '1';
--   wait for clk_period/2;
--   clk <= '0';
--   wait for clk_period/2;
--   end process clk_process;

end bench;
