----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2021 02:17:45 PM
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
    Port(
        op_sel : in STD_LOGIC_VECTOR (1 downto 0);
        in1 : in signed (7 downto 0);
        in2 : in signed (7 downto 0);
        out1 : out signed (7 downto 0);
        a0 : in std_logic;
        a1 : in std_logic;
        a2 : in std_logic;
        a3 : in std_logic;
        b : out std_logic
    );
end main;

architecture Behavioral of main is
    component and2_logic is
        Port ( a : in STD_LOGIC;
             b : in STD_LOGIC;
             c : out STD_LOGIC);
    end component;

    component ALU is
        Port ( op_sel : in STD_LOGIC_VECTOR (1 downto 0);
             a : in signed (7 downto 0);
             b : in signed (7 downto 0);
             c : out signed (7 downto 0));
    end component;

    signal n1:std_logic;
    signal n2:std_logic;

begin

    alu_inst1:ALU port map (op_sel,in1,in2,out1);

    and2_inst1:and2_logic port map(a => a1, b => a0, c => n1);
    and2_inst2:and2_logic port map(a => a2, b => a3, c => n2);
    and2_inst3:and2_logic port map(a => n1, b => n2, c => b);

end Behavioral;
