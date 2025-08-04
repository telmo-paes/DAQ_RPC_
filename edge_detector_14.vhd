library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity edge_detector is
    Port (
        clk         :   in  STD_LOGIC;
        strips_in   :   in  STD_LOGIC_VECTOR(13 downto 0);
        edges_out   :   out STD_LOGIC_VECTOR(13 downto 0)
    );
end edge_detector;

architecture Behavioral of edge_detector is
    signal prev_state   :   STD_LOGIC_VECTOR(13 downto 0) := (others => '0');
begin

    process(clk)
    begin
        if rising_edge(clk) then
            for i in 0 to 13 loop
                edges_out(i) <= '1' when (strips_in(1) = '1' and prev_state(i) = '0') else '0';
            end loop;
            prev_state <= strips_in;
        end if;
    end process;

end Behavioral;