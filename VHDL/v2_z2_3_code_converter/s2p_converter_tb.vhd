----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2017 06:51:33 PM
-- Design Name: 
-- Module Name: s2p_converter_tb - Behavioral
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

entity s2p_converter_tb is
--  Port ( );
end s2p_converter_tb;

architecture Behavioral of s2p_converter_tb is

signal si_s : std_logic;
signal q_s : std_logic_vector (3 downto 0);
signal clk_s : std_logic;

constant clk_period : time := 10 ns;

begin

s2p: entity work.s2p_converter(Behavioral)
    generic map(WIDTH => 4)
    port map(clk => clk_s,
             si => si_s,
             q => q_s);
             
clock: process
    begin
        clk_s <= '1';
        wait for clk_period/2;
        clk_s <= '0';
        wait for clk_period/2;
end process clock;


si_drive: process
    begin
        wait for clk_period;            -- da bi se malo randomizovalo kombinovanje
        wait until falling_edge(clk_s);
        si_s<='1';
        wait until falling_edge(clk_s);
        si_s <='0';
        wait until falling_edge(clk_s);
        si_s<='0';                      --dodela postoji da bi sa waveforma lakse brojao vrednosti
        wait until falling_edge(clk_s);
        si_s<='1';

end process si_drive;

end Behavioral;
