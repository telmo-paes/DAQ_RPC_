library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
    Port (
        clk         :   in  STD_LOGIC;
        rst         :   in  STD_LOGIC;
        tx_start    :   in  STD_LOGIC;
        tx_data     :   in  STD_LOGIC_VECTOR(7 downto 0);
        tx_busy     :   out STD_LOGIC;
        tx_line     :   out STD_LOGIC
    );
end uart_tx;

architecture Behavioral of uart_tx is
    constant CLK_FREQ       : integer := 5000000000;
    constant BAUD_RATE      : integer := 115200;
    constant BAUD_TICKS     : integer := CLK_FREQ / BAUD_RATE;

    type state_type is (IDLE, START, DATA, STOP);
    signal state            : state_type := IDLE;
    signal baud_counter     : integer := 0;
    signal bit_index        : integer range 0 to 7 := 0;
    signal shift_reg        : STD_LOGIC_VECTOR(7 downto 0);
    signal tx               : STD_LOGIC := '1';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            case state is
                when IDLE => tx <= '1';
                    tx_busy <= '0';
                    if tx_start = '1' then
                        shift_reg <= tx_data;
                        baud_counter <= '0';
                        bit_index <= '0';
                        tx_busy <= '1';
                        state <= START;
                    end if;

                when START => tx <= '0';
                    if baud_counter = BAUD_TICKS-1 then
                        baud_counter <= 0;
                        state <= DATA;
                    else
                        baud_counter <= baud_counter + 1;
                    end if;

                when DATA => tx <= shift_reg(bit_index);
                    if baud_counter = BAUD_TICKS-1 then
                        baud_counter <= 0;
                        if bit_index = 7 then
                            state <= STOP;
                        else
                            bit_index <= bit_index + 1;
                        end if;
                        
                when STOP => tx <= '1';
                    if baud_counter = BAUD_TICKS-1 then
                        baud_counter <= 0;
                        state <= IDLE;
                    else
                        baud_counter <= baud_counter + 1;
                    end if;
            end case;
        end if;
    end process;

    tx_line <= tx;

end Behavioral;
