-- ALU COMPONENT FILE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- needed arithmetic operations
------------------------------------------------------------------
entity Adder is -- 2 to 1 multiplexer
  generic (
    N : integer := 32;
    M : integer := 32
  );
  port (
    ALU_in     : in std_logic_vector(N-1 downto 0);
    ALU_add_by : in std_logic_vector(M-1 downto 0);
    ALU_out    : out std_logic_vector(N-1 downto 0);
    zero       : out std_logic
  );
end entity;
------------------------------------------------------------------
architecture Add4_Architecture of Adder is
  signal ALU_result : std_logic_vector(N-1 downto 0) := (others => '0');
begin
  ALU_out <= std_logic_vector(unsigned(ALU_in) + unsigned(ALU_add_by));
end architecture;
------------------------------------------------------------------
-- END OF ALU COMPONENT FILE