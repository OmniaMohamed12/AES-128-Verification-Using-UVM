/*######################################################################*\
## Class Name: AES_Sequencer    
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class AES_Sequencer extends uvm_sequencer#(AES_Sequence_Item);
    `uvm_component_utils(AES_Sequencer)

    function new (string name="AES_Sequencer", uvm_component parent =null);
        super.new(name,parent);
    endfunction

endclass:AES_Sequencer