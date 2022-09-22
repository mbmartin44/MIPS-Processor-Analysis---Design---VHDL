LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY control IS
    PORT (
        opcode : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        RegDst : OUT STD_LOGIC;
        Branch : OUT STD_LOGIC;
        MemRead : OUT STD_LOGIC;
        MemWrite : OUT STD_LOGIC;
        MemtoReg : OUT STD_LOGIC;
        ALUOp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        ALUSrc : OUT STD_LOGIC;
        RegWrite : OUT STD_LOGIC;
        Jump : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF control IS
BEGIN
    PROCESS (opcode)
    BEGIN
        RegDst <= '0';
        Branch <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        MemtoReg <= '0';
        ALUOp <= "00";
        ALUSrc <= '0';
        RegWrite <= '0';
        Jump <= '0';
        IF (opcode = "000000") THEN -- R-Type
            RegDst <= '1';
            ALUSrc <= '0';
            MemtoReg <= '0';
            RegWrite <= '1';
            MemRead <= '0';
            MemWrite <= '0';
            Branch <= '0';
            ALUOp <= "10";
            Jump <= '0';
        ELSIF (opcode = "100011") THEN --LW
            RegDst <= '0';
            ALUSrc <= '1';
            MemtoReg <= '1';
            RegWrite <= '1';
            MemRead <= '1';
            MemWrite <= '0';
            Branch <= '0';
            ALUOp <= "00";
            Jump <= '0';
        ELSIF (opcode = "101011") THEN --SW
            RegDst <= '0';
            ALUSrc <= '1';
            MemtoReg <= '0';
            RegWrite <= '0';
            MemRead <= '0';
            MemWrite <= '1';
            Branch <= '0';
            ALUOp <= "00";
            Jump <= '0';
        ELSIF (opcode = "001000") THEN --ADDI
            RegDst <= '0';
            ALUSrc <= '1';
            MemtoReg <= '0';
            RegWrite <= '1';
            MemRead <= '0';
            MemWrite <= '0';
            Branch <= '0';
            ALUOp <= "00";
            Jump <= '0';
        ELSIF (opcode = "000100") THEN --BEQ
            RegDst <= '0';
            ALUSrc <= '0'; -- This should be 0
            MemtoReg <= '0';
            RegWrite <= '0';
            MemRead <= '0';
            MemWrite <= '0';
            Branch <= '1';
            ALUOp <= "01";
            Jump <= '0';
        ELSE --jump
            RegDst <= '0';
            ALUSrc <= '0';
            MemtoReg <= '0';
            RegWrite <= '0';
            MemRead <= '0';
            MemWrite <= '0';
            Branch <= '0';
            ALUOp <= "00";
            Jump <= '1';
        END IF;
    END PROCESS;
END behavioral;