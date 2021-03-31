------------------------------------------------------------------------
--
-- Traffic light controller using FSM.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
-- This code is inspired by:
-- [1] LBEbooks, Lesson 92 - Example 62: Traffic Light Controller
--     https://www.youtube.com/watch?v=6_Rotnw1hFM
-- [2] David Williams, Implementing a Finite State Machine in VHDL
--     https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/
-- [3] VHDLwhiz, One-process vs two-process vs three-process state machine
--     https://vhdlwhiz.com/n-process-state-machine/
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for traffic light controller
------------------------------------------------------------------------
entity tlc_smart is
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        sensor_i : in std_logic_vector(2 - 1 downto 0);
        
        -- Traffic lights (RGB LEDs) for two directions
        south_o : out std_logic_vector(3 - 1 downto 0);
        west_o  : out std_logic_vector(3 - 1 downto 0)
        
    );
end entity tlc_smart;

------------------------------------------------------------------------
-- Architecture declaration for traffic light controller
------------------------------------------------------------------------
architecture Behavioral of tlc_smart is

    -- Define the states
    type   t_state is (WEST_GO,  WEST_WAIT,
                        SOUTH_GO, SOUTH_WAIT);
                        
    -- Define the signal that uses different states
    signal s_state  : t_state;

    -- Internal clock enable
    signal s_en     : std_logic;
    -- Local delay counter
    signal   s_cnt  : unsigned(5 - 1 downto 0);

    -- Specific values for local counter
--    constant c_DELAY_4SEC : unsigned(5 - 1 downto 0) := b"1_0000"; -- 4 sec
    constant c_DELAY_2SEC : unsigned(5 - 1 downto 0) := b"0_1000"; -- 2 sec
    constant c_DELAY_1SEC : unsigned(5 - 1 downto 0) := b"0_0100"; -- 1 sec
    constant c_ZERO       : unsigned(5 - 1 downto 0) := b"0_0000"; -- zero

begin

    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates an enable pulse
    -- every 250 ms (4 Hz). Remember that the frequency of the clock 
    -- signal is 100 MHz.
    
    -- JUST FOR SHORTER/FASTER SIMULATION
    s_en <= '1';
--    clk_en0 : entity work.clock_enable
--        generic map(
--            g_MAX => 25000000       -- g_MAX = 250 ms / (1/100 MHz)
--        )
--        port map(
--            clk   => clk,
--            reset => reset,
--            ce_o  => s_en
--        );

    --------------------------------------------------------------------
    -- p_traffic_fsm:
    -- The sequential process with synchronous reset and clock_enable 
    -- entirely controls the s_state signal by CASE statement.
    --------------------------------------------------------------------
    p_smart_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= WEST_GO ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    ---------------------
                   when WEST_GO =>
                        if (s_cnt < c_DELAY_2SEC and (sensor_i = "00" or sensor_i = "01")) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= WEST_WAIT;
                            s_cnt <= c_ZERO;
                        end if;
                        
                   when WEST_WAIT =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SOUTH_GO;
                            s_cnt <= c_ZERO;
                        end if; 
                    
                    
                    
                   when SOUTH_GO =>
                        if (s_cnt < c_DELAY_2SEC and (sensor_i = "00" or sensor_i = "10")) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SOUTH_WAIT;
                            s_cnt <= c_ZERO; 
                        end if;
                        
                   when SOUTH_WAIT =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= WEST_GO;
                            s_cnt <= c_ZERO; 
                        end if; 
                    
                    when others =>
                        s_state <= WEST_GO;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_smart_traffic_fsm;

    --------------------------------------------------------------------
    -- p_output_fsm:
    -- The combinatorial process is sensitive to state changes, and sets
    -- the output signals accordingly. This is an example of a Moore 
    -- state machine because the output is set based on the active state.
    --------------------------------------------------------------------
    p_output_fsm : process(s_state)
    begin
        case s_state is
--            when STOP1 =>
--                south_o <= "100";   -- Red (RGB = 100)
--                west_o  <= "100";   -- Red (RGB = 100)
            when WEST_GO =>
                south_o <= "100";
                west_o <= "010";
            when WEST_WAIT =>
                south_o <= "100";
                west_o <= "110";
--            when STOP2 =>
--                south_o <= "100";
--                west_o <= "100";
            when SOUTH_GO =>
                south_o <= "110";
                west_o <= "100";
            when SOUTH_WAIT =>  
                south_o <= "100";
                west_o <= "110";                  

            when others =>
                south_o <= "100";   -- Red
                west_o  <= "100";   -- Red
        end case;
    end process p_output_fsm;

end architecture Behavioral;
