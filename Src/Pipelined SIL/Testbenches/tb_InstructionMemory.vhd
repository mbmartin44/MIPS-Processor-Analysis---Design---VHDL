library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemory_tb is
end;

architecture bench of InstructionMemory_tb is

  component InstructionMemory
      port (
      address : in STD_LOGIC_VECTOR (7 DOWNTO 0);
      clock : in STD_LOGIC;
      data : in STD_LOGIC_VECTOR (31 DOWNTO 0);
      wren : in STD_LOGIC;
      q : out STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
  end component;

  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics

  -- Ports
  signal address : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
  signal clock : STD_LOGIC := '0';
  signal data : STD_LOGIC_VECTOR (31 DOWNTO 0);
  signal wren : STD_LOGIC := '0';
  signal q : STD_LOGIC_VECTOR (31 DOWNTO 0);

begin

  InstructionMemory_inst : InstructionMemory
    port map (
      address => address,
      clock => clock,
      data => data,
      wren => wren,
      q => q
    );


    DUT : process (all)
    begin
       clock <= '1';
       wait for 10 ns;
       address <= std_logic_vector(to_integer(4));
       clock <= '0';
       wait for 10 ns;
       clock <= '1';
       wait for 10 ns;
       address <= std_logic_vector(to_integer(8));
       clock <= '0';
       wait for 10 ns;
       clock <= '1';
       wait;
    end process;
--   clk_process : process
--   begin
--   clk <= '1';
--   wait for clk_period/2;
--   clk <= '0';
--   wait for clk_period/2;
--   end process clk_process;

end;
