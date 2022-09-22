-- Package for use in MIPS Processor Implementation Project
library IEEE;
use IEEE.std_logic_1164.all;
------------------------------------------------------------------
entity mux_generic32 is -- 2 to 1 multiplexer

    Generic(
            N : integer := 32 -- Defaults to 32-bit bus
    );
    port(  
            mux_in0 : in std_logic_vector(N-1 downto 0);
            mux_in1 : in std_logic_vector(N-1 downto 0);
            mux_ctl : in std_logic;
            mux_out : out std_logic_vector(N-1 downto 0)
    );
end entity;
------------------------------------------------------------------
architecture MUX_architecture of mux_generic32 is
begin
    mux_out <= mux_in0 when mux_ctl = '0' else mux_in1;
end architecture;
------------------------------------------------------------------
-- END OF MUX2 COMPONENT FILE