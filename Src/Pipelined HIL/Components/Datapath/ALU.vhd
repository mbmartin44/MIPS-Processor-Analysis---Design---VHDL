-- ALU COMPONENT FILE
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL; -- needed arithmetic operations

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
ENTITY ALU IS -- 2 to 1 multiplexer
    PORT (
        ALU_in0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_in1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_cntl : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        ALU_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        zero : OUT STD_LOGIC
    );
END ENTITY;
-----------------------------------------------------------------------------------------------------------------
ARCHITECTURE ALU_arch OF ALU IS
    SIGNAL ALU_result : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (ALU_in0, ALU_in1, ALU_cntl)
    BEGIN
        CASE ALU_cntl IS
            WHEN "0000" => -- Bitwise AND----------------------------------------------------
                ALU_result <= ALU_in0 AND ALU_in1;
            WHEN "0001" => -- Bitwise OR----------------------------------------------------
                ALU_result <= ALU_in0 OR ALU_in1;
            WHEN "0010" => -- Addition------------------------------------------------------
                ALU_result <= STD_LOGIC_VECTOR(unsigned(ALU_in0) + unsigned(ALU_in1));
            WHEN "0110" => -- Subtraction----------------------------------------------------
                ALU_result <= STD_LOGIC_VECTOR(unsigned(ALU_in0) - unsigned(ALU_in1));
            WHEN "0111" => -- Set Less than--------------------------------------------------
                IF (ALU_in1 < ALU_in0) THEN
                    ALU_result <= x"00000001";
                ELSE
                    ALU_result <= (OTHERS => '0');
                END IF;
            WHEN "1100" => -- Logical NOR----------------------------------------------------
                ALU_result <= ALU_in0 NOR ALU_in1;

            WHEN OTHERS => NULL; -- nop
                ALU_result <= (OTHERS => '0');
        END CASE;
    END PROCESS;

    --Concurrent Code:
    ALU_out <= ALU_result;
    PROCESS (ALU_result)
    BEGIN
        IF (to_integer(unsigned(ALU_result)) = 0) THEN
            zero <= '1';
        ELSE
            zero <= '0';
        END IF;
    END PROCESS;

END ARCHITECTURE;

-----------------------------------------------------------------
-- END OF ALU COMPONENT FILE