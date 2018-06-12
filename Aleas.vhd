----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:48:57 06/06/2018 
-- Design Name: 
-- Module Name:    Aleas - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Aleas is
    Port ( dest_reg_lidi : in  STD_LOGIC_VECTOR (15 downto 0);
           dest_reg_diex : in  STD_LOGIC_VECTOR (15 downto 0);
			  dest_reg_exmem : in  STD_LOGIC_VECTOR (15 downto 0);
           op_lidi : in  STD_LOGIC_VECTOR (4 downto 0);
           op_diex : in  STD_LOGIC_VECTOR (4 downto 0);
           op_exmem : in  STD_LOGIC_VECTOR (4 downto 0);	  
           pause : out  STD_LOGIC;
			  clk: in STD_LOGIC
			  );
end Aleas;

architecture Behavioral of Aleas is

begin

	AleasProcess: process(clk)	
		variable timer : integer range 0 to 2 := 0;
	begin
		if clk'event and clk='1' then 
			
			-- si move ou read dans diex && memes registres de destination && copy ou store dans lidi
			if ((timer = 0)
					and (dest_reg_lidi = dest_reg_diex)
					and (op_diex = "01100" or op_diex = "01110")
					and (op_lidi /= "01011" or op_lidi /= "01101")) then
				timer := 2;
				pause <= '1';
			
			elsif ((timer = 0)
					and (dest_reg_lidi = dest_reg_exmem)
					and (op_exmem = "01100" or op_exmem = "01110")
					and (op_lidi /= "01011" or op_lidi /= "01101")) then
					
				timer := 1;
				pause <= '1';
				
			elsif (timer > 0)
				timer := timer - 1;
			end if;
			
			
		end if;
	end process;
	
end Behavioral;

