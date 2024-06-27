/*######################################################################*\
## File Name: AES_Top.sv  
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
`timescale 1ns/1ps
`include "AES_IF.sv"
`include "AES_Encrypt.v"
module AES_Top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import AES_Pack::*;
    AES_IF ifc();
    AES_Encrypt#(128,10,4) dut(ifc.plain_text,ifc.cipher_key,ifc.cipher_text);
  initial begin
	ifc.Clk<=0;
	forever #5 ifc.Clk<=~ifc.Clk;
  end
    initial begin
        uvm_config_db#(virtual AES_IF)::set(null,"uvm_test_top","vif",ifc);
        run_test("AES_Test");
    end

endmodule
/*
vlog AES_Pack.svh AES_Top.sv +cover
vsim -batch AES_Top -coverage -do "run -all; coverage report -codeAll -cvg -verbose"

*/

