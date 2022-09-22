-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

--binary to seven-segment encoder
-----------------------------------------------------------------------------------------------------------
--Inputs:
--1.) a four bit input inData(3 downto 0)
--2.) A blanking bit input (no segs illuminated/blank when blanking is high) else show only 0-9 blanking for 0xA-0xF 
--3.) dispPoint bit input (illuminate the "decimal point" when high
-----------------------------------------------------------------------------------------------------------
--Outputs:
--8 Output bits:
--1.) 7 seg-bits corresponding to a segment segA,segB,segC,segD,...,segG on the display, while segPoint controls the corresponding decimal point

entity bin2seg7 is
	port(
    	--Inputs:
      inData : in std_logic_vector(3 downto 0);
    	blank  : in std_logic; -- needs to be assigned a push button and then inverted internally before passing to process
      dispPoint: in std_logic;
       
       --Outputs: --
       segs :  out std_logic_vector(6 downto 0);
       segPoint : out std_logic
       );
end entity;

architecture behavioral of bin2seg7 is
	begin
    seg7: process(inData,blank,dispPoint)
    begin
    
    if (blank = '1') then
      case inData is
    	when "0000" => segs <= "1000000"; --0
        when "0001" => segs <= "1111001"; --1
        when "0010" => segs <= "0100100"; --2
        when "0011" => segs <= "0110000"; --3
		    when "0100" => segs <= "0011001"; --4
        when "0101" => segs <= "0010010"; --5
        when "0110" => segs <= "0000010"; --6
        when "0111" => segs <= "1111000"; --7 
        when "1000" => segs <= "0000000"; --8
        when "1001" => segs <= "0011000"; --9
        when "1010" => segs <= "1111111"; --A
        when "1011" => segs <= "1111111"; --B
        when "1100" => segs <= "1111111"; --C 
        when "1101" => segs <= "1111111"; --D
        when "1110" => segs <= "1111111"; --E
        when "1111" => segs <= "1111111"; --F
        when others => segs <= "1111111"; -- --
	  end case;
      
      case dispPoint is
      	when '1' => segPoint <= '0'; -- disp point high
        when '0' => segPoint <= '1'; --dispPoint low
        when others => segPoint <= '1'; -- remain low for any unexpected input values
      end case;
    
    elsif (blank = '0') then
    	segs <= "1111111"; -- blank when blank is high
		segPoint <= '1';
    end if;
    
    end process;
end behavioral;