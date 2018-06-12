----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:46:13 05/28/2018 
-- Design Name: 
-- Module Name:    instr - Behavioral 
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

entity InstructionMem is
    Port ( clk : in  STD_LOGIC;
           i : out  STD_LOGIC_VECTOR (31 downto 0);
			  pause : in STD_LOGIC
			 );
end InstructionMem;

architecture Behavioral of InstructionMem is
	type Instructions is array (0 to 255) of std_logic_vector(31 downto 0);
	signal Ins : Instructions;
	signal i_out : STD_LOGIC_VECTOR (31 downto 0);
begin

	Ins <= (
		0 => x"0E000001", -- move r0 1	R0 est le rsultat
		1 => x"0E010001", -- move r1 1	R1 est la nouvelle valeur 
		2 => x"0E020001", -- move r2 1   R2 sert juste  stocker 1
		
		3 => x"00010002", -- add r1 r2
		4 => x"02000001", -- mult r0 r1
		5 => x"0D000000", -- save r0 @0
								
		6 => x"00010002", -- add r1 r2
		7 => x"02000001", -- mult r0 r1
		8 => x"0D000001", -- save r0 @1
								
		9 => x"00010002", -- add r1 r2
		10 => x"02000001", -- mult r0 r1
		11 => x"0D000002", -- save r0 @2
								
		12 => x"00010002", -- add r1 r2
		13 => x"02000001", -- mult r0 r1
		14 => x"0D000003", -- save r0 @3
		
		15 => x"00010002", -- add r1 r2
		16 => x"02000001", -- mult r0 r1
		17 => x"0D000004", -- save r0 @4
								
		18 => x"00010002", -- add r1 r2
		19 => x"02000001", -- mult r0 r1
		20 => x"0D000005", -- save r0 @5
								
		21 => x"00010002", -- add r1 r2
		22 => x"02000001", -- mult r0 r1
		23 => x"0D000006", -- save r0 @6
		
		24 => x"00010002", -- add r1 r2
		25 => x"02000001", -- mult r0 r1
		26 => x"0D000007", -- save r0 @7
		
		27 => x"00010002", -- add r1 r2
		28 => x"02000001", -- mult r0 r1
		29 => x"0D000008", -- save r0 @8

		30 => x"00010002", -- add r1 r2
		31 => x"02000001", -- mult r0 r1
		32 => x"0D000009", -- save r0 @9

		33 => x"00010002", -- add r1 r2
		34 => x"02000001", -- mult r0 r1
		35 => x"0D00000A", -- save r0 @10			
		
		others => x"00000000"
	);

	process(clk)
	
	variable ip : integer range 0 to 255 := 0;
	
	begin
		if clk'event and clk='1' and pause='0' then 
			i_out <= Ins(ip);
			ip := ip + 1;
		end if;
		
	end process;
	i <= i_out;

end Behavioral;

