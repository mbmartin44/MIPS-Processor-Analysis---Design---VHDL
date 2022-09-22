-- Shift Left 2 << COMPONENT FILE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- needed arithmetic operations

entity shift_left_2 is
  port (
    in_data : in std_logic_vector(31 downto 0);
    out_data : out std_logic_vector(31 downto 0)
  );
end entity;
architecture rtl of shift_left_2 is
begin
    out_data <= in_data(29 downto 0) & "00";
end architecture;