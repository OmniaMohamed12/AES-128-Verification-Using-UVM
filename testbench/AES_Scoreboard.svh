/*######################################################################*\
## Class Name: AES_Scoreboard   
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class AES_Scoreboard extends uvm_scoreboard;
    `uvm_component_utils(AES_Scoreboard)
    uvm_analysis_imp#(AES_Sequence_Item,AES_Scoreboard) scb_imp;
    AES_Reference_Model ref_model;
    int num_passed_cases;
    int num_failed_cases;

    extern function new (string name="AES_Scoreboard", uvm_component parent =null);
    extern function void build_phase(uvm_phase phase);
    extern function void write(input AES_Sequence_Item item);

endclass:AES_Scoreboard
function AES_Scoreboard::new (string name="AES_Scoreboard", uvm_component parent =null);
    super.new(name,parent);
endfunction

function void AES_Scoreboard::build_phase(uvm_phase phase);

    super.build_phase(phase);
    scb_imp=new("scb_imp",this);
    ref_model=AES_Reference_Model::type_id::create("ref_model",this);

endfunction

function void AES_Scoreboard::write(input AES_Sequence_Item item);
    
    int file_handle;
    bit[127:0] expected_cipher_text;
    expected_cipher_text=ref_model.encryption_process(item.plain_text,item.cipher_key);

    if(item.cipher_text == expected_cipher_text)begin
        `uvm_info("AES_Scoreboard","TEST PASSED ",UVM_NONE);
        num_passed_cases++;
       
    end
    else begin
        `uvm_info("AES_Scoreboard","TEST FAILED ",UVM_NONE);
        num_failed_cases++;
        $display("%0t scb plain text =%0h , key=%0h",$time ,item.plain_text,item.cipher_key);
        $display("expected_cipher_text =%0h , actual_cipher_text=%0h",expected_cipher_text,item.cipher_text);
        
    end

    $display("num_passed_cases=%0d num_failed_cases=%0d",num_passed_cases,num_failed_cases);

endfunction
