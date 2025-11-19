library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tl_core is
    port(
        adc_clk     : in  std_logic;
        led_controller : out std_logic_vector(7 downto 0) := (others => '0'); 
        tick_count_out : out STD_LOGIC_VECTOR(31 downto 0) := (others => '0') 
    );
end entity tl_core;

architecture behavior of tl_core is
    constant clk_frequency : integer:=125_000_000; --125MHz clock
    constant tick_max : integer := clk_frequency - 1;

    -- generates 1 tick/sec
    signal tick_count : integer range 0 to tick_max := 0;
    signal tick : STD_LOGIC := '0';

    --time constants
    constant time_red : integer := 1;
    constant time_green : integer := 1;
    constant time_yellow : integer := 1;

    -- declaring state machine types
    type state_type is (RED, GREEN, YELLOW);
    signal state : state_type := RED;
    signal timer : integer range 0 to 60 := 0;
    
    -- this process generates a 1 Hz tick
    begin

        tick_count_out <= STD_LOGIC_VECTOR(to_unsigned(tick_count,tick_count_out'length));

        process(adc_clk)
        begin
            if rising_edge(adc_clk) then
                if tick_count = tick_max then
                    tick_count <= 0;
                    tick <= '1';
                else 
                    tick_count <= tick_count +1;
                    tick <= '0';
                end if;
            end if;
        end process;

        --REAL STATE MACHINE GOES HERE!!! :P
        process(adc_clk)
        begin
            if rising_edge(adc_clk) then

                if tick = '1' then
                    -- Increment timer once per second
                    timer <= timer + 1;
                    case state is 

                        when RED =>
                            if timer >= time_red then
                                state <= GREEN;
                                timer <= 0;
                            end if;
                        when GREEN =>
                            if timer >= time_green then
                                state <= YELLOW;
                                timer <= 0;
                            end if;
                        when YELLOW =>
                            if timer >= time_yellow then
                                state <= RED;
                                timer <= 0;
                            end if;
                    end case;
                end if;
            end if;
        end process;


        -- LED CONTROLLER LOGIC
        -- for reference
        --red          <= '0'; 
        --yellow       <= '0';
        --green        <= '0';
        --ctrl         <= '0';
        --left_arrow_yellow  <= '0';
        --left_arrow_green   <= '0';   
        --right_arrow_yellow <= '0';
        --right_arrow_green  <= '0';

                with state select led_controller <= 
                    "10000000" when RED,      -- red ON
                    "00100000" when GREEN,    -- green ON
                    "01000000" when YELLOW,   -- yellow ON
                    "10000000" when others;   -- default red

end architecture behavior;