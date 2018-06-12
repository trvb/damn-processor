----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:46:38 05/04/2018 
-- Design Name: 
-- Module Name:    RegBank - Behavioral 
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

entity RegBank is
    Port ( A_Sel : in  STD_LOGIC_VECTOR (3 downto 0);
           B_Sel : in  STD_LOGIC_VECTOR (3 downto 0);
           QA : out  STD_LOGIC_VECTOR (15 downto 0);
           QB : out  STD_LOGIC_VECTOR (15 downto 0);
           W_Sel : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
			  Rst: in STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (15 downto 0);
			  Clk: in STD_LOGIC
			  );
end RegBank;

architecture Behavioral of RegBank is
	type Registers is array (0 to 15) of std_logic_vector(15 downto 0);
	signal Reg : Registers;
	
begin
	process(Clk)
	begin
		if (Clk='1') then
			if Rst='0' then
				Reg <= (others => x"0000");
			else
				if W='1' then
					Reg(to_integer(unsigned(W_Sel))) <= DATA;
				end if;	
			end if;
		end if;
	end process;
	QA <= Reg(to_integer(unsigned(A_Sel))) when W_Sel /= A_Sel or W = '0' else DATA;
	QB <= Reg(to_integer(unsigned(B_Sel))) when W_Sel /= B_Sel or W = '0' else DATA;
end Behavioral;

