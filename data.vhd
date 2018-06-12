----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:29:38 05/28/2018 
-- Design Name: 
-- Module Name:    data - Behavioral 
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

entity data is
	 Port ( clk : in  STD_LOGIC;
			  data_di : out  STD_LOGIC_VECTOR (15 downto 0);
           data_we : in  STD_LOGIC;
           data_a : in  STD_LOGIC_VECTOR (15 downto 0);
           data_do : in  STD_LOGIC_VECTOR (15 downto 0));
end data;

architecture Behavioral of data is

	type Memory is array (0 to 255) of STD_LOGIC_VECTOR(15 downto 0);
	signal Mem : Memory;

begin

	process(clk,data_we)
	
	variable ip : integer range 0 to 255 := 0;
	
	begin
		if clk'event and clk='1' and data_we='1' then 
			Mem(to_integer(unsigned(data_a))) <= data_do;
		end if;		
	end process;
	
	data_di <= Mem(to_integer(unsigned(data_a)));

end Behavioral;

