# Lab 02 - Vivado

## My repository
[My git - Tomáš Kříčka, 223283](https://github.com/TomasKricka/Digital-electronics-1)


<Br>

## Constanst tables

### Multiplexor connection

| **Port** | **Connected to** | **FPGA pin** | **Pin** |
| :-: | :-: | :-: | :-:|
| a_i[0] | SW [0] | J15 | IO_L24N_T3_RS0_15 |
| a_i[1] | SW [1] | L16 | IO_L3N_T0_DQS_EMCCLK_14 |
| b_i[0] | SW [2] | M13 | IO_L6N_T0_D08_VREF_14 |
| b_i[1] | SW [3] | R15 | IO_L13N_T2_MRCC_14 |
| c_i[0] | SW [4] | R17 | IO_L12N_T1_MRCC_14 |
| c_i[1] | SW [5] | T18 | IO_L7N_T1_D10_14 |
| d_i[0] | SW [6] | U18 | IO_L17N_T2_A13_D29_14 |
| d_i[1] | SW [7] | R13 | IO_L5N_T0_D07_14 |
| sel_i[0] | SW [14] | U11 | IO_L19N_T3_A09_D25_VREF_14 |
| sel_i[1] | SW [15] | V10 | IO_L21P_T3_DQS_14 |
| f_o[0] | LED [0] | H17 | IO_L18P_T2_A24_15 |
| f_o[1] | LED [1] | K15 | IO_L24P_T3_RS1_15 |
<br>

### Nexys A7 - 50T, connection table

| **Switch** | **FPGA package pin** | **FPGA pin** |
| :-: | :-: | :-: |
| SW[0] | J15 | IO_L24N_T3_RS0_15 |
| SW[1] | L16 | IO_L3N_T0_DQS_EMCCLK_14 |
| SW[2] | M13 | IO_L6N_T0_D08_VREF_14 | 
| SW[3] | R15 | IO_L13N_T2_MRCC_14 |  
| SW[4] | R17 | IO_L12N_T1_MRCC_14 | 
| SW[5] | T18 | IO_L7N_T1_D10_14 | 
| SW[6] | U18 | IO_L17N_T2_A13_D29_14 |  
| SW[7] | R13 | IO_L5N_T0_D07_14 | 
| SW[8] | T8 | IO_L24N_T3_34 | 
| SW[9] | U8 | IO_25_34 |
| SW[10] | R16 | IO_L15P_T2_DQS_RDWR_B_14 | 
| SW[11] | T13 | IO_L23P_T3_A03_D19_14 | 
| SW[12] | H6 | IO_L24P_T3_35 |
| SW[13] | U12 | IO_L20P_T3_A08_D24_14 |
| SW[14] | U11 | IO_L19N_T3_A09_D25_VREF_14 |
| SW[15] | V10 | IO_L21P_T3_DQS_14 |  

<br>

| **LED** | **FPGA package pin** | **FPGA pin** |
| :-: | :-: | :-: |
| LED[0] | H17 | IO_L18P_T2_A24_15 |
| LED[1] | K15 | IO_L24P_T3_RS1_15 |
| LED[2] | J13 | IO_L17N_T2_A25_15 |
| LED[3] | N14 | IO_L8P_T1_D11_14 |
| LED[4] | R18 | IO_L7P_T1_D09_14 |
| LED[5] | V17 | IO_L18N_T2_A11_D27_14 |
| LED[6] | U17 | IO_L17P_T2_A14_D30_14 |
| LED[7] | U16 | IO_L18P_T2_A12_D28_14 |
| LED[8] | V16 | IO_L16N_T2_A15_D31_14 |
| LED[9] | T15 | IO_L14N_T2_SRCC_14 |
| LED[10] | U14 | IO_L22P_T3_A05_D21_14 |
| LED[11] | T16 | IO_L15N_T2_DQS_DOUT_CSO_B_14 |
| LED[12] | V15 | IO_L16P_T2_CSI_B_14 |
| LED[13] | V14 | IO_L22N_T3_A04_D20_14 |
| LED[14] | V12 | IO_L20N_T3_A07_D23_14 |
| LED[15] | V11 | IO_L21N_T3_DQS_A06_D22_14 |

<Br>

### Architecture 
<br>

```vhdl
architecture Behavioral of mux_2bit_4to1 is
begin

    f_o <= a_i when (sel_i = "00") else
           b_i when (sel_i = "01") else
           c_i when (sel_i = "10") else
           d_i;


    -- WRITE "GREATER" AND "EQUALS" ASSIGNMENTS HERE


end architecture Behavioral;
```

<br>

### Stimulus
<br>

```vhdl
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;

        s_d <= "00"; s_c <= "00"; s_b <= "00"; s_a <= "00";
        s_sel <= "00"; wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "01"; s_a <= "00";
        s_sel <= "00"; wait for 100 ns;
        
        s_d <= "00"; s_c <= "00"; s_b <= "01"; s_a <= "11";
        s_sel <= "10"; wait for 100 ns;
                
        s_d <= "10"; s_c <= "10"; s_b <= "01"; s_a <= "01";
        s_sel <= "11"; wait for 100 ns;

        
        -- WRITE OTHER TESTS HERE


        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

### Waveforms
![Simulation](images/waves.png)

<br>
<br>

## Vivado tutotial

<br>

1. Create project and design

![Tut1](images/1.png)
![Tut2](images/2.png)
![Tut3](images/3.png)
![Tut4](images/4.png)
![Tut5](images/5.png)
![Tut6](images/6.png)
![Tut7](images/7.png)
![Tut8](images/8.png)

2. Create testbench

![Tut9](images/9.png)
![Tut10](images/10.png)
![Tut11](images/11.png)
![Tut12](images/12.png)

3. Create Constants

![Tut13](images/13.png)
![Tut14](images/14.png)

4. Run simulation

![Tut15](images/15.png)