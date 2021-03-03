----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 14:02:47
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port( 
        SW : in std_logic_vector(4 - 1 downto 0);
        LED : out std_logic_vector(8 - 1 downto 0);
        CA : out std_logic;
        CB : out std_logic;
        CC : out std_logic;
        CD : out std_logic;
        CE : out std_logic;
        CF : out std_logic;
        CG : out std_logic;
        AN : out std_logic_vector(8 - 1 downto 0)
    );
end top;

architecture Behavioral of top is
-- instantion 
begin
    hex2seg : entity work.hex_7seg
        port map(
            hex_i => SW,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG

        );
        -- connect one common anode to 3,3V
        AN <= b"1111_0111";
        
        -- dysplay
        LED(3 downto 0) <= SW;
        LED(4) <= '1' when (SW = "0000") else '0';
        LED(5) <= '1' when (SW > "1001") else '0';
        LED(6) <= '1' when (SW(0) = '1') else '0';
        LED(7) <= '1' when (SW = "0001") or (SW = "0010")or (SW = "0100") or (SW = "1000") else '0';

end Behavioral;
