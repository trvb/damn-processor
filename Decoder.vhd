----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:25:56 05/18/2018 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder is
    Port ( I : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : out  STD_LOGIC_VECTOR (4 downto 0);
           A : out  STD_LOGIC_VECTOR (15 downto 0);
           B : out  STD_LOGIC_VECTOR (15 downto 0);
			  C : out  STD_LOGIC_VECTOR (15 downto 0)
			 );
end Decoder;

architecture Behavioral of Decoder is

	signal S_Op : STD_LOGIC_VECTOR (4 downto 0);	 -- op code (4 bits)
	signal S_R1 : STD_LOGIC_VECTOR (15 downto 0); -- registre 1 (4 bits)
	signal S_R2 : STD_LOGIC_VECTOR (15 downto 0); -- registre 2 (4 bits)
	signal S_P2 : STD_LOGIC_VECTOR (15 downto 0); -- param 2 (imm/@ sur 16 bits)
	
	signal Op_1 : STD_LOGIC_VECTOR (15 downto 0);
	
begin
	S_Op <= I(28 downto 24);
	S_R1 <= "000000000000" & I(19 downto 16);
	S_R2 <= "000000000000" & I(3 downto 0);
	S_P2 <= I(15 downto 0);
	
	Op <= S_Op;
	
	Op_1 <=
		S_R1 when S_Op < "10000"
	else
		(others => '0')
	;
	
	-- jeu d'instruction à deux opérandes
	A <= Op_1;
	C <= Op_1;
	
	B <=
		S_R2 when S_Op < "01100"
	else
		S_P2 when S_Op < "10001"
	else
		(others => '0')
	;
end Behavioral;

