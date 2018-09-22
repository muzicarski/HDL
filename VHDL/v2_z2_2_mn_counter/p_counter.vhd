----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2017 05:22:15 PM
-- Design Name: 
-- Module Name: p_counter - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity p_counter is
 generic(WIDTH : natural := 8;
         M : unsigned := 0;
         N : unsigned := 255);
         
 Port (clk : in std_logic;
       reset : in std_logic;
       en : in std_logic;
       count : out std_logic_vector(WIDTH-1 downto 0));
end p_counter;

architecture Behavioral of p_counter is
signal count_s : unsigned(WIDTH-1 downto 0) := (others => '0');
begin


end Behavioral;
