/*######################################################################*\
## Class Name: AES_Sequence_Item    
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class AES_Sequence_Item extends uvm_sequence_item;
    `uvm_object_utils(AES_Sequence_Item)

    rand logic[127:0] plain_text;
    rand logic[127:0] cipher_key;
    logic [127:0] cipher_text;
    constraint c1{
        plain_text dist {128'h00000000000000000000000000000000 :=10,128'hffffffffffffffffffffffffffffffff:=10,[0:(2**32)-1]:/20,[(2**32):(2**64)-1]:/20,
        [(2**64):(2**96)-1]:/20,[(2**96):((2**127)-1)]:/20};
        cipher_key dist {128'h00000000000000000000000000000000 :=10,128'hffffffffffffffffffffffffffffffff:=10,[0:(2**32)-1]:/20,[(2**32):(2**64)-1]:/20,
        [(2**64):(2**96)-1]:/20,[(2**96):((2**127)-1)]:/20};
    }
    
function new(string name="AES_Sequence_Item");
    super.new(name);
endfunction:new

endclass:AES_Sequence_Item