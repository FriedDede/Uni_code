library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;

entity MyMemory is
    Generic(
        WORD_DIM : integer := 8;
        ADDR_DIM : integer := 2 --Bits of addr space
    );
    Port ( 
    
        reset : in std_logic;
        clk : in std_logic;
        
        wr_data     : in  std_logic_vector(WORD_DIM-1 DOWNTO 0);
        wr_addr     : in  std_logic_vector(ADDR_DIM-1 DOWNTO 0); --Unsigned
        
        rd_data     : out std_logic_vector(WORD_DIM-1 DOWNTO 0);
        rd_addr     : in  std_logic_vector(ADDR_DIM-1 DOWNTO 0)  --Unsigned
        
    );
end MyMemory;

architecture Behavioral of MyMemory is
	-- Use 2** to perform the 2^ operation
   
begin

 

end Behavioral;
