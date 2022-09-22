library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity megaMux is
    port (
        --In Ports
        ctrl : in std_logic;

        RegDstIN   : in std_logic;
        BranchIN   : in std_logic;
        MemReadIN  : in std_logic; --Ignore
        MemWriteIN : in std_logic;
        MemtoRegIN : in std_logic;
        ALUOpIN    : in std_logic_vector(1 downto 0);
        ALUSrcIN   : in std_logic;
        RegWriteIN : in std_logic;
        JumpIN     : in std_logic; --Ignore

        --Out Ports
        RegDstOUT : out std_logic;
        BranchOUT : out std_logic;
        MemReadOUT : out std_logic; --Ignore
        MemWriteOUT : out std_logic;
        MemToRegOUT : out std_logic;
        ALUOpOUT : out std_logic_vector(1 downto 0);
        ALUSrcOUT : out std_logic;
        RegWriteOUT : out std_logic;
        JumpOUT : out std_logic --Ignore
    );
end entity;

architecture rtl of megaMux is
begin
    process(all)
    begin
        if (ctrl = '0') then
            RegDstOUT <= RegDstIN;
            BranchOUT <= BranchIN;
            MemReadOUT <= MemReadIN;
            MemWriteOUT <= MemWriteIN;
            MemToRegOUT <= MemtoRegIN;
            ALUOpOUT <= ALUOpIN;
            ALUSrcOUT <= ALUSrcIN;
            RegWriteOUT <= RegWriteIN;
            JumpOUT <= JumpIN;
        else
            RegDstOUT <= '0';
            BranchOUT <= '0';
            MemReadOUT <= '0';
            MemWriteOUT <= '0';
            MemToRegOUT <= '0';
            ALUOpOUT <= "00";
            ALUSrcOUT <= '0';
            RegWriteOUT <= '0';
            JumpOUT <= '0';
        end if;
    end process;
end architecture rtl;