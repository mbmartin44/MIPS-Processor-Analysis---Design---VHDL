-- Package for use in MIPS Processor Implementation Project
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
------------------------------------------------------------------
entity mux32_3to1 is
    generic (
        N: integer := 32
    );
    port (
        A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        C: in std_logic_vector(31 downto 0);
        S: in std_logic_vector(1 downto 0);
        Y: out std_logic_vector(31 downto 0)
    );
end entity;

architecture BEHAVIORAL of mux32_3to1 is
    begin 
    process(A,B,C,S)
    begin 
        case S is
            when "00" => Y <= A;
            when "01" => Y <= B;
            when "10" => Y <= C;
            when others => Y <= A;
        end case;
    end process;
end behavioral;
    

