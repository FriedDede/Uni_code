----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2021 12:35:07 PM
-- Design Name: 
-- Module Name: ShiftRegisterSIPO - Behavioral
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

entity ShiftRegisterSIPO is
    generic(
        SR_WIDTH:integer:=4
    );
    
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           data_in : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (SR_WIDTH-1 downto 0));
end ShiftRegisterSIPO;

architecture Behavioral of ShiftRegisterSIPO is
component ff_d is
	Port(
		reset	: in std_logic;
		clk		: in std_logic;

		d 	:	in std_logic;
		q 	: out std_logic
	);
end component;
 signal intern_data:std_logic_vector(SR_WIDTH downto 0);
begin
   intern_data(SR_WIDTH) <= data_in;
   
   LOOP_FF_GEN: for i in SR_WIDTH-1 downto 0 generate
        inst_ff:ff_d port map (
            reset,
            clk,
            intern_data(i+1),
            intern_data(i)
        );
        data_out(i)<=intern_data(i);
   end generate;
   
end Behavioral;
