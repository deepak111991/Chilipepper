-- -------------------------------------------------------------
-- 
-- File Name: C:\GIT\QPSK_Pcore\Labs\Lab_7\MATLAB\codegen\rx_fifo\hdlsrc\rx_fifo_fixpt.vhd
-- Created: 2013-12-13 15:25:41
-- 
-- Generated by MATLAB 8.3, MATLAB Coder 2.6 and HDL Coder 3.4
-- 
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Design base rate: 1
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        1
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- dout                          ce_out        1
-- empty                         ce_out        1
-- byte_ready                    ce_out        1
-- full                          ce_out        1
-- bytes_available               ce_out        1
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: rx_fifo_fixpt
-- Source Path: rx_fifo_fixpt
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY rx_fifo_fixpt IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        get_byte                          :   IN    std_logic;  -- ufix1
        store_byte                        :   IN    std_logic;  -- ufix1
        byte_in                           :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8
        reset_fifo                        :   IN    std_logic;  -- ufix1
        ce_out                            :   OUT   std_logic;
        dout                              :   OUT   std_logic_vector(9 DOWNTO 0);  -- ufix10
        empty                             :   OUT   std_logic;  -- ufix1
        byte_ready                        :   OUT   std_logic;  -- ufix1
        full                              :   OUT   std_logic_vector(10 DOWNTO 0);  -- ufix11
        bytes_available                   :   OUT   std_logic_vector(31 DOWNTO 0)  -- ufix32
        );
END rx_fifo_fixpt;


