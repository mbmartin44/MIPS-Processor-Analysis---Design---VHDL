library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_tb is
end;

architecture bench of decoder_tb is

  component decoder
      port (
      A : in std_logic_vector(4 downto 0);
      F : out std_logic_vector(31 downto 0)
    );
  end component;

  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics

  -- Ports
  signal A : std_logic_vector(4 downto 0);
  signal F : std_logic_vector(31 downto 0);

begin

  decoder_inst : decoder
    port map (
      A => A,
      F => F
    );


DUT: process
begin
for i in 0 to 31 loop
    A <= std_logic_vector(unsigned(i));
    wait for 5 ns;
end loop;
wait;
end process;

end bench;
