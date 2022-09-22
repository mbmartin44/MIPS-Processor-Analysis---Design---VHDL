library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2to1 is
    port (
        A0 : in std_logic_vector(31 downto 0);
        A1 : in std_logic_vector(31 downto 0);
        sel : in std_logic;
        F  : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavioral of mux2to1 is
begin
    process(sel,A0,A1)
    begin
        if (sel = '0') then
            F <= A0;
        else
            F <= A1;
        end if;
    end process;
end behavioral;