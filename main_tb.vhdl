-------------------------------------------------------------------------------
-- Test bench for the Stoplight Controller
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library UNISIM;
use UNISIM.vcomponents.all;

entity tl_test is

end entity tl_test;

architecture testbench of tl_test is
    component tl_core is
    port (
        adc_clk     : in  std_logic;
--        time_red : in  std_logic_vector(31 downto 0); -- red light time duration
--        time_green : in  std_logic_vector(31 downto 0); -- green light time duration
--        time_yellow : in  std_logic_vector(31 downto 0); -- yellow light time duration
        
--        clock_out : out std_logic_vector(29 downto 0) := (others => '0'); -- clock counter output
        led_controller : out std_logic_vector(7 downto 0) := (others => '0'); 
--        cycles : out std_logic_vector(7 downto 0) := (others => '0'); -- counts clock cycles
--       milliseconds : out std_logic_vector(9 downto 0) := (others => '0');
--        seconds : out std_logic_vector(5 downto 0) := (others => '0');
    );
    end component tl_core;

    signal adc_clk : std_logic := '0';
   -- signal time_red : std_logic_vector(31 downto 0) := (others => '0'); 
    --signal time_green : std_logic_vector(31 downto 0) := (others => '0'); 
    --signal time_yellow : std_logic_vector(31 downto 0) := (others => '0'); 
        
    --signal clock_out : std_logic_vector(29 downto 0) := (others => '0'); 
    signal led_controller : std_logic_vector(7 downto 0) := (others => '0'); 
    --signal cycles : std_logic_vector(7 downto 0) := (others => '0'); 
    --signal milliseconds : std_logic_vector(9 downto 0) := (others => '0');
    --signal seconds : std_logic_vector(5 downto 0) := (others => '0');

  -- 125Mhz clock w/ 8ns period
  constant adc_clk_period : time := 8 ns;

begin
    uut : tl_core
    port map (
        adc_clk       => adc_clk,
        --rst       => clk_rst,
        led_controller => led_controller,

        );


  adc_clk_process : process
  begin
    adc_clk <= '0';
    wait for adc_clk_period/2;
    adc_clk <= '1';
    wait for adc_clk_period/2;
  end process;


--    stoplight : process
--    begin

--    end process stoplight;

end architecture testbench; 

-------------------------------------------------------------------------------