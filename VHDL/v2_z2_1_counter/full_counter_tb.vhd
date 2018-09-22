----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2017 11:38:25 AM
-- Design Name: 
-- Module Name: full_counter_tb - Behavioral
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

entity full_counter_tb is
--  Port ( );
end full_counter_tb;

architecture Behavioral of full_counter_tb is

component full_counter
    port(clk,reset,en_full : in std_logic;
         count : out std_logic_vector(11 downto 0);
         pulse : out std_logic);
end component;

signal clk_s, reset_s, en_s : std_logic;
signal count_s : std_logic_vector(11 downto 0);
signal pulse_s : std_logic;

constant clk_period : time :=10ns;

begin

UUT : full_counter port map (clk_s, reset_s, en_s, count_s, pulse_s);

clock:process
    begin
         clk_s<='0';
        wait for clk_period/2;
        clk_s <= '1';
        wait for clk_period/2;
    end process clock;
    
assignment:process 
    begin
        reset_s <='1';
        en_s <='1';
        wait for 50ns;
        reset_s<='0';
        wait;
    end process;


end Behavioral;
