----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/27/2021 12:24:59 PM
-- Design Name: 
-- Module Name: Adder_4bit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder_4bit is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           cin: in std_logic := '0';
           sum : out STD_LOGIC_VECTOR (3 downto 0);
           cout : out std_logic);
end Adder_4bit;

architecture Behavioral of Adder_4bit is
component Full_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           cout : out STD_LOGIC;
           s : out STD_LOGIC);
end component;
    signal c1 : std_logic;
    signal c2 : std_logic;
    signal c3 : std_logic;
begin
    fa0_inst:Full_adder port map(a(0), b(0), cin, c1, sum(0));
    fa1_inst:Full_adder port map(a(1), b(1), c1, c2, sum(1));
    fa2_inst:Full_adder port map(a(2), b(2), c2, c3, sum(2));
    fa3_inst:Full_adder port map(a(3), b(3), c3, cout, sum(3));
    
end Behavioral;
