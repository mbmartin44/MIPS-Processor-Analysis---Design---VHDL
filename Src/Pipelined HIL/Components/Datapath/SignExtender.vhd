-- Package for use in MIPS Processor Implementation Project
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
------------------------------------------------------------------
ENTITY signExtender IS -- 2 to 1 multiplexer
    PORT (
        signExtendIn : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        signExtendOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;
------------------------------------------------------------------
ARCHITECTURE signExtenderArchitecture OF signExtender IS
BEGIN
    extendSign : PROCESS (signExtendIn)
    BEGIN
        IF signExtendIn(15) = '0' THEN
            signExtendOut <= x"0000" & signExtendIn;
        ELSE
            signExtendOut <= x"FFFF" & signExtendIn;
        END IF;
    END PROCESS;
END ARCHITECTURE;
------------------------------------------------------------------
-- END OF SignExtender COMPONENT FILE