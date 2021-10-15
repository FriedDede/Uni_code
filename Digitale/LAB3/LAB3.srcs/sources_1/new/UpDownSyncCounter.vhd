-- Company: 
-- Engineer: 
-- ----------------------------------------------------------------------------------

-- Create Date: 10/14/2021 12:18:33 PM
-- Design Name: 
-- Module Name: UpDownSyncCounter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.numeric_std.all;

entity UpDownSyncCounter is
    generic(
    COUNT_WIDTH : integer := 4
    );
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           inc_count : in STD_LOGIC;
           dec_count : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (COUNT_WIDTH-1 downto 0));
end UpDownSyncCounter;

architecture Behavioral of UpDownSyncCounter is
    component ff_d is
        Port(
            reset	: in std_logic;
            clk		: in std_logic;
    
            d 	:	in std_logic;
            q 	: out std_logic
        );
    end component;
    component preDemux is
        generic(
        COUNT_WIDTH : integer := 4
        );
        Port ( curr_counter : in STD_LOGIC_VECTOR (COUNT_WIDTH -1 downto 0);
               decrease : out STD_LOGIC_VECTOR (COUNT_WIDTH -1 downto 0);
               increase : out STD_LOGIC_VECTOR (COUNT_WIDTH -1 downto 0);
               inc_count : in STD_LOGIC;
               dec_count : in STD_LOGIC
           );
               
    end component;
    
    signal external_count : std_logic_vector (COUNT_WIDTH-1 downto 0);
    signal internal_count : std_logic_vector (COUNT_WIDTH-1 downto 0);
    signal internal_count_up : std_logic_vector (COUNT_WIDTH-1 downto 0);
    signal internal_count_down : std_logic_vector (COUNT_WIDTH-1 downto 0);
begin
    REG: for i in COUNT_WIDTH-1 downto 0 generate
        inst_ff:ff_d port map(
            reset,
            clk,
            internal_count(i),
            external_count(i)
        );
    end generate;
    
    count <= external_count;
    
    internal_count_up <= std_logic_vector( signed(external_count) + 1) when inc_count = '1';
    internal_count_down <= std_logic_vector( signed(external_count) - 1) when dec_count = '1';
    
    internal_count <= external_count when inc_count = dec_count else
        internal_count_up when inc_count = '1' else
        internal_count_down when dec_count = '1';
        
end Behavioral;
