library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2to1_tb is
end;

architecture bench of mux2to1_tb is

  component mux2to1
      port (
      A0 : in std_logic_vector(31 downto 0);
      A1 : in std_logic_vector(31 downto 0);
      sel : in std_logic;
      F : out std_logic_vector(31 downto 0)
    );
  end component;

  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics

  -- Ports
  signal A0 : std_logic_vector(31 downto 0) := (others =>'1');
  signal A1 : std_logic_vector(31 downto 0) := (others=>'0');
  signal sel : std_logic := '1';
  signal F : std_logic_vector(31 downto 0);

begin

  mux2to1_inst : mux2to1
    port map (
      A0 => A0,
      A1 => A1,
      sel => sel,
      F => F
    );

DUT: process
begin
    wait for 10 ns;
    sel <= '0';
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
