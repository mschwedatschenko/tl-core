library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tl_test is
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        led_controller : out std_logic_vector(7 downto 0)
    );

end entity tl_test;

architecture testbench of main_tb is
begin
    stoplight : process
    begin

    end process stoplight;

end architecture testbench; 

