-- Package for use in MIPS Processor Implementation Project
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
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
ENTITY ALUControl IS -- 2 to 1 multiplexer
    PORT (
        func : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        ALUop : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Operation : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;
------------------------------------------------------------------
ARCHITECTURE ALUControl_Arch OF ALUControl IS
BEGIN
    PROCESS (ALUop, func)
    BEGIN
        IF (ALUop = "00") THEN
            Operation <= "0010"; -- LW  and SW
        ELSIF (ALUop = "01") THEN
            Operation <= "0010"; -- Beq

        ELSIF (ALUop = "10") THEN -- R-type
            IF (func = "100000") THEN
                Operation <= "0010"; -- add
            ELSIF (func = "100010") THEN
                Operation <= "0110"; -- sub
            ELSIF (func = "100100") THEN
                Operation <= "0000"; -- and
            ELSIF (func = "100101") THEN
                Operation <= "0001"; -- or
            ELSIF (func = "100111") THEN
                Operation <= "1100"; -- nor
            ELSIF (func = "101010") THEN
                Operation <= "0111"; -- slt
            ELSE
                Operation <= "0000";
            END IF;
        ELSE
            Operation <= "0000";
        END IF;
    END PROCESS;
END ARCHITECTURE;
------------------------------------------------------------------
-- END OF MUX2 COMPONENT FILE