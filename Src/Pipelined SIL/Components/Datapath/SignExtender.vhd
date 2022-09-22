-- Package for use in MIPS Processor Implementation Project
library IEEE;
use IEEE.std_logic_1164.all;
------------------------------------------------------------------
entity signExtender is -- 2 to 1 multiplexer
    port(  
            signExtendIn  : in std_logic_vector(15 downto 0);
            signExtendOut : out std_logic_vector(31 downto 0)
    );
end entity;
------------------------------------------------------------------
architecture signExtenderArchitecture of signExtender is
begin
    extendSign: process(signExtendIn)
    begin
        if signExtendIn(15) = '0' then
            signExtendOut <= x"0000" & signExtendIn;
        else
            signExtendOut <= x"FFFF" & signExtendIn;
        end if;
    end process;
end architecture;
------------------------------------------------------------------
-- END OF SignExtender COMPONENT FILE

--EXTRA*******************************************************************

--Alternative behavioral architecture:
--signExtendOut <= x"0000" & signExtendIn when signExtendIn(15) = '0' else
--               x"FFFF" & signExtendIn;
--************************************************************************