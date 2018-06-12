----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:21:20 05/18/2018 
-- Design Name: 
-- Module Name:    Processeur - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processeur is
--    Port ( ins_di : in  STD_LOGIC_VECTOR (31 downto 0);
--          ins_a : out  STD_LOGIC_VECTOR (15 downto 0);
--           data_di : in  STD_LOGIC_VECTOR (15 downto 0);
--           data_we : out  STD_LOGIC;
--           data_a : out  STD_LOGIC_VECTOR (15 downto 0);
--           data_do : out  STD_LOGIC_VECTOR (15 downto 0));
		Port( clk: in STD_LOGIC);
end Processeur;


architecture Behavioral of Processeur is 

	component InstructionMem is
		 Port ( clk : in  STD_LOGIC;
				  i : out  STD_LOGIC_VECTOR (31 downto 0);
				  pause : in STD_LOGIC);
	end component;

	component Decoder is
		 Port ( I : in  STD_LOGIC_VECTOR (31 downto 0);
				  Op : out  STD_LOGIC_VECTOR (4 downto 0);
				  A : out  STD_LOGIC_VECTOR (15 downto 0);
				  B : out  STD_LOGIC_VECTOR (15 downto 0);		
				  C : out  STD_LOGIC_VECTOR (15 downto 0)		  
		 );
	end component;

	component Pipeline is
		 Port ( Op_in : in  STD_LOGIC_VECTOR (4 downto 0);
				  A_in : in  STD_LOGIC_VECTOR (15 downto 0);
				  B_in : in  STD_LOGIC_VECTOR (15 downto 0);
				  C_in : in  STD_LOGIC_VECTOR (15 downto 0);
				  Op_out : out  STD_LOGIC_VECTOR (4 downto 0);
				  A_out : out  STD_LOGIC_VECTOR (15 downto 0);
				  B_out : out  STD_LOGIC_VECTOR (15 downto 0);
				  C_out : out  STD_LOGIC_VECTOR (15 downto 0);
				  Clk : in  STD_LOGIC;
				  Pause : in  STD_LOGIC);
	end component;

	component ALU is
		 Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
				  B : in  STD_LOGIC_VECTOR (15 downto 0);
				  Op : in  STD_LOGIC_VECTOR (4 downto 0);
				  S : out  STD_LOGIC_VECTOR (15 downto 0);
				  Flags : out  STD_LOGIC_VECTOR (3 downto 0));
				  -- Flags(0) -> zero
				  -- Flags(1) -> negative
				  -- Flags(2) -> overflow
				  -- Flags(3) -> carry
	end component;

	component RegBank is
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
	end component;

	component data is
		 Port ( clk : in  STD_LOGIC;
				  data_di : out  STD_LOGIC_VECTOR (15 downto 0);
				  data_we : in  STD_LOGIC;
				  data_a : in  STD_LOGIC_VECTOR (15 downto 0);
				  data_do : in  STD_LOGIC_VECTOR (15 downto 0));
	end component;

	signal inputinst: STD_LOGIC_VECTOR (31 downto 0);
	
	type stage_record is record
		Op : STD_LOGIC_VECTOR (4 downto 0);
		A : STD_LOGIC_VECTOR (15 downto 0);
		B : STD_LOGIC_VECTOR (15 downto 0);
		C : STD_LOGIC_VECTOR (15 downto 0);
	end record;
	
	signal de : stage_record;
	
	signal dec2lidi : stage_record;
	signal lidi2diex : stage_record;
	signal diex2exmem : stage_record;
	signal exmem2memre : stage_record;
	signal memre2regb : stage_record;

	signal rst: std_logic;
	
	signal lidiMUXdiex: STD_LOGIC_VECTOR (15 downto 0);
	signal diexMUXexmem: STD_LOGIC_VECTOR (15 downto 0);
	signal exmemMUXramsel: STD_LOGIC_VECTOR (15 downto 0);
	signal exmemMUXramdata: STD_LOGIC_VECTOR (15 downto 0);
	signal memreMUXregb: STD_LOGIC_VECTOR (15 downto 0);
	
	signal exmemLCmemre : std_logic;
	signal memreLCregb : std_logic;
	
	signal alu_flags : STD_LOGIC_VECTOR (3 downto 0);
	
	signal rb_qa: STD_LOGIC_VECTOR (15 downto 0);
	signal rb_qb: STD_LOGIC_VECTOR (15 downto 0);
	signal S: STD_LOGIC_VECTOR (15 downto 0);
	
	signal ram_in: STD_LOGIC_VECTOR (15 downto 0);
	signal noper: STD_LOGIC_VECTOR (4 downto 0);
	
	-- pause execution when awaiting for an instruction to complete
	signal pause_pipeline : STD_LOGIC;
	signal lidi_read : boolean;
	signal diex_write : boolean;
	signal exmem_write : boolean;
	signal diex_conflict : boolean;
	signal exmem_conflict : boolean;
