--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:41:19 05/28/2018
-- Design Name:   
-- Module Name:   /home/tbueno/Dev/Projet_Sys_Info/processeur/damn/testData.vhd
-- Project Name:  damn
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: data
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
 
ENTITY testData IS
END testData;
 
ARCHITECTURE behavior OF testData IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT data
    PORT(
         clk : IN  std_logic;
         data_di : OUT  std_logic_vector(15 downto 0);
         data_we : IN  std_logic_vector(0 downto 0);
         data_a : IN  std_logic_vector(15 downto 0);
         data_do : IN  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal data_we : std_logic_vector(0 downto 0) := (others => '0');
   signal data_a : std_logic_vector(15 downto 0) := (others => '0');
   signal data_do : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal data_di : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 300 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: data PORT MAP (
          clk => clk,
          data_di => data_di,
          data_we => data_we,
          data_a => data_a,
          data_do => data_do
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

      -- insert stimulus here 
		data_in <= x"0001";
		data_a <= x"0002";
		data_do <= x"0003";
		
		wait for 300ns;
		
		data_we <= '1';

      wait;
   end process;

END;
