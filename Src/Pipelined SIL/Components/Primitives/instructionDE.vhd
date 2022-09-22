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
        memReadIN : in std_logic;

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
        rsIN : in std_logic_vector(4 downto 0);
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
        memReadOUT : out std_logic;

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
        rsOUT : out std_logic_vector(4 downto 0);
        rtOUT : out std_logic_vector(4 downto 0);
        rdOUT : out std_logic_vector(4 downto 0)

    );
end entity;

architecture rtl of instructionDE is
  signal regWritesig : std_logic :='0';
  signal memToRegsig : std_logic :='0';
  signal branchsig : std_logic :='0';
  signal memWriteReadsig : std_logic :='0';
  signal memReadsig : std_logic :='0';
  signal regDstsig : std_logic :='0';
  signal ALUOpsig : std_logic_vector(1 downto 0) := (others => '0');
  signal ALUSrcsig : std_logic :='0';
  signal PCsig : std_logic_vector(31 downto 0) := (others => '0');
  signal readData1sig : std_logic_vector(31 downto 0) := (others => '0');
  signal readData2sig : std_logic_vector(31 downto 0) := (others => '0');
  signal signExtendsig : std_logic_vector(31 downto 0) := (others => '0');
  signal rssig : std_logic_vector(4 downto 0) := (others => '0');
  signal rtsig : std_logic_vector(4 downto 0) := (others => '0');
  signal rdsig : std_logic_vector(4 downto 0) := (others => '0');
begin
process(all)
begin
    regWritesig <= regWriteIN;
    memToRegsig <= memToRegIN;
    branchsig <= branchIN;
    memWriteReadsig <= memWriteReadIN;
    memReadsig <= memReadIN;
    regDstsig <= regDstIN;
    ALUOpsig <= ALUOpIN;
    ALUSrcsig <= ALUSrcIN;
    PCsig <= PCIN;
    readData1sig <= readData1IN;
    readData2sig <= readData2IN;
    signExtendsig <= signExtendIN;
    rssig <= rsIN;
    rtsig <= rtIN;
    rdsig <= rdIN;
    if(rising_edge(clk)) then
        regWriteOUT <= regWritesig;
        memtoRegOUT <= memToRegsig;
        branchOUT <= branchsig;
        memWriteReadOUT <= memWriteReadsig;
        memReadOUT <= memReadsig;
        regDstOUT <= regDstsig;
        ALUOpOUT <= ALUOpsig;
        ALUSrcOUT <= ALUSrcsig;
        PCOUT <= PCsig;
        readData1OUT <= readData1sig;
        readData2OUT <= readData2sig;
        signExtendOUT <= signExtendsig;
        rsOUT <= rssig;
        rtOUT <= rtsig;
        rdOUT <= rdsig;
    end if;
end process;
end architecture;