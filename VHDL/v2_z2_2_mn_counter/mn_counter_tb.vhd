----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2017 06:04:22 PM
-- Design Name: 
-- Module Name: mn_counter_tb - Behavioral
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

entity mn_counter_tb is
--  Port ( );
end mn_counter_tb;

architecture Behavioral of mn_counter_tb is

--counter: entity work.p_counter(Behavioral)
--    generic(WIDTH : natural := 8;
--         M : integer := 0;
--         N : integer := 255);
--    Port (clk : in std_logic;
--       reset : in std_logic;
--       en : in std_logic;
--       count : out std_logic_vector(WIDTH-1 downto 0));
--end component;

signal clk_s : std_logic;
signal count_s : std_logic_vector (7 downto 0);
signal reset_s : std_logic;
signal en_s : std_logic;

constant clk_period : time := 20 ns;

begin

uut: entity work.p_counter(Behavioral)
    generic map(WIDTH => 8,
                M => 0,
                N => 122)

    port map (clk => clk_s,
              reset => reset_s,
              en => en_s,
              count => count_s);
              
              
clock:process
    begin
        clk_s<='0';
        wait for clk_period/2;
        clk_s <= '1';
        wait for clk_period/2;
end process clock;

drive:process
    begin
        wait until falling_edge(clk_s);
        wait until falling_edge(clk_s);
        reset_s <= '1';
        wait until falling_edge(clk_s);
        reset_s <= '0';
        en_s <= '1';
        wait;
end process drive;


end Behavioral;
