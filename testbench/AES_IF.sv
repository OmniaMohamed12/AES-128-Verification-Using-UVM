/*######################################################################*\
## Interface Name: AES_IF    
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
interface AES_IF();
    logic Clk;
    logic[127:0] plain_text;
    logic[127:0] cipher_key;
    logic [127:0] cipher_text;
endinterface //AES_IF