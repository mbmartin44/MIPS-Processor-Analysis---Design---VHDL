library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Add4_tb is
end;

architecture bench of Add4_tb is

  component Add4
      port (
      ALU_in0 : in std_logic_vector(31 downto 0);
      ALU_in1 : in std_logic_vector(31 downto 0);
      ALU_out : out std_logic_vector(31 downto 0);
      zero : out std_logic
    );
  end component;

  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics

  -- Ports
  signal ALU_in0 : std_logic_vector(31 downto 0);
  signal ALU_in1 : std_logic_vector(31 downto 0);
  signal ALU_out : std_logic_vector(31 downto 0);
  signal zero : std_logic;

begin

  Add4_inst : Add4
    port map (
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

end;
