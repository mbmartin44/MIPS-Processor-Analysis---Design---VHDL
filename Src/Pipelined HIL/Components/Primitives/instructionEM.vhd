library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instructionEM is
    port (
        --INPUT PORTS
        clk : in std_logic;
        --WB
        regWriteIN : in std_logic;
        memToRegIN : in std_logic;

        --M
        branchIN : in std_logic;
        memWriteReadIN : in std_logic;

        --Add Result, no clue what to technically call this
        addRIN : in std_logic_vector(31 downto 0);

        --ALU
        zeroIN : in std_logic;
        ALUResultIN : in std_logic_vector(31 downto 0);

        --Read Data
        readData2IN : in std_logic_vector(31 downto 0);

        --Data from RegDst Mux, no clue what to call this either
        registerInfoIN : in std_logic_vector(4 downto 0);
        -----------------------------------------------------------
        --OUTPUT PORTS
        --WB
        regWriteOUT : out std_logic;
        memToRegOUT : out std_logic;

        --M
        branchOUT : out std_logic;
        memWriteReadOUT : out std_logic;

        --Add Result thing
        addROUT : out std_logic_vector(31 downto 0);

        --ALU
        zeroOUT : out std_logic;
        ALUResultOUT : out std_logic_vector(31 downto 0);

        --Read Data
        readData2OUT : out std_logic_vector(31 downto 0);

        --Data from RegDst Mux
        registerInfoOUT : out std_logic_vector(4 downto 0)
    );
end entity;

architecture rtl of instructionEM is
begin
process(all)
begin
    if(rising_edge(clk)) then
    regWriteOUT <= regWriteIN;
    memToRegOUT <= memToRegIN;
    branchOUT <= branchIN;
    memWriteReadOUT <= memWriteReadIN;
    addROUT <= addRIN;
    zeroOUT <= zeroIN;
    ALUResultOUT <= ALUResultIN;
    readData2OUT <= readData2IN;
    registerInfoOUT <= registerInfoIN;
    end if;
end process;
end architecture;