-- Test bench for the SetVolts vhdl module
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library UNISIM;
use UNISIM.vcomponents.all;

entity tl_test is


end entity tl_test; --test

architecture testbench of main_tb is
    component design_1_wrapper is
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        led_controller : out std_logic_vector(7 downto 0)
    );
    end component design_1_wrapper;

    signal clk       : std_logic                     := '0';
    signal rst       : std_logic                     := '0';
    signal led_controller       : std_logic_vector(7 downto 0):= (others => '0');

  -- Clock periods
  constant adc_clk_period : time := 8 ns;

begin
    uut : design_1_wrapper
    port map (
        clk       => adc_clk,
        rst       => clk_rst,
        led_controller => led_controller
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

