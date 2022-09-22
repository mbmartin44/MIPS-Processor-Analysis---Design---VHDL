-- Package for use in MIPS Processor Implementation Project
library IEEE;
use IEEE.std_logic_1164.all;
---------------------------------------------------------------------------------------------------------------
-- |Instruction OPCode| ALUop | Instruction Operation | Funct Field | Desired ALU action | ALU control input  |
-- |    LW            | 00    |    Load Word          |  XXXXXX     |        add         |     "0010"         |
-- |    SW            | 00    |    Store Word         |  XXXXXX     |        add         |     "0010"         |
-- |    Beq           | 01    |    Branch Equal       |  XXXXXX     |        sub         |     "0110"         |
-- |    R-type        | 10    |    add                |  100000     |        add         |     "0010"         | 
-- |    R-type        | 10    |    sub                |  100010     |        sub         |     "0110"         | 
-- |    R-type        | 10    |    and                |  100100     |        and         |     "0000"         |
-- |    R-type        | 10    |    or                 |  100101     |        or          |     "0001"         |
-- |    R-type        | 10    |    nor                |  100111     |        nor         |     "1100"         |
-- |    R-type        | 10    |    slt                |  101010     |        slt         |     "0111"         |
--------------------------------------------------------------------------------------------------------------
entity ALUControl is -- 2 to 1 multiplexer
    port(  
        func      : in std_logic_vector(5 downto 0);
        ALUop     : in std_logic_vector(1 downto 0);
        Operation : out std_logic_vector(3 downto 0)
    );
end entity;
------------------------------------------------------------------
architecture ALUControl_Arch of ALUControl is
begin
    process(ALUop, func)
    begin 
        if(ALUop = "00")  then Operation <= "0010";             -- LW  and SW  
        elsif(ALUop = "01") then Operation <= "0010";           -- Beq
        
        elsif(ALUop = "10") then                                -- R-type
            if(func = "100000") then Operation <= "0010";       -- add
            elsif(func = "100010") then Operation <= "0110";    -- sub
            elsif(func = "100100") then Operation <= "0000";    -- and
            elsif(func = "100101") then Operation <= "0001";    -- or
            elsif(func = "100111") then Operation <= "1100";    -- nor
            elsif(func = "101010") then Operation <= "0111";    -- slt
            else Operation <= "0000";
            end if;
        else Operation <= "0000";
        end if;
    end process;
end architecture;
------------------------------------------------------------------
-- END OF MUX2 COMPONENT FILE