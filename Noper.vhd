----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:34:17 06/06/2018 
-- Design Name: 
-- Module Name:    Noper - Behavioral 
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

entity Noper is
    Port ( noping : in  STD_LOGIC;
           op_in : out  STD_LOGIC_VECTOR (4 downto 0);
           op_out : out  STD_LOGIC_VECTOR (4 downto 0));
end Noper;

architecture Behavioral of Noper is



begin


end Behavioral;

