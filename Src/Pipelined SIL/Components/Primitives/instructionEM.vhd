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
  signal regWritesig : std_logic := '0';
  signal memToRegsig : std_logic := '0';
  signal branchsig : std_logic := '0';
  signal memWriteReadsig : std_logic := '0';
  signal addRsig : std_logic_vector(31 downto 0) := (others => '0');
  signal zerosig : std_logic := '0';
  signal ALUResultsig : std_logic_vector(31 downto 0) := (others => '0');
  signal readData2sig : std_logic_vector(31 downto 0) := (others => '0');
  signal registerInfosig : std_logic_vector(4 downto 0) := (others => '0');
begin
process(all)    
begin
    regWritesig <= regWriteIN;
    memToRegsig <= memToRegIN;
    branchsig <= branchIN;
    memWriteReadsig <= memWriteReadIN;
    addRsig <= addRIN;
    zerosig <= zeroIN;
    ALUResultsig <= ALUResultIN;
    readData2sig <= readData2IN;
    registerInfosig <= registerInfoIN;
    if(rising_edge(clk)) then
        regWriteOUT <= regWritesig;
        memToRegOUT <= memToRegsig;
        branchOUT <= branchsig;
        memWriteReadOUT <= memWriteReadsig;
        addROUT <= addRsig;
        zeroOUT <= zerosig;
        ALUResultOUT <= ALUResultsig;
        readData2OUT <= readData2sig;
        registerInfoOUT <= registerInfosig;
    end if;
end process;
end architecture;