LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY forward IS
    PORT (
        idexRT : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        idexRS : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        exmemRD : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        memwbRD : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        exmemRegWrite : IN STD_LOGIC;
        memwbRegWrite : IN STD_LOGIC;

        forwardA : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        forwardB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF forward IS
BEGIN
    PROCESS (ALL)
    BEGIN
        --Default Vals
        forwardA <= "00";
        forwardB <= "00";
        --EX Forward Unit
        IF ((exmemRegWrite = '1') AND (to_integer(unsigned(exmemRD)) /= 0) AND (exmemRD = idexRS)) THEN
            forwardA <= "10";
        END IF;

        IF ((exmemRegWrite = '1') AND (to_integer(unsigned(exmemRD)) /= 0) AND (exmemRD = idexRT)) THEN
            forwardB <= "10";
        END IF;

        --Mem Forward Unit
        IF ((memwbRegWrite = '1') AND (to_integer(unsigned(memwbRD)) /= 0) AND (exmemRD /= idexRS) AND (memwbRD = idexRS)) THEN
            forwardA <= "01";
        END IF;

        IF ((memwbRegWrite = '1') AND (to_integer(unsigned(memwbRD)) /= 0) AND (exmemRD /= idexRT) AND (memwbRD = idexRT)) THEN
            forwardB <= "01";
        END IF;
    END PROCESS;
END ARCHITECTURE rtl;