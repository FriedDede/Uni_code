----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2021 02:52:51 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( op_sel : in STD_LOGIC_VECTOR (1 downto 0);
           a : in signed (7 downto 0);
           b : in signed (7 downto 0);
           c : out signed (7 downto 0));
end ALU;

architecture Behavioral of ALU is
    signal add,sub  : signed (7 downto 0);
    signal mul      : signed (15 downto 0);
begin
    add <= a + b;
    sub <= a - b;
    mul <= a * b;
    
    with op_sel select c <= add when "00",
                            sub when "01",
                            mul(c'RANGE) when "10",
                            (others => '0') when "11";
end Behavioral;
