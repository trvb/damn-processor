--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:01:21 05/03/2018
-- Design Name:   
-- Module Name:   /home/tbueno/Dev/Projet_Sys_Info/processeur/damn/testALU.vhd
-- Project Name:  damn
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testALU IS
END testALU;
 
ARCHITECTURE behavior OF testALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         Op : IN  std_logic_vector(4 downto 0);
         S : OUT  std_logic_vector(15 downto 0);
         Flags : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal Op : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(15 downto 0);
   signal Flags : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
	signal clk : std_logic := '0';
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          S => S,
          Flags => Flags
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

		-- Test cases
      A <= x"0002";
		B <= x"00FF";
		
		-- Test: add
		Op <= '0'&x"0" after 10 ns;
		
		-- Test: sub
		Op <= '0'&x"1" after 20 ns;
		
		-- Test: mul
		Op <= '0'&x"2" after 30 ns;
		
		-- Test: lsl
		Op <= '0'&x"3" after 40 ns;
		
		-- Test: lsr
		Op <= '0'&x"4" after 50 ns;
		
		-- Test: equ
		Op <= '0'&x"5" after 60 ns;
		
		-- Test: dif
		Op <= '0'&x"6" after 70 ns;
		
		-- Test: inf
		Op <= '0'&x"7" after 80 ns;
		
		-- Test: infe
		Op <= '0'&x"8" after 90 ns;
		
		-- Test: sup
		Op <= '0'&x"9" after 100 ns;
		
		-- Test: supe
		Op <= '0'&x"A" after 110 ns;

      wait;
   end process;

END;