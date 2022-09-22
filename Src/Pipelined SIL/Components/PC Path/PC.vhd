-- ALU COMPONENT FILE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- needed arithmetic operations
------------------------------------------------------------------
entity PC is -- 2 to 1 multiplexer
    port(  
        PC_Write : in std_logic;
        clk   : in std_logic;
        PC_in : in std_logic_vector(31 downto 0);
        PC_out: out std_logic_vector(31 downto 0)
    );
end entity;
------------------------------------------------------------------
architecture PC_Architecture of PC is
    
signal address: std_logic_vector(31 downto 0) := (others => '0');
begin
    process(clk)
    begin
        PC_out <= address;
        if(rising_edge(clk) and PC_Write = '1') then
            address <= PC_in;
        end if;
    end process;
    
end architecture;