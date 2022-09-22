LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY registerFile IS
    PORT (
        readreg1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        readreg2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        writeReg_sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        clk : IN STD_LOGIC;
        RegWrite : IN STD_LOGIC;
        readData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE structural OF registerFile IS
    SIGNAL and_out : STD_LOGIC_VECTOR(31 DOWNTO 0); --Final AND Values
    SIGNAL decoder_out : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Intermediate Signals from Mux to AND
    TYPE reg_v IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0); -- array of reg values
    SIGNAL regOut : reg_v;
    --Components

    COMPONENT and2c
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            F : OUT STD_LOGIC
        );
    END COMPONENT;
    COMPONENT decoder
        PORT (
            A : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            F : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT register32
        PORT (
            clk : IN STD_LOGIC;
            C : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux32to1
        PORT (
            IN1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN5 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN6 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN7 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN8 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN9 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN10 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN11 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN12 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN13 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN14 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN15 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN16 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN17 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN18 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN19 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN20 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN21 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN22 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN23 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN24 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN25 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN26 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN27 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN28 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN29 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN30 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN31 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            IN32 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            F : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    --Begin Concurrent Statements
BEGIN
    U1 : decoder
    PORT MAP(
        A => writeReg_sel,
        F => decoder_out
    );

    --Generate Ands and Registers
    GEN_ADDREG :
    FOR i IN 0 TO 31 GENERATE
        ANDX : and2c
        PORT MAP(
            A => RegWrite,
            B => decoder_out(i),
            F => and_out(i)
        );
        REGX : register32
        PORT MAP(
            clk => clk,
            C => and_out(i),
            D => writeData,
            Q => regOut(i)
        );
    END GENERATE GEN_ADDREG;

    --32to1 Mux to Read Data 1 and 2
    U2 : mux32to1
    PORT MAP(
        IN1 => regOut(0),
        IN2 => regOut(1),
        IN3 => regOut(2),
        IN4 => regOut(3),
        IN5 => regOut(4),
        IN6 => regOut(5),
        IN7 => regOut(6),
        IN8 => regOut(7),
        IN9 => regOut(8),
        IN10 => regOut(9),
        IN11 => regOut(10),
        IN12 => regOut(11),
        IN13 => regOut(12),
        IN14 => regOut(13),
        IN15 => regOut(14),
        IN16 => regOut(15),
        IN17 => regOut(16),
        IN18 => regOut(17),
        IN19 => regOut(18),
        IN20 => regOut(19),
        IN21 => regOut(20),
        IN22 => regOut(21),
        IN23 => regOut(22),
        IN24 => regOut(23),
        IN25 => regOut(24),
        IN26 => regOut(25),
        IN27 => regOut(26),
        IN28 => regOut(27),
        IN29 => regOut(28),
        IN30 => regOut(29),
        IN31 => regOut(30),
        IN32 => regOut(31),
        sel => readreg1,
        F => readData1
    );

    U3 : mux32to1
    PORT MAP(
        IN1 => regOut(0),
        IN2 => regOut(1),
        IN3 => regOut(2),
        IN4 => regOut(3),
        IN5 => regOut(4),
        IN6 => regOut(5),
        IN7 => regOut(6),
        IN8 => regOut(7),
        IN9 => regOut(8),
        IN10 => regOut(9),
        IN11 => regOut(10),
        IN12 => regOut(11),
        IN13 => regOut(12),
        IN14 => regOut(13),
        IN15 => regOut(14),
        IN16 => regOut(15),
        IN17 => regOut(16),
        IN18 => regOut(17),
        IN19 => regOut(18),
        IN20 => regOut(19),
        IN21 => regOut(20),
        IN22 => regOut(21),
        IN23 => regOut(22),
        IN24 => regOut(23),
        IN25 => regOut(24),
        IN26 => regOut(25),
        IN27 => regOut(26),
        IN28 => regOut(27),
        IN29 => regOut(28),
        IN30 => regOut(29),
        IN31 => regOut(30),
        IN32 => regOut(31),
        sel => readreg2,
        F => readData2
    );
END structural;