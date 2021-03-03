----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 13:57:34
-- Design Name: 
-- Module Name: tb_hex_7seg - Behavioral
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

entity tb_hex_7seg is
--  Port ( );
end tb_hex_7seg;

architecture Behavioral of tb_hex_7seg is

    signal s_hex_i : std_logic_vector (4 - 1 downto 0);
    signal s_seg_o : std_logic_vector (7 - 1 downto 0);

begin
    uut_hex_7seg : entity work.hex_7seg
        port map(
            hex_i => s_hex_i,
            seg_o => s_seg_o
        );
        
        p_stimulus : process
        begin
            report "simulation start" severity note;
            
            
            s_hex_i <= "0000"; wait for 100 ns;
            s_hex_i <= "0001"; wait for 100 ns;
            s_hex_i <= "0010"; wait for 100 ns;
            s_hex_i <= "0011"; wait for 100 ns;
            s_hex_i <= "0100"; wait for 100 ns;
            s_hex_i <= "0101"; wait for 100 ns;
            s_hex_i <= "0110"; wait for 100 ns;
            s_hex_i <= "0111"; wait for 100 ns;
            s_hex_i <= "1000"; wait for 100 ns;
            s_hex_i <= "1001"; wait for 100 ns;
            s_hex_i <= "1010"; wait for 100 ns;
            s_hex_i <= "1011"; wait for 100 ns;
            s_hex_i <= "1100"; wait for 100 ns;
            s_hex_i <= "1101"; wait for 100 ns;
            s_hex_i <= "1110"; wait for 100 ns;
            s_hex_i <= "1111"; wait for 100 ns;
            
            
            report "simulation end" severity note;
            wait;    
        end process p_stimulus;

end Behavioral;
