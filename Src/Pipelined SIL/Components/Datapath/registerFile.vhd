library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registerFile is
    port (
        readreg1 : in std_logic_vector(4 downto 0);
        readreg2 : in std_logic_vector(4 downto 0);
        writeReg_sel : in std_logic_vector(4 downto 0);
        writeData : in std_logic_vector(31 downto 0);
		clk			: in std_logic;
        RegWrite : in std_logic;
        readData1 : out std_logic_vector(31 downto 0);
        readData2 : out std_logic_vector(31 downto 0)
    );
end entity;

architecture structural of registerFile is
    signal and_out : std_logic_vector(31 downto 0); --Final AND Values
    signal decoder_out : std_logic_vector(31 downto 0); -- Intermediate Signals from Mux to AND
    type reg_v is array (0 to 31) of std_logic_vector(31 downto 0); -- array of reg values
    signal regOut : reg_v;
--Components

    component and2c
        port (
        A : in std_logic;
        B : in std_logic;
        F : out std_logic
    );
    end component;


    component decoder
        port (
        A : in std_logic_vector(4 downto 0);
        F : out std_logic_vector(31 downto 0)
      );
    end component;
    

    component register32
        port (
        clk : in std_logic;
        C : in std_logic;
        D : in std_logic_vector(31 downto 0);
        Q : out std_logic_vector(31 downto 0)
      );
    end component;

    component mux32to1
        port (
        IN1 : in std_logic_vector(31 downto 0);
        IN2 : in std_logic_vector(31 downto 0);
        IN3 : in std_logic_vector(31 downto 0);
        IN4 : in std_logic_vector(31 downto 0);
        IN5 : in std_logic_vector(31 downto 0);
        IN6 : in std_logic_vector(31 downto 0);
        IN7 : in std_logic_vector(31 downto 0);
        IN8 : in std_logic_vector(31 downto 0);
        IN9 : in std_logic_vector(31 downto 0);
        IN10 : in std_logic_vector(31 downto 0);
        IN11 : in std_logic_vector(31 downto 0);
        IN12 : in std_logic_vector(31 downto 0);
        IN13 : in std_logic_vector(31 downto 0);
        IN14 : in std_logic_vector(31 downto 0);
        IN15 : in std_logic_vector(31 downto 0);
        IN16 : in std_logic_vector(31 downto 0);
        IN17 : in std_logic_vector(31 downto 0);
        IN18 : in std_logic_vector(31 downto 0);
        IN19 : in std_logic_vector(31 downto 0);
        IN20 : in std_logic_vector(31 downto 0);
        IN21 : in std_logic_vector(31 downto 0);
        IN22 : in std_logic_vector(31 downto 0);
        IN23 : in std_logic_vector(31 downto 0);
        IN24 : in std_logic_vector(31 downto 0);
        IN25 : in std_logic_vector(31 downto 0);
        IN26 : in std_logic_vector(31 downto 0);
        IN27 : in std_logic_vector(31 downto 0);
        IN28 : in std_logic_vector(31 downto 0);
        IN29 : in std_logic_vector(31 downto 0);
        IN30 : in std_logic_vector(31 downto 0);
        IN31 : in std_logic_vector(31 downto 0);
        IN32 : in std_logic_vector(31 downto 0);
        sel : in std_logic_vector(4 downto 0);
        F : out std_logic_vector(31 downto 0)
      );
    end component;
    
    --Begin Concurrent Statements
begin
    U1: decoder
        port map (
           A => writeReg_sel,
           F => decoder_out 
     );

     --Generate Ands and Registers
     GEN_ADDREG:
     for i in 0 to 31 Generate
            ANDX: and2c 
                port map(
                    A => RegWrite,
                    B => decoder_out(i),
                    F => and_out(i)
                );
            REGX: register32
                    port map(
                        clk => clk,
                        C => and_out(i),
                        D => writeData,
                        Q => regOut(i)
                    );
    end generate GEN_ADDREG;
    
    --32to1 Mux to Read Data 1 and 2
    U2: mux32to1
        port map(
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
    
    U3: mux32to1
        port map(
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
end structural;
        