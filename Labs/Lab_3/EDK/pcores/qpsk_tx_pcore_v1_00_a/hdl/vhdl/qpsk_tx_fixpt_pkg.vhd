-- -------------------------------------------------------------
-- 
-- File Name: C:\GIT\pcore_Branch\Chilipepper\Labs\Lab_3\MATLAB\codegen\qpsk_tx\hdlsrc\qpsk_tx_fixpt_pkg.vhd
-- Created: 2013-11-18 19:08:08
-- 
-- Generated by MATLAB 8.2, MATLAB Coder 2.5 and HDL Coder 3.3
-- 
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE qpsk_tx_fixpt_pkg IS
  TYPE vector_of_signed32 IS ARRAY (NATURAL RANGE <>) OF signed(31 DOWNTO 0);
  TYPE vector_of_signed3 IS ARRAY (NATURAL RANGE <>) OF signed(2 DOWNTO 0);
  TYPE vector_of_signed23 IS ARRAY (NATURAL RANGE <>) OF signed(22 DOWNTO 0);
  TYPE vector_of_signed17 IS ARRAY (NATURAL RANGE <>) OF signed(16 DOWNTO 0);
  TYPE vector_of_signed14 IS ARRAY (NATURAL RANGE <>) OF signed(13 DOWNTO 0);
END qpsk_tx_fixpt_pkg;

