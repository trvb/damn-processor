----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:14:17 06/01/2018 
-- Design Name: 
-- Module Name:    mux - Behavioral 
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

entity mux is
    Port ( B_in : in  STD_LOGIC_VECTOR (15 downto 0);
           Op_in : in  STD_LOGIC_VECTOR (3 downto 0);
           QA_out : out  STD_LOGIC_VECTOR (15 downto 0);
           B_out : out  STD_LOGIC_VECTOR (15 downto 0));
           Clk : in  STD_LOGIC);
end mux;

architecture Behavioral of mux is

begin

	Processe: process(Clk);

	

end Behavioral;

