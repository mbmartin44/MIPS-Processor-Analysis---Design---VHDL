library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and2c is
    port (
        A : in std_logic;
        B : in std_logic;
        F : out std_logic
    );
end entity;

architecture structural of and2c is
begin
    F <= A and B;
end structural;