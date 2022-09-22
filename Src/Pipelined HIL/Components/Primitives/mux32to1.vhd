library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux32to1 is
    port(
        IN1 : in std_logic_vector(31 downto 0);
        IN2 : in std_logic_vector(31 downto 0);
        IN3 : in std_logic_vector(31 downto 0);
        IN4 : in std_logic_vector(31 downto 0);
        IN5 : in std_logic_vector(31 downto 0);
        IN6 : in std_logic_vector(31 downto 0);
        IN7 : in std_logic_vector(31 downto 0);
        IN8 : in std_logic_vector(31 downto 0);
        IN9 : in std_logic_vector(31 downto 0);
        IN10 : in std_logic_vector(31 downto 0);
        IN11 : in std_logic_vector(31 downto 0);
        IN12 : in std_logic_vector(31 downto 0);
        IN13 : in std_logic_vector(31 downto 0);
        IN14 : in std_logic_vector(31 downto 0);
        IN15 : in std_logic_vector(31 downto 0);
        IN16 : in std_logic_vector(31 downto 0);
        IN17 : in std_logic_vector(31 downto 0);
        IN18 : in std_logic_vector(31 downto 0);
        IN19 : in std_logic_vector(31 downto 0);
        IN20 : in std_logic_vector(31 downto 0);
        IN21 : in std_logic_vector(31 downto 0);
        IN22 : in std_logic_vector(31 downto 0);
        IN23 : in std_logic_vector(31 downto 0);
        IN24 : in std_logic_vector(31 downto 0);
        IN25 : in std_logic_vector(31 downto 0);
        IN26 : in std_logic_vector(31 downto 0);
        IN27 : in std_logic_vector(31 downto 0);
        IN28 : in std_logic_vector(31 downto 0);
        IN29 : in std_logic_vector(31 downto 0);
        IN30 : in std_logic_vector(31 downto 0);
        IN31 : in std_logic_vector(31 downto 0);
        IN32 : in std_logic_vector(31 downto 0);
        sel  : in std_logic_vector(4 downto 0);
        F : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavioral of mux32to1 is
begin
    process(sel)
    begin
        F <= IN1;
        case sel is
            when "00000" => F <= IN1;
            when "00001" => F <= IN2;
            when "00010" => F <= IN3;
            when "00011" => F <= IN4;
            when "00100" => F <= IN5;
            when "00101" => F <= IN6;
            when "00110" => F <= IN7;
            when "00111" => F <= IN8;
            when "01000" => F <= IN9;
            when "01001" => F <= IN10;
            when "01010" => F <= IN11;
            when "01011" => F <= IN12;
            when "01100" => F <= IN13;
            when "01101" => F <= IN14;
            when "01110" => F <= IN15;
            when "01111" => F <= IN16;
            when "10000" => F <= IN17;
            when "10001" => F <= IN18;
            when "10010" => F <= IN19;
            when "10011" => F <= IN20;
            when "10100" => F <= IN21;
            when "10101" => F <= IN22;
            when "10110" => F <= IN23;
            when "10111" => F <= IN24;
            when "11000" => F <= IN25;
            when "11001" => F <= IN26;
            when "11010" => F <= IN27;
            when "11011" => F <= IN28;
            when "11100" => F <= IN29;
            when "11101" => F <= IN30;
            when "11110" => F <= IN31;
            when "11111" => F <= IN32;
            when others => F <= IN1;
        end case;
    end process;
end behavioral;
