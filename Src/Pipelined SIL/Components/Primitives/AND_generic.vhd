-- AND GENERIC ENTITY FILE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- needed arithmetic operations

entity and_generic is
    generic 
        (
            DATA_WIDTH : integer := 32;
            NUM_OUTPUTS : integer := 1
        );
    port ( 
        in_data1 : in std_logic_vector(DATA_WIDTH-1 downto 0);
        in_data2 : in std_logic_vector(DATA_WIDTH-1 downto 0);
        out_data : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end entity and_generic;

architecture behavioral of and_generic is
begin

  out_data <= in_data1 AND in_data2;
  
end behavioral;