begin

	inst: InstructionMem PORT MAP (
		clk,
		inputinst,
		pause_pipeline
	);

   dec: Decoder PORT MAP (
		 inputinst,
		 dec2lidi.Op,
		 dec2lidi.A,
		 dec2lidi.B,
		 dec2lidi.C
   );
		
	lidi: Pipeline PORT MAP (
		dec2lidi.Op,
		dec2lidi.A,
		dec2lidi.B,
		dec2lidi.C,
		lidi2diex.Op,
		lidi2diex.A,
		lidi2diex.B,
		lidi2diex.C,
		clk,
		pause_pipeline
	);
	
	lidiMUXdiex <= 
		lidi2diex.B when (lidi2diex.Op >= "01100" and lidi2diex.Op <= "10000") -- bypass de op2 (imm/@) si ce n'est pas une valeur de reg2
	else
		rb_qa;
		
	-- aléas
	lidi_read <= (lidi2diex.Op >= "00000" and lidi2diex.Op <= "01110" and lidi2diex.Op /= "01101");
	diex_write <= (diex2exmem.Op >= "00000" and diex2exmem.Op <= "01110" and diex2exmem.Op /= "01101");
	exmem_write <= (exmem2memre.Op >= "00000" and exmem2memre.Op <= "01110" and exmem2memre.Op /= "01101");
	diex_conflict <= (lidi2diex.A = diex2exmem.A or lidi2diex.B = diex2exmem.A);
	exmem_conflict <= (lidi2diex.A = exmem2memre.A or lidi2diex.B = exmem2memre.A);
		
	pause_pipeline <=
		'1' when (lidi_read and diex_write and diex_conflict)
				or (lidi_read and exmem_write and exmem_conflict)
			else '0';
			
	noper <= "11111" when pause_pipeline='1' else lidi2diex.Op; -- NOPES if NOPING required
		
	diex: Pipeline PORT MAP (
		noper,
		lidi2diex.A,
		lidiMUXdiex,
		rb_qb,
		diex2exmem.Op,
		diex2exmem.A,
		diex2exmem.B,
		diex2exmem.C,
		clk,
		'0'
	);

   main_alu: ALU PORT MAP (
		 diex2exmem.B,
		 diex2exmem.C,
		 diex2exmem.Op,
		 S,
		 alu_flags
   );
	
	diexMUXexmem <=
		diex2exmem.B when (diex2exmem.Op >= "01100" and diex2exmem.Op <= "10000") -- bypass de op2 (imm/@) si ce n'est sortie d'ALU demandé
	else
		S;
	
	exmem: Pipeline PORT MAP (
		diex2exmem.Op,
		diex2exmem.A,
		diexMUXexmem,
		diex2exmem.C, -- bypass de opérande 1
		exmem2memre.Op,
		exmem2memre.A,
		exmem2memre.B,
		exmem2memre.C, -- pareil
		clk,
		'0'
	);	
	
	-- écriture RAM bit
	exmemLCmemre <=
		'1' when exmem2memre.Op = "01101" -- STORE
	else
		'0';
		
	-- sélection adresse RAM
	exmemMUXramsel <=
		exmem2memre.B when exmem2memre.Op = "01100" or exmem2memre.Op = "01101" -- READ/LOAD & SAVE/STORE
	else
		x"0000"; -- adresse 0 sinon
		
	-- sélection input RAM
	exmemMUXramdata <=
		exmem2memre.C when exmem2memre.Op = "01101" -- STORE: valeur de registre de l'opérande 1 dans le bypass C
	else
		x"0000"; -- donnée 0 sinon

	memre: Pipeline PORT MAP (
		exmem2memre.Op,
		exmem2memre.A,
		exmem2memre.B,
		x"0000",
		memre2regb.Op,
		memre2regb.A,
		memre2regb.B,
		open,
		clk,
		'0'
	);	
	
	-- bit d'enregistrement de la banque de registres
	memreLCregb <=
		'0' when (memre2regb.Op = "01101" or memre2regb.Op = "01111" or memre2regb.Op = "10000" or memre2regb.Op = "11111") -- STORE JCVD JUMP NOPE
	else
		'1';
		
	-- mux entrée de banque de registre
	memreMUXregb <=
		ram_in when memre2regb.Op = "01100" -- LOAD
	else
		memre2regb.B; -- résultats ALU ou immédiat
	
	regb: RegBank PORT MAP(
		lidi2diex.B(3 downto 0),
		lidi2diex.C(3 downto 0),
		rb_qa,
		rb_qb,
		memre2regb.A(3 downto 0),
		memreLCregb,
		rst,
		memreMUXregb,
		clk
	);
	
	ram: data PORT MAP (
		clk,
		ram_in,
      exmemLCmemre,
      exmemMUXramsel,
      exmemMUXramdata
	);
	
end Behavioral;

