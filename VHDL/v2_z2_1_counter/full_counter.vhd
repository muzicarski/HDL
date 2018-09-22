----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2017 06:37:50 PM
-- Design Name: 
-- Module Name: full_counter - Behavioral
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

entity full_counter is
  Port (clk : in std_logic;
        reset : in std_logic;
        en_full : in std_logic;
        count : out std_logic_vector(11 downto 0);
        pulse : out std_logic );
end full_counter;

architecture Struct of full_counter is
signal count_s : std_logic_vector(11 downto 0);
signal clk_s : std_logic_vector (1 downto 0);

component dec_counter is
Port (clk : in std_logic;
        reset: in std_logic;
        en : in std_logic;
        q_out : out std_logic_vector(3 downto 0);
        pulse : out std_logic );
end component dec_counter;    
begin
c1:component dec_counter
port map(clk, reset, en_full, count_s(3 downto 0),clk_s(0));

c2:component dec_counter
port map(clk_s(0), reset, en_full, count_s(7 downto 4),clk_s(1));

c3:component dec_counter
port map(clk_s(1), reset, en_full, count_s(11 downto 8), pulse);


end Struct;
