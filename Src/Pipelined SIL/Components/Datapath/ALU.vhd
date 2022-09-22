-- ALU COMPONENT FILE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- needed arithmetic operations

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
entity ALU is -- 2 to 1 multiplexer
    port(  
        ALU_in0   : in std_logic_vector(31 downto 0);
        ALU_in1   : in std_logic_vector(31 downto 0);
        ALU_cntl  : in std_logic_vector(3 downto 0);
        ALU_out   : out std_logic_vector(31 downto 0);
        zero      : out std_logic
    );
end entity;
-----------------------------------------------------------------------------------------------------------------
architecture ALU_arch of ALU is
    signal ALU_result : std_logic_vector(31 downto 0) := (others => '0');
begin
    process(ALU_in0,ALU_in1,ALU_cntl)
    begin 
        case ALU_cntl is
            when "0000" => -- Bitwise AND----------------------------------------------------
                ALU_result <= ALU_in0 AND ALU_in1;
            when "0001" => -- Bitwise OR----------------------------------------------------
                ALU_result <= ALU_in0 OR ALU_in1;
            when "0010" => -- Addition------------------------------------------------------
                ALU_result <= std_logic_vector(unsigned(ALU_in0) + unsigned(ALU_in1));
            when "0110" => -- Subtraction----------------------------------------------------
                ALU_result <= std_logic_vector(unsigned(ALU_in0) - unsigned(ALU_in1));         
            when "0111" => -- Set Less than--------------------------------------------------
                if(ALU_in1 < ALU_in0) then
                    ALU_result <= x"00000001";
                 else
                    ALU_result <= (others => '0');
                end if;
            when "1100" => -- Logical NOR----------------------------------------------------
                ALU_result <= ALU_in0 NOR ALU_in1;

            when others => null; -- nop
                ALU_result <= (others => '0');
        end case;
    end process;

    --Concurrent Code:
    ALU_out <= ALU_result;
    process(ALU_result)
    begin
        if(to_integer(unsigned(ALU_result)) = 0) then
            zero <= '1';
        else 
            zero <= '0';
        end if;
    end process;

end architecture;

-----------------------------------------------------------------
-- END OF ALU COMPONENT FILE