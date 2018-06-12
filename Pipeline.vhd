----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:45:55 05/04/2018 
-- Design Name: 
-- Module Name:    Pipeline - Behavioral 
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

entity Pipeline is
    Port ( Op_in : in  STD_LOGIC_VECTOR (4 downto 0);
           A_in : in  STD_LOGIC_VECTOR (15 downto 0);
           B_in : in  STD_LOGIC_VECTOR (15 downto 0);
           C_in : in  STD_LOGIC_VECTOR (15 downto 0);
           Op_out : out  STD_LOGIC_VECTOR (4 downto 0);
           A_out : out  STD_LOGIC_VECTOR (15 downto 0);
           B_out : out  STD_LOGIC_VECTOR (15 downto 0);
           C_out : out STD_LOGIC_VECTOR (15 downto 0);
           Clk : in  STD_LOGIC;
			  Pause: in STD_LOGIC
			 );
end Pipeline;

architecture Behavioral of Pipeline is
begin
	PipelineProcess: process(Clk)
	begin
		-- Front montant sur l'horloge
		if (Clk='1' and Clk'event and Pause='0') then
				A_out <= A_in;
				B_out <= B_in;
				C_out <= C_in;
				Op_out <= Op_in;
		end if;

	end process PipelineProcess;	
end Behavioral;

