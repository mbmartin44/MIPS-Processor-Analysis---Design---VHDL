library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers_tb is
end;

architecture bench of registers_tb is

  component registerFile
      port (
      readreg1 : in std_logic_vector(4 downto 0);
      readreg2 : in std_logic_vector(4 downto 0);
      writeReg : in std_logic_vector(4 downto 0);
      writeData : in std_logic_vector(31 downto 0);
		  clk : in std_logic;
      RegWrite : in std_logic;
      readData1 : out std_logic_vector(31 downto 0);
      readData2 : out std_logic_vector(31 downto 0)
    );
  end component;

  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics

  -- Ports
  signal readreg1 : std_logic_vector(4 downto 0) := "00000";
  signal readreg2 : std_logic_vector(4 downto 0) := "00001";
  signal writeReg : std_logic_vector(4 downto 0) := "00001";
  signal writeData : std_logic_vector(31 downto 0) := "00000000000000000000000000000010";
  signal RegWrite : std_logic := '0';
  signal readData1 : std_logic_vector(31 downto 0);
  signal readData2 : std_logic_vector(31 downto 0);
  signal clk : std_logic := '0';

begin

  registers_inst : registerFile
    port map (
      readreg1 => readreg1,
      readreg2 => readreg2,
      writeReg => writeReg,
      writeData => writeData,
      RegWrite => RegWrite,
		clk => clk,
      readData1 => readData1,
      readData2 => readData2
    );

    DUT: process
    begin
        wait for 5 ns;
        RegWrite <= '1';
		  clk <= '1';
        wait for 5 ns;
		  clk <= '0';
        RegWrite <= '0';
		  readreg2 <= "00010";
		  writeReg <= "00010";
        wait for 5 ns;
       -- writeReg <= "00010";
        --readreg2 <= "00010";
		  RegWrite <= '1';
		  clk <= '1';
        wait for 5 ns;
        RegWrite <= '0';
		  clk <= '0';
        wait;
    end process;
--   clk_process : process
--   begin
--   clk <= '1';
--   wait for clk_period/2;
--   clk <= '0';
--   wait for clk_period/2;
--   end process clk_process;

end bench;
