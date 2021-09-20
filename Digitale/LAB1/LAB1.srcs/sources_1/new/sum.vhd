----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2021 02:35:33 PM
-- Design Name: 
-- Module Name: sum - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sum is
    generic (
        INP_WIDTH: integer := 8;
        OUT_WIDTH: integer := 10
    );
    Port ( a : in signed (INP_WIDTH-1 downto 0);
           b : in signed (INP_WIDTH-1 downto 0);
           c : out signed (OUT_WIDTH-1 downto 0));
end sum;

architecture Behavioral of sum is
    signal temp : signed (INP_WIDTH downto 0);
begin
    assert INP_WIDTH < OUT_WIDTH
        report "input width > out width"
        severity error;

    temp <= (a(a'HIGH)&a) + (b(b'HIGH)&b);
    c   <= (temp'RANGE => temp, others => temp(temp'HIGH));

end Behavioral;
