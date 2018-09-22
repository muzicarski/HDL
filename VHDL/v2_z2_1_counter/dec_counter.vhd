----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2017 05:22:08 PM
-- Design Name: 
-- Module Name: dec_counter - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dec_counter is
  Port (clk : in std_logic;
        reset: in std_logic;
        en : in std_logic;
        q_out : out std_logic_vector(3 downto 0);
        pulse : out std_logic );
end dec_counter;

architecture Behavioral of dec_counter is
signal q_s : unsigned(3 downto 0);-- := (others =>'0');
signal pulse_s : std_logic := '0';

begin
count:process(clk)
    begin
--        if  then
            if reset='1' then
 --               if en = '1' then
                    q_s<= (others =>'0');
                    pulse_s <= '0';
--                end if;
         elsif (rising_edge(clk) and en='1') then
            if(q_s = "1001") then
                q_s <="0000";
                pulse_s <='1';
            else
                q_s <= q_s + 1;
                pulse_s <= '0';
            end if;
          else 
            q_s <= q_s;
             pulse_s <= '0';
          end if;
--       end if;
end process count;

q_out<=std_logic_vector(q_s);
pulse <= pulse_s;
    

end Behavioral;
