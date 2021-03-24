----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 21:08:49
-- Design Name: 
-- Module Name: tb_t_ff_rst - Behavioral
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

entity tb_t_ff_rst is
--  Port ( );
end tb_t_ff_rst;

architecture Behavioral of tb_t_ff_rst is

        constant c_clk : time    := 10 ns;
        
        signal s_clk     : std_logic;
        signal s_rst     : std_logic;
        signal s_t       : std_logic;
        signal s_q       : std_logic;
        signal s_q_bar   : std_logic;

begin
    uut_t_ff_rst : entity work.t_ff_rst
        port map(
            clk   => s_clk,   
            rst  => s_rst, 
            t     => s_t,  
            q     => s_q,    
            q_bar => s_q_bar
        );

    p_clk_gen : process
        begin
            while now < 750 ns loop         -- 75 periods of 100MHz clock
                s_clk <= '0';
                wait for c_clk / 2;
                s_clk <= '1';
                wait for c_clk / 2;
            end loop;
        wait;
    end process p_clk_gen;
    
    p_rst : process
        begin
            
            s_rst <= '0';
            wait for 0 ns;
            
            s_rst <= '1';
            wait for 10 ns;
            
            s_rst <= '0';
            wait for 118 ns;
            
            -- Reset activated
            s_rst <= '1';
            wait for 5 ns;
    
            s_rst <= '0';
            wait for 78 ns;
            
            s_rst <= '1';
            wait for 16 ns;
            
            
            
            wait;
    end process p_rst;
    
    p_stimulus : process
        begin
            report "Stimulus started" severity note;
            
            wait for 15 ns; -- toggle 0
            s_t  <= '1';
            
            wait for 15 ns; -- no change 1
            s_t  <= '0';
            
            wait for 15 ns; -- toggle 1
            s_t  <= '1';
            
            wait for 15 ns; -- no change 0
            s_t  <= '0';
            
            wait for 15 ns; -- toggle 0
            s_t  <= '1';
                        
            wait for 15 ns; -- toggle 0
            s_t  <= '1';
            
            wait for 15 ns; -- no change 1
            s_t  <= '0';
            
            wait for 15 ns; -- toggle 1
            s_t  <= '1';
            
            wait for 15 ns; -- no change 0
            s_t  <= '0';
            
            wait for 15 ns; -- toggle 0
            s_t  <= '1';

            wait;
            
            report "Stimulus ended" severity note;
    end process p_stimulus;
    
    p_asserts : process
        begin
            report "Asserts started" severity note;
            
            wait for 18 ns;
            assert(s_clk = '1' and s_rst = '0' and s_t = '1'  and s_q = '1' ) report "Failed2" severity  error;
            
            wait for 24 ns;
            assert(s_clk = '0' and s_rst = '0' and s_t = '0'  and s_q = '0' ) report "Failed1" severity  error;
            
            wait for 35 ns;
            assert(s_clk = '1' and s_rst = '0' and s_t = '1'  and s_q = '1' ) report "Failed3" severity  error;
            
            wait for 70 ns;
            assert(s_clk = '1' and s_rst = '0' and s_t = '0'  and s_q = '0' ) report "Failed4" severity  error;
        
            
            report "Asserts ended" severity note;
            wait;
        
    end process p_asserts;


end Behavioral;
