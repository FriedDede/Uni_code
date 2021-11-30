----------------------------------------------------------------------------------
-- Company: Poli
-- Engineer: Andrea Motta
-- 
-- Create Date: 11/30/2021 05:48:42 PM
-- Design Name: Basic PWM
-- Module Name: PWM - Behavioral

-- Revision 1 - Passed validation
-- Additional Comments:
--      Attenzione a lavorare con i process, il signal commitment è solo alla fine
--      la macchina in questo caso allunga tutti i cicli di 1 (es. t_on = 2, pwm sta HIGH 3 cicli)
--      perchè elapsed conta da 0, 'elapsed = 2' lo troviamo alla terza iterazione e
--      il risultato viene committed al quarto rise (contando da 1):
-- es: t_total = 03 t_on = 02
--
--      clk     __--__--__--__--__--__--__--__--
--  elapsed     00  01  02  03  00  01  02  03
--      pwm     UU------------____------------__
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

entity PWM is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           t_on : in STD_LOGIC_VECTOR (8-1 downto 0);
           t_total : in STD_LOGIC_VECTOR (8-1 downto 0);
           pwm_out : out STD_LOGIC);
end PWM;

architecture Behavioral of PWM is
    signal elapsed : std_logic_vector(8-1 downto 0) := (Others => '0');
    signal t_on_cache : std_logic_vector(8-1 downto 0) := t_on;
    signal t_total_cache : std_logic_vector(8-1 downto 0) := t_total;
begin
    pwm : process
    begin
        -- increase elapsed time every clk rise
        elapsed <= std_logic_vector(unsigned(elapsed)+1);
        -- reset everything to default
        if reset = '1' then
            elapsed <= (Others => '0');
            pwm_out <= '1';
            t_on_cache <= t_on;
            t_total_cache <= t_total;
        end if;
        -- fall pwm_out
        if elapsed = t_on_cache then
            pwm_out <= '0';
        end if;
        -- rise pwm out, reset elapsed time
        if elapsed = t_total_cache then
            pwm_out <= '1';
            elapsed <= (Others => '0');
            t_total_cache <= t_total;
            t_on_cache <= t_on;
        end if;
        wait until rising_edge(clk);
    end process ; -- pwm
end Behavioral;