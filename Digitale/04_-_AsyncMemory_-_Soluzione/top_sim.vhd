library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.NUMERIC_STD.ALL;

entity top_sim is
--  Port ( );
end top_sim;

architecture Behavioral of top_sim is

    constant clk_period : time := 10ns;
	constant MEM_BIT_WIDTH  : integer := 8;
	constant MEM_BIT_LENGTH : integer := 2;

	component MyMemory is
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
    end component;
		
	signal clk, reset : std_logic := '0';
	
	signal input_data_int, output_data_int : integer := (2**MEM_BIT_WIDTH)-1;
	signal input_addr_int, output_addr_int : integer := 0;
	
	signal input_data, output_data : std_logic_vector(MEM_BIT_WIDTH-1 DOWNTO 0);
	signal input_addr, output_addr : std_logic_vector(MEM_BIT_LENGTH-1 DOWNTO 0);	
	signal input_en : std_logic := '0';

	
begin
    
    clk <= not clk after clk_period/2;
    
	DUT : MyMemory
            Generic Map(
                WORD_DIM => MEM_BIT_WIDTH,
                ADDR_DIM => MEM_BIT_LENGTH
            )
            Port Map(
                reset => reset,
                clk => clk,
                
                wr_data => input_data,
                wr_addr => input_addr,
                
                rd_data => output_data,
                rd_addr => output_addr
            );
	
	input_data <= std_logic_vector(to_unsigned(input_data_int, input_data'LENGTH));
	output_data_int <= to_integer(unsigned(output_data));
	input_addr <= std_logic_vector(to_unsigned(input_addr_int, input_addr'LENGTH));
	output_addr <= std_logic_vector(to_unsigned(output_addr_int, output_addr'LENGTH));


	process
	begin
	    
	    wait until rising_edge(clk);
	    
		while (input_addr_int < 2**MEM_BIT_LENGTH-1) loop
			wait until rising_edge(clk);
			input_data_int <= input_data_int - 1;
            input_addr_int <= input_addr_int + 1;
		end loop;
		
		wait until rising_edge(clk);
		input_en <= '0';
		input_addr_int <= 0;
		wait until rising_edge(clk);
		
		
		while (input_addr_int < 2**MEM_BIT_LENGTH-1) loop
            wait until rising_edge(clk);
            input_data_int <= input_data_int - 1;
            input_addr_int <= input_addr_int + 1;
        end loop;
                
        wait until rising_edge(clk);
        input_en <= '0';
        input_addr_int <= 0;        
	    wait for 50ns;
		
		while (output_addr_int < 2**MEM_BIT_LENGTH-1) loop
			wait until rising_edge(clk);
			output_addr_int <= output_addr_int + 1;
		end loop;
		
		wait;
		
	end process;
	
end Behavioral;