ARCHITECTURE rtl OF rx_fifo_fixpt IS

  -- Component Declarations
  COMPONENT fifo_ram
    PORT( clk                             :   IN    std_logic;
          enb                             :   IN    std_logic;
          wr_din                          :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8
          wr_addr                         :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
          wr_en                           :   IN    std_logic;  -- ufix1
          rd_addr                         :   IN    std_logic_vector(10 DOWNTO 0);  -- ufix11
          rd_dout                         :   OUT   std_logic_vector(7 DOWNTO 0)  -- ufix8
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : fifo_ram
    USE ENTITY work.fifo_ram(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL head_not_empty                   : std_logic;
  SIGNAL head_not_empty_1                 : std_logic;
  SIGNAL tmp                              : std_logic;
  SIGNAL tmp_1                            : std_logic;
  SIGNAL tmp_2                            : std_logic;
  SIGNAL head_not_empty_reg_head_not_empty : std_logic;
  SIGNAL tmp_3                            : std_logic;
  SIGNAL tmp_4                            : std_logic;
  SIGNAL head                             : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL head_1                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL full_1                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL full_2                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tail                             : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tail_1                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL empty_1                          : std_logic;  -- ufix1
  SIGNAL empty_2                          : std_logic;  -- ufix1
  SIGNAL tmp_5                            : std_logic;
  SIGNAL handshake                        : std_logic;  -- ufix1
  SIGNAL tmp_6                            : std_logic;
  SIGNAL handshake_1                      : std_logic;  -- ufix1
  SIGNAL handshake_2                      : std_logic;  -- ufix1
  SIGNAL tmp_7                            : std_logic;
  SIGNAL tmp_8                            : std_logic;  -- ufix1
  SIGNAL tmp_9                            : std_logic;  -- ufix1
  SIGNAL tmp_10                           : std_logic;  -- ufix1
  SIGNAL handshake_3                      : std_logic;  -- ufix1
  SIGNAL handshake_reg_handshake          : std_logic;  -- ufix1
  SIGNAL tmp_11                           : std_logic;  -- ufix1
  SIGNAL tmp_12                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tail_2                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tmp_13                           : std_logic;
  SIGNAL tmp_14                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tmp_15                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL head_2                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tmp_16                           : std_logic;
  SIGNAL tmp_17                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tmp_18                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL head_3                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL head_reg_head                    : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tmp_19                           : std_logic;
  SIGNAL tmp_20                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tmp_21                           : std_logic;
  SIGNAL tmp_22                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tail_3                           : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tail_reg_tail                    : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tmp_23                           : std_logic;
  SIGNAL tmp_24                           : std_logic;  -- ufix1
  SIGNAL tmp_25                           : std_logic;
  SIGNAL tmp_26                           : std_logic;
  SIGNAL byte_out                         : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL tmp_27                           : std_logic;
  SIGNAL tmp_28                           : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL byte_in_unsigned                 : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL val                              : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL tmp_29                           : signed(31 DOWNTO 0);  -- int32
  SIGNAL p43tmp_sub_cast                  : signed(31 DOWNTO 0);  -- int32
  SIGNAL addr                             : signed(31 DOWNTO 0);  -- int32
  SIGNAL tmp_30                           : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL tmp_31                           : signed(31 DOWNTO 0);  -- int32
  SIGNAL indexLogic_fixptsig              : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tmp_32                           : signed(31 DOWNTO 0);  -- int32
  SIGNAL p39tmp_sub_cast                  : signed(31 DOWNTO 0);  -- int32
  SIGNAL addr_1                           : signed(31 DOWNTO 0);  -- int32
  SIGNAL fifo_ram_wrenb                   : std_logic;  -- ufix1
  SIGNAL tmp_33                           : signed(31 DOWNTO 0);  -- int32
  SIGNAL indexLogic_fixptsig_1            : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tmp_34                           : std_logic;
  SIGNAL byte_out_1                       : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL tmp_35                           : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL fifo                             : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL fifo_unsigned                    : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL tmp_36                           : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL tmp_37                           : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL byte_out_2                       : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL byte_out_reg_byte_out            : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL tmp_38                           : unsigned(7 DOWNTO 0);  -- ufix8
  SIGNAL dout_1                           : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL empty_3                          : std_logic;  -- ufix1
  SIGNAL tmp_39                           : std_logic;
  SIGNAL byte_ready_1                     : std_logic;  -- ufix1
  SIGNAL byte_ready_2                     : std_logic;  -- ufix1
  SIGNAL tmp_40                           : std_logic;  -- ufix1
  SIGNAL byte_ready_3                     : std_logic;  -- ufix1
  SIGNAL tmp_41                           : std_logic;  -- ufix1
  SIGNAL byte_ready_4                     : std_logic;  -- ufix1
  SIGNAL full_tmp                         : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL tmp_42                           : std_logic;
  SIGNAL tmp_43                           : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL tmp_44                           : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL tmp_45                           : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL bytes_available_tmp              : unsigned(31 DOWNTO 0);  -- ufix32

BEGIN
  u_fifo_ram : fifo_ram
    PORT MAP( clk => clk,
              enb => clk_enable,
              wr_din => std_logic_vector(tmp_30),  -- ufix8
              wr_addr => std_logic_vector(indexLogic_fixptsig),  -- ufix11
              wr_en => fifo_ram_wrenb,  -- ufix1
              rd_addr => std_logic_vector(indexLogic_fixptsig_1),  -- ufix11
              rd_dout => fifo  -- ufix8
              );

  head_not_empty <= '1';

  enb <= clk_enable;

  tmp <= reset_fifo OR ( NOT head_not_empty_1);

  
  tmp_1 <= head_not_empty_1 WHEN tmp = '0' ELSE
      head_not_empty;

  tmp_2 <= tmp_1;

  head_not_empty_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      head_not_empty_reg_head_not_empty <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        head_not_empty_reg_head_not_empty <= tmp_2;
      END IF;
    END IF;
  END PROCESS head_not_empty_reg_process;

  head_not_empty_1 <= head_not_empty_reg_head_not_empty;

  tmp_3 <= reset_fifo OR ( NOT head_not_empty_1);

  tmp_4 <= reset_fifo OR ( NOT head_not_empty_1);

  head <= to_unsigned(2#00000000001#, 11);

  head_1 <= to_unsigned(2#00000000001#, 11);

  full_1 <= to_unsigned(2#00000000000#, 11);

  full_2 <= to_unsigned(2#00000000001#, 11);

  tail <= to_unsigned(2#00000000001#, 11);

  tail_1 <= to_unsigned(2#00000000010#, 11);

  empty_1 <= '0';

  empty_2 <= '1';

  --%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  --                                                                          %
  --       Generated by MATLAB 8.3, MATLAB Coder 2.6 and HDL Coder 3.4        %
  --                                                                          %
  --%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  --
  --  First In First Out (FIFO) structure.
  --  This FIFO stores integers.
  --  The FIFO is actually a circular buffer.
  --
  tmp_5 <= reset_fifo OR ( NOT head_not_empty_1);

  handshake <= '1';

  -- handshaking logic
  
  tmp_6 <= '1' WHEN get_byte = '0' ELSE
      '0';

  handshake_1 <= '0';

  handshake_2 <= '0';

  
  tmp_9 <= tmp_8 WHEN tmp_7 = '0' ELSE
      handshake;

  tmp_10 <= tmp_9;

  handshake_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      handshake_reg_handshake <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        handshake_reg_handshake <= tmp_10;
      END IF;
    END IF;
  END PROCESS handshake_reg_process;

  handshake_3 <= handshake_reg_handshake;

  
  tmp_11 <= handshake_3 WHEN tmp_5 = '0' ELSE
      handshake_1;

  
  tmp_8 <= tmp_11 WHEN tmp_6 = '0' ELSE
      handshake_2;

  tail_2 <= tmp_12 + 1;

  
  tmp_13 <= '1' WHEN tail_2 = 1025 ELSE
      '0';

  
  tmp_14 <= tail_2 WHEN tmp_13 = '0' ELSE
      tail;

  head_2 <= tmp_15 + 1;

  
  tmp_16 <= '1' WHEN head_2 = 1025 ELSE
      '0';

  
  tmp_17 <= head_2 WHEN tmp_16 = '0' ELSE
      head;

  
  tmp_18 <= tmp_15 WHEN tmp_7 = '0' ELSE
      tmp_17;

  head_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      head_reg_head <= to_unsigned(2#00000000000#, 11);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        head_reg_head <= tmp_18;
      END IF;
    END IF;
  END PROCESS head_reg_process;

  head_3 <= head_reg_head;

  
  tmp_15 <= head_3 WHEN tmp_4 = '0' ELSE
      head_1;

  
  tmp_19 <= '1' WHEN ((tmp_15 = 1) AND (tmp_12 = 1024)) OR ((resize(tmp_12, 12) + 1) = resize(tmp_15, 12)) ELSE
      '0';

  
  tmp_20 <= full_1 WHEN tmp_19 = '0' ELSE
      full_2;

  --%%%%%%%%%%%%put%%%%%%%%%%%%%%%%%%%%%
  
  tmp_21 <= '1' WHEN (store_byte /= '0') AND ( NOT (tmp_20 /= 0)) ELSE
      '0';

  
  tmp_22 <= tmp_12 WHEN tmp_21 = '0' ELSE
      tmp_14;

  tail_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tail_reg_tail <= to_unsigned(2#00000000000#, 11);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        tail_reg_tail <= tmp_22;
      END IF;
    END IF;
  END PROCESS tail_reg_process;

  tail_3 <= tail_reg_tail;

  
  tmp_12 <= tail_3 WHEN tmp_3 = '0' ELSE
      tail_1;

  -- Section for checking full and empty cases
  
  tmp_23 <= '1' WHEN ((tmp_12 = 1) AND (tmp_15 = 1024)) OR ((resize(tmp_15, 12) + 1) = resize(tmp_12, 12)) ELSE
      '0';

  
  tmp_24 <= empty_1 WHEN tmp_23 = '0' ELSE
      empty_2;

  --%%%%%%%%%%%%%get%%%%%%%%%%%%%%%%%%%%%
  
  tmp_7 <= '1' WHEN ((get_byte /= '0') AND ( NOT (tmp_24 /= '0'))) AND (tmp_8 = '0') ELSE
      '0';

  tmp_25 <= reset_fifo OR ( NOT head_not_empty_1);

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tmp_26 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        tmp_26 <= tmp_25;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  byte_out <= to_unsigned(2#00000000#, 8);

  delayMatch_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tmp_27 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        tmp_27 <= tmp_7;
      END IF;
    END IF;
  END PROCESS delayMatch_1_process;


  --HDL code generation from MATLAB function: rx_fifo_fixpt
  tmp_28 <= to_unsigned(2#00000000#, 8);

  byte_in_unsigned <= unsigned(byte_in);

  val <= to_unsigned(2#00000000#, 8);

  p43tmp_sub_cast <= signed(resize(tmp_12, 32));
  tmp_29 <= p43tmp_sub_cast - 1;

  addr <= to_signed(16#00000400#, 32);

  
  tmp_30 <= byte_in_unsigned WHEN tmp_21 = '1' ELSE
      val;

  
  tmp_31 <= tmp_29 WHEN tmp_21 = '1' ELSE
      addr;

  indexLogic_fixptsig <= unsigned(tmp_31(10 DOWNTO 0));

  p39tmp_sub_cast <= signed(resize(tmp_17, 32));
  tmp_32 <= p39tmp_sub_cast - 1;

  addr_1 <= to_signed(16#00000400#, 32);

  fifo_ram_wrenb <= '1';

  
  tmp_33 <= tmp_32 WHEN tmp_7 = '1' ELSE
      addr_1;

  indexLogic_fixptsig_1 <= unsigned(tmp_33(10 DOWNTO 0));

  delayMatch_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tmp_34 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        tmp_34 <= tmp_7;
      END IF;
    END IF;
  END PROCESS delayMatch_2_process;


  delayMatch_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      byte_out_1 <= to_unsigned(2#00000000#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        byte_out_1 <= byte_out;
      END IF;
    END IF;
  END PROCESS delayMatch_3_process;


  delayMatch_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tmp_35 <= to_unsigned(2#00000000#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        tmp_35 <= tmp_28;
      END IF;
    END IF;
  END PROCESS delayMatch_4_process;


  fifo_unsigned <= unsigned(fifo);

  
  tmp_36 <= tmp_35 WHEN tmp_27 = '0' ELSE
      fifo_unsigned;

  byte_out_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      byte_out_reg_byte_out <= to_unsigned(2#00000000#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        byte_out_reg_byte_out <= tmp_37;
      END IF;
    END IF;
  END PROCESS byte_out_reg_process;

  byte_out_2 <= byte_out_reg_byte_out;

  
  tmp_38 <= byte_out_2 WHEN tmp_26 = '0' ELSE
      byte_out_1;

  
  tmp_37 <= tmp_38 WHEN tmp_34 = '0' ELSE
      tmp_36;

  dout_1 <= resize(tmp_37, 10);

  dout <= std_logic_vector(dout_1);

  empty_3 <= tmp_24;

  delayMatch_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      empty <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        empty <= empty_3;
      END IF;
    END IF;
  END PROCESS delayMatch_5_process;


  
  tmp_39 <= '1' WHEN tmp_8 = '1' ELSE
      '0';

  byte_ready_1 <= '0';

  byte_ready_2 <= '1';

  
  tmp_40 <= byte_ready_1 WHEN tmp_39 = '0' ELSE
      byte_ready_2;

  --HDL code generation from MATLAB function: rx_fifo_fixpt
  byte_ready_3 <= '1';

  
  tmp_41 <= tmp_40 WHEN tmp_7 = '0' ELSE
      byte_ready_3;

  byte_ready_4 <= tmp_41;

  delayMatch_6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      byte_ready <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        byte_ready <= byte_ready_4;
      END IF;
    END IF;
  END PROCESS delayMatch_6_process;


  delayMatch_7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      full_tmp <= to_unsigned(2#00000000000#, 11);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        full_tmp <= tmp_20;
      END IF;
    END IF;
  END PROCESS delayMatch_7_process;


  full <= std_logic_vector(full_tmp);

  -- Section for calculating num bytes in FIFO
  
  tmp_42 <= '1' WHEN tmp_18 < tmp_22 ELSE
      '0';

  tmp_43 <= resize(resize(resize(1024 - resize(tmp_18, 12), 13) + resize(tmp_22, 13), 14) - 1, 32);

  tmp_44 <= resize(resize(resize(tmp_22, 12) - resize(tmp_18, 12), 13) - 1, 32);

  
  tmp_45 <= tmp_43 WHEN tmp_42 = '0' ELSE
      tmp_44;

  delayMatch_8_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      bytes_available_tmp <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        bytes_available_tmp <= tmp_45;
      END IF;
    END IF;
  END PROCESS delayMatch_8_process;


  bytes_available <= std_logic_vector(bytes_available_tmp);

  ce_out <= clk_enable;

END rtl;
