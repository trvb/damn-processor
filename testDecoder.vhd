--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:42:02 05/18/2018
-- Design Name:   
-- Module Name:   /home/tbueno/Dev/Projet_Sys_Info/processeur/damn/testDecoder.vhd
-- Project Name:  damn
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testDecoder IS
END testDecoder;
 
ARCHITECTURE behavior OF testDecoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder
    PORT(
         I : IN  std_logic_vector(31 downto 0);
         Op : OUT  std_logic_vector(3 downto 0);
         A : OUT  std_logic_vector(15 downto 0);
         B : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal I : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Op : std_logic_vector(3 downto 0);
   signal A : std_logic_vector(15 downto 0);
   signal B : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder PORT MAP (
		 I => I,
		 Op => Op,
		 A => A,
		 B => B
   );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		I <= x"00030004"; -- add r3 r4
		wait for 100ns;
		I <= x"F2F3ABC4"; -- mult r3 r4 (test fuzzing)
		wait for 100ns;
		
		I <= x"0F000018"; -- on attend jump 18
		wait for 100ns;
		I <= x"0FFFFF18"; -- on attend jump 18 (test fuzzing)
		wait for 100ns;
		
		I <= x"0B061337"; -- read r6 1337
		wait for 100ns;
		I <= x"FCFECAFE"; -- read r14 cafe (test fuzzing)
		wait for 100ns;
		
		I <= x"0D01BABE"; -- move r1 babe
		wait for 100ns;
		I <= x"0E04B17E"; -- jcvd r4 b17e
		wait for 100ns;
		
      wait;
   end process;

END;
