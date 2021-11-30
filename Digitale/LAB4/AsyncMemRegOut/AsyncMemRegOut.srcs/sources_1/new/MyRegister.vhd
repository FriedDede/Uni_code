library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity MyRegister is
    Port ( 
    
        reset   : in std_logic;
        clk     : in std_logic;
        
        D   : in  std_logic_vector;
        Q   : out std_logic_vector
        --D'RANGE == Q'RANGE
    );
end MyRegister;

architecture Behavioral of MyRegister is

    component ff_d is
        Port(
            reset	: in std_logic;
            clk		: in std_logic;
    
            d 	:	in std_logic;
            q 	: out std_logic
        );
    end component;

begin

    reg_gen : for I in D'RANGE generate
        
        ff_d_inst : ff_d
            Port Map(
                reset   => reset,
                clk     => clk,
        
                d => D(I),
                q => Q(I)
            );
    
    end generate;

end Behavioral;
