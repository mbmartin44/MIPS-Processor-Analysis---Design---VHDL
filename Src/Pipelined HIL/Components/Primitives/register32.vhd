library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register32 is
    port (
      C : in std_logic;
      clk : in std_logic;
      D : in std_logic_vector(31 downto 0);
      Q : out std_logic_vector(31 downto 0) 
    );
end entity;

architecture behavioral of register32 is
begin
    process(clk)
    begin
        if(rising_edge(clk) and C = '1') then
            Q <= D;
        end if;
    end process;
end behavioral;