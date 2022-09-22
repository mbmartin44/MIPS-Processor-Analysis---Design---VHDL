library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instructionMW is
    port (
        --INPUT PORTS
        clk : in std_logic;
        --WB
        memToRegIN : in std_logic;
        regWriteIN : in std_logic;

        --Mem Read Data
        memReadDataIN : in std_logic_vector(31 downto 0);

        --ALU Result
        ALUResultIN : in std_logic_vector(31 downto 0);

        --Data from RegDst Mux, no clue what to call this either
        registerInfoIN : in std_logic_vector(4 downto 0);
    -------------------------------------------------------------------
        --OUTPUT PORTS
        --WB
        memToRegOUT : out std_logic;
        regWriteOUT : out std_logic;

        --Mem Read Data
        memReadDataOUT : out std_logic_vector(31 downto 0);

        --ALU Result
        ALUResultOUT : out std_logic_vector(31 downto 0);

        --Data from RegDst Mux thing
        registerInfoOUT : out std_logic_vector(4 downto 0)

    );
end entity;

architecture rtl of instructionMW is
begin
process(all)
begin
    if (rising_edge(clk)) then
        memToRegOUT <= memToRegIN;
        memReadDataOUT <= memReadDataIN;
        ALUResultOUT <= ALUResultIN;
        registerInfoOUT <= registerInfoIN;
        regWriteOUT <= regWriteIN;
    end if;
end process;
end architecture;