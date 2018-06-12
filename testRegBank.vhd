-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testRegBank IS
END testRegBank;

ARCHITECTURE behavior OF testRegBank IS 

-- Component Declaration
COMPONENT RegBank
	Port ( 
		A_Sel : in  std_logic_vector (3 downto 0);
		B_Sel : in  std_logic_vector (3 downto 0);
		QA : out  std_logic_vector (15 downto 0);
		QB : out  std_logic_vector (15 downto 0);
		W_Sel : in  std_logic_vector (3 downto 0);
		W : in  std_logic;
		Rst: in std_logic;
		DATA : in  std_logic_vector (15 downto 0);
		Clk: in std_logic
	);
END COMPONENT;
	
--Inputs
signal A_Sel : std_logic_vector(3 downto 0) := (others => '0');
signal B_Sel : std_logic_vector(3 downto 0) := (others => '0');
signal W_Sel : std_logic_vector(3 downto 0) := (others => '0');
signal W : std_logic := '0';
signal Rst: std_logic := '0';
signal DATA : std_logic_vector (15 downto 0) := (others => '0');
signal Clk: std_logic := '0';

--Outputs
signal QA : std_logic_vector(15 downto 0) := (others => '0');
signal QB : std_logic_vector(15 downto 0) := (others => '0');			
constant clk_period : time := 10 ns;

BEGIN

-- Component Instantiation
uut: RegBank PORT MAP(
	A_Sel => A_Sel,
	B_Sel => B_Sel,
	QA => QA,
	QB => QB,
	W_Sel => W_Sel,
	W => W,
	Rst => Rst,
	DATA => DATA,
	Clk => Clk
);

-- Clock process definitions
clk_process :process
begin
	Clk <= '0';
	wait for clk_period/2;
	Clk <= '1';
	wait for clk_period/2;
end process;

-- Stimulus process
stim_proc: process
begin		
	-- hold reset state for 100 ns.
	wait for 100 ns;	
 
	wait for clk_period*10;

	-- Add user defined stimulus here
	W_Sel <= x"8" after 100ns;	
	DATA <= x"1337" after 100ns;
	W <= '1' after 100ns; 
	
	A_Sel <= x"8" after 200 ns;
	
	wait for 50 ns;
	wait; -- will wait forever
	END PROCESS;
END;
