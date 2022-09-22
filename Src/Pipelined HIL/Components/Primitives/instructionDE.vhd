library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instructionDE is
    port (
        ------------------------------
        --IN PORTS 
        --CLK
        clk : in std_logic;
        --WB
        regWriteIN : in std_logic;
        memToRegIN : in std_logic;

        --M
        branchIN : in std_logic;
        memWriteReadIN : in std_logic;

        --EX
        regDstIN : in std_logic;
        ALUOpIN : in std_logic_vector(1 downto 0);
        ALUSrcIN : in std_logic;

        --PC
        PCIN : in std_logic_vector(31 downto 0);

        --Read Data
        readData1IN : in std_logic_vector(31 downto 0);
        readData2IN : in std_logic_vector(31 downto 0);

        --Sign Extend
        signExtendIN : in std_logic_vector(31 downto 0);

        --Instruction Register Section
        rtIN : in std_logic_vector(4 downto 0);
        rdIN : in std_logic_vector(4 downto 0);
        ----------------------------------------------
        --OUT PORTS
        --WB
        regWriteOUT : out std_logic;
        memtoRegOUT : out std_logic;

        --M
        branchOUT : out std_logic;
        memWriteReadOUT : out std_logic;

        --EX
        regDstOUT : out std_logic;
        ALUOpOUT : out std_logic_vector(1 downto 0);
        ALUSrcOUT : out std_logic;

        --PC
        PCOUT : out std_logic_vector(31 downto 0);

        --Read Data
        readData1OUT : out std_logic_vector(31 downto 0);
        readData2OUT : out std_logic_vector(31 downto 0);

        --Sign Extend
        signExtendOUT : out std_logic_vector(31 downto 0);

        --Instruction Register Section
        rtOUT : out std_logic_vector(4 downto 0);
        rdOUT : out std_logic_vector(4 downto 0)

    );
end entity;

architecture rtl of instructionDE is
begin
process(all)
begin
    if(rising_edge(clk)) then
        regWriteOUT <= regWriteIN;
        memtoRegOUT <= memToRegIN;
        branchOUT <= branchIN;
        memWriteReadOUT <= memWriteReadIN;
        regDstOUT <= regDstIN;
        ALUOpOUT <= ALUOpIN;
        ALUSrcOUT <= ALUSrcIN;
        PCOUT <= PCIN;
        readData1OUT <= readData1IN;
        readData2OUT <= readData2IN;
        signExtendOUT <= signExtendIN;
        rtOUT <= rtIN;
        rdOUT <= rdIN;
    end if;
end process;
end architecture;