----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2017 12:42:46 PM
-- Design Name: 
-- Module Name: dec_counter_tb - Behavioral
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

entity dec_counter_tb is
--  Port ( );
end dec_counter_tb;

architecture Behavioral of dec_counter_tb is

signal clk_s, en_s, reset_s, pulse_s : std_logic;
signal count_out_s : std_logic_vector(3 downto 0);

component dec_counter
   Port (clk : in std_logic;
        reset: in std_logic;
        en : in std_logic;
        q_out : out std_logic_vector(3 downto 0);
        pulse : out std_logic );
end component;

constant clk_period : time := 10ns;

begin

UUT: dec_counter port map(clk_s, reset_s, en_s, count_out_s, pulse_s);

clk:process     
    begin
        clk_s <= '0';
        wait for clk_period/2;
        clk_s<='1';
        wait for clk_period/2;
end process;

enabling:process
    begin
        reset_s<='1';
        en_s<='1';
        wait for 40ns;
        reset_s<='0';
        wait;
end process enabling;

end Behavioral;
