-- 32 bit decoder
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
    port (
        A : in std_logic_vector(4 downto 0);
        F : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavioral of decoder is
begin
    process(A)
    begin
        F <= (others => '0');
        case A is
            when "00000" => F(0) <= '1';
            when "00001" => F(1) <= '1';
            when "00010" => F(2) <= '1';
            when "00011" => F(3) <= '1';
            when "00100" => F(4) <= '1';
            when "00101" => F(5) <= '1';
            when "00110" => F(6) <= '1';
            when "00111" => F(7) <= '1';
            when "01000" => F(8) <= '1';
            when "01001" => F(9) <= '1';
            when "01010" => F(10) <= '1';
            when "01011" => F(11) <= '1';
            when "01100" => F(12) <= '1';
            when "01101" => F(13) <= '1';
            when "01110" => F(14) <= '1';
            when "01111" => F(15) <= '1';
            when "10000" => F(16) <= '1';
            when "10001" => F(17) <= '1';
            when "10010" => F(18) <= '1';
            when "10011" => F(19) <= '1';
            when "10100" => F(20) <= '1';
            when "10101" => F(21) <= '1';
            when "10110" => F(22) <= '1';
            when "10111" => F(23) <= '1';
            when "11000" => F(24) <= '1';
            when "11001" => F(25) <= '1';
            when "11010" => F(26) <= '1';
            when "11011" => F(27) <= '1';
            when "11100" => F(28) <= '1';
            when "11101" => F(29) <= '1';
            when "11110" => F(30) <= '1';
            when "11111" => F(31) <= '1';
            when others => F <= (others => '0');
        end case;
    end process;
end behavioral;
