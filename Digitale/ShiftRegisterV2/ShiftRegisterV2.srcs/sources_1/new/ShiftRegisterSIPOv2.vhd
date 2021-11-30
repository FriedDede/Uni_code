library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.NUMERIC_STD.ALL;

entity ShiftRegisterSIPOv2 is
	Port(
		reset	: in std_logic;
		clk		: in std_logic;

		data_in		: in std_logic;
		
		--data_out range is (X DOWNTO 0) where X >0
		data_out	: out std_logic_vector
	);
end ShiftRegisterSIPOv2;

architecture Behavioral of ShiftRegisterSIPOv2 is

	signal data_out_internal : std_logic_vector(data_out'RANGE) := (Others => '0');

begin

	data_out <= data_out_internal;

	process (clk, reset)
	begin
		if reset = '1' then
			data_out_internal <= (Others => '0');
		elsif rising_edge(clk) then
			data_out_internal <= data_in & data_out_internal(data_out_internal'LEFT DOWNTO 1);
			
			--Or in the same way
			--data_out_internal(data_out_internal'LEFT) <= data_in;
			--data_out_internal(data_out_internal'LEFT-1 DOWNTO 0) <= data_out_internal(data_out_internal'LEFT DOWNTO 1);
			
		end if;
	end process;

end Behavioral;
