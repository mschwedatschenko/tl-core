library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tl_core is
    port(
        adc_clk     : in  std_logic;
        time_red : in  std_logic_vector(31 downto 0); -- red light time duration
        time_green : in  std_logic_vector(31 downto 0); -- green light time duration
        time_yellow : in  std_logic_vector(31 downto 0); -- yellow light time duration
        
        clock_out : out std_logic_vector(29 downto 0) := (others => '0'); -- clock counter output
        led_controller : out std_logic_vector(7 downto 0) := (others => '0'); 
        cycles : out std_logic_vector(7 downto 0) := (others => '0'); -- counts clock cycles
        milliseconds : out std_logic_vector(9 downto 0) := (others => '0');
        seconds : out std_logic_vector(5 downto 0) := (others => '0');
    );
end entity tl_core;

architecture behavior of tl_core is
    signal clock_cycles : integer range 0 to 125 := 0;
    signal ms : integer range 0 to 1000 := 0; 
    signal sec : integer range 0 to 60 := 0;
    
    begin
        process(adc_clk) -- counts cycles, then ms, then sec
        begin
            if rising_edge(adc_clk) then
                if(clock_cycles < 125) then -- 125 cycles = 1 ms at 125MHz clock
                    clock_cycles <= clock_cycles + 1; 
                    else
                    clock_cycles <= 0;
                    if ms < 1000 then
                        ms <= ms + 1; -- milliseconds increment by 1
                    else
                        ms <= 0; -- reset millisecond counter
                        if(sec < 60) then
                            sec <= sec + 1; -- increment second counter by 1

                        else
                        sec <= 0; -- reset second counter
                        end if;
                    end if;
                end if;
                else
                    clock_cycles <= clock_cycles + 1;
            end if;
                cycles <= std_logic_vector(to_unsigned(clock_cycles, 8)); 
                clock_out <= std_logic_vector(to_unsigned(clock_cycles, 30)); -- output clock cycles
                milliseconds <= std_logic_vector(to_unsigned(ms, 10));
                seconds <= std_logic_vector(to_unsigned(sec, 6));
        end process;

        -- for reference
        --red          <= '0'; 
        --yellow       <= '0';
        --green        <= '0';
        --ctrl         <= '0';
        --left_arrow_yellow  <= '0';
        --left_arrow_green   <= '0';   
        --right_arrow_yellow <= '0';
        --right_arrow_green  <= '0';
        traffic_light_controller: process(sec, ms) is
        begin
            case sec is
            when 0 to 9 =>
                led_controller <= "10000000"; -- Red on
            when 10 to 19 =>
                led_controller <= "00100000"; -- Green on
            when 20 to 22 =>
                led_controller <= "01000000"; -- Yellow on
            when others =>
                led_controller <= "10000000"; -- Default red
        end case;
        end process traffic_light_controller;
end architecture behavior;