library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instructionFD is
   port (
       ifidWrite : in std_logic;
       clk : in std_logic;
        PCIN : in std_logic_vector(31 downto 0);
        instructionIN : in std_logic_vector(31 downto 0);
        PCOUT : out std_logic_vector(31 downto 0);
        instructionOUT : out std_logic_vector(31 downto 0)
   );
end entity;

architecture rtl of instructionFD is
signal instructionOUTsig : std_logic_vector(31 downto 0) := (others => '0');
signal PCOUTsig : std_logic_vector(31 downto 0) := (others => '0');
begin
process(all)
begin
    PCOUTsig <= PCIN;
    instructionOUTsig <= instructionIN;
    if (rising_edge(clk) and ifidWrite = '1') then
        PCOUT <= PCOUTsig;
        instructionOUT <= instructionOUTsig;
    end if;
end process;
end architecture;