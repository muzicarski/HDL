----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2017 06:30:35 PM
-- Design Name: 
-- Module Name: s2p_converter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity s2p_converter is
  generic (WIDTH : natural := 4);
  Port (clk : in std_logic;
        si : in std_logic;
        q : out std_logic_vector(WIDTH-1 downto 0) );
end s2p_converter;

architecture Behavioral of s2p_converter is

signal count_s : std_logic_vector (WIDTH-1 downto 0) := (others => '0');
--variable counter : natural := 1;
signal counter : integer := 1;
signal prescaled_clk : std_logic := '0';

begin

convert:process(clk) is
--variable counter : natural := 1;
    begin
 --       for i in 0 to (WIDTH-1) loop
            if rising_edge(clk) then
                if counter < WIDTH then
                    count_s <= (si & count_s(WIDTH-1 downto 1));
                    counter <= counter + 1;
                    prescaled_clk <='0';
--                    if counter=1 then
--                        q <= count_s;
--                    end if;
                else
                    count_s <= (si & count_s(WIDTH-1 downto 1));
                    counter <= 1;
                    prescaled_clk <= '1';
                end if;
            end if;
 --       end loop;
        
end process convert;

write_out:process(prescaled_clk) is
    begin
        if rising_edge(prescaled_clk) then
            q <= count_s;
        end if;
    end process write_out;


end Behavioral;
