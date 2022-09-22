LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY hazardUnit IS
    PORT (
        --INPUT PORTS
        idexRT : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        idexMemRead : IN STD_LOGIC;
        ifidRS : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        ifidRT : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        --OUTPUT PORTS
        stallSig : OUT STD_LOGIC;
        ifidWrite : OUT STD_LOGIC;
        PCWrite : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF hazardUnit IS
BEGIN
    PROCESS (ALL)
    BEGIN
        IF (idexMemRead = '1' AND ((idexRT = ifidRS) OR (idexRT = ifidRT))) THEN
            stallSig <= '1';
            ifidWrite <= '0';
            PCWrite <= '0';
        ELSE
            stallSig <= '0';
            ifidWrite <= '1';
            PCWrite <= '1';
        END IF;
    END PROCESS;
END ARCHITECTURE rtl;