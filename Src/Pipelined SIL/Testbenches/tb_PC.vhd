library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_tb is
end;

architecture bench of PC_tb is

  component PC
      port (
      clk : in std_logic;
      load_address : in std_logic_vector(31 downto 0);
      current_address : out std_logic_vector(31 downto 0)
    );
  end component;

  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics

  -- Ports
  signal clk : std_logic;
  signal load_address : std_logic_vector(31 downto 0);
  signal current_address : std_logic_vector(31 downto 0);

begin

  PC_inst : PC
    port map (
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

end;
