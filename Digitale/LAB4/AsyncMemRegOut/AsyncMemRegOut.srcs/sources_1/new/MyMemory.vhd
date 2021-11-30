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

    component MyRegister is
        Port ( 
        
            reset   : in std_logic;
            clk     : in std_logic;
            
            D   : in  std_logic_vector;
            Q   : out std_logic_vector
            --D'RANGE == Q'RANGE
        );
    end component;
    
    type mem_type is array (0 TO 2**wr_addr'LENGTH-1) of std_logic_vector(wr_data'RANGE);
    signal mem : mem_type := (Others => (Others => '0'));
    signal wr_addr_int, rd_addr_int : integer range 0 TO 2**wr_addr'LENGTH-1;
    
    signal rd_data_int : std_logic_vector(rd_data'RANGE);
    
begin

    mem(to_integer(unsigned(wr_addr))) <= wr_data;
    
    
    rd_data_int <= mem(to_integer(unsigned(rd_addr)));
    
    out_reg_inst : MyRegister
        Port Map( 
        
            reset   => reset,
            clk     => clk,
            
            D => rd_data_int,
            Q => rd_data
        );


end Behavioral;
