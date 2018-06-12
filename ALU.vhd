----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:43:19 05/03/2018 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           Op : in  STD_LOGIC_VECTOR (4 downto 0);
           S : out  STD_LOGIC_VECTOR (15 downto 0);
           Flags : out  STD_LOGIC_VECTOR (3 downto 0));
			  -- Flags(0) -> zero
			  -- Flags(1) -> negative
			  -- Flags(2) -> overflow
			  -- Flags(3) -> carry
end ALU;

architecture Behavioral of ALU is

	signal S_add : STD_LOGIC_VECTOR (16 downto 0);
	signal S_sub : STD_LOGIC_VECTOR (16 downto 0);
	signal S_mul : STD_LOGIC_VECTOR (31 downto 0);
	signal S_lsh : STD_LOGIC_VECTOR (15 downto 0);
	signal S_rsh : STD_LOGIC_VECTOR (15 downto 0);
	
	signal S_equl : STD_LOGIC_VECTOR (15 downto 0);
	signal S_diff : STD_LOGIC_VECTOR (15 downto 0);
	signal S_infr : STD_LOGIC_VECTOR (15 downto 0);
	signal S_infe : STD_LOGIC_VECTOR (15 downto 0);
	signal S_supr : STD_LOGIC_VECTOR (15 downto 0);
	signal S_supe : STD_LOGIC_VECTOR (15 downto 0);
	
	signal S_tmp : STD_LOGIC_VECTOR (15 downto 0);

begin
	-- Calcul des opérations B sur A (inversion opérande 1/2 dans chemin de données)
	S_add <= ('0'&B)+('0'&A);
	S_sub <= ('0'&B)-('0'&A);
	S_mul <= B*A;
	S_lsh <= std_logic_vector(unsigned(B) sll to_integer(unsigned(A)));
	S_rsh <= std_logic_vector(unsigned(B) srl to_integer(unsigned(A)));
	
	S_equl <= x"0000" when B=A else x"FFFF";
	S_diff <= x"0000" when B/=A else x"FFFF";
	S_infr <= x"0000" when B<A else x"FFFF";
	S_infe <= x"0000" when B<=A else x"FFFF";
	S_supr <= x"0000" when B>A else x"FFFF";
	S_supe <= x"0000" when B>=A else x"FFFF";
	
	-- Bloc principal
	-- Signal de sortie
	S_tmp <=
		S_add(15 downto 0) when Op = x"0"
	else
		S_sub(15 downto 0) when Op = x"1"
	else
		S_mul(15 downto 0) when Op = x"2"
	else
		S_lsh when Op = x"3"
	else
		S_rsh when Op = x"4"
	else
		S_equl when Op = x"5"
	else
		S_diff when Op = x"6"
	else
		S_infr when Op = x"7"
	else
		S_infe when Op = x"8"
	else
		S_supr when Op = x"9"
	else
		S_supe when Op = x"A"
	else
		(others => 'Z')
	;
	
	
	S <= S_tmp;

	-- Flag zero
	Flags(0) <= '1' when S_tmp = x"0" else '0';
	
	-- Flag negative
	Flags(1) <= S_tmp(15);
		
	-- Flag overflow
	Flags(2) <=
		'1' when Op = x"0" and (S_add(16) /= '0')
	else
		'1' when Op = x"1" and (S_sub(16) /= '0')
	else
		'1' when Op = x"2" and (S_mul(31 downto 16) /= x"0")
	else
		'0';
	
	-- Flag carry
	Flags(3) <=
		S_add(16) when Op = x"0"
	else
		S_sub(16) when Op = x"1"
	else
		'0';
		
end Behavioral;
