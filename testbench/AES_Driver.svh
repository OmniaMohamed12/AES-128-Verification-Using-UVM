/*######################################################################*\
## Class Name: AES_Driver    
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class AES_Driver extends uvm_driver#(AES_Sequence_Item);
    `uvm_component_utils(AES_Driver)

    AES_Sequence_Item item;
    virtual AES_IF vif;

    function new (string name="AES_Driver", uvm_component parent =null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("AES_Driver : build_phase");
        if(!uvm_config_db#(virtual AES_IF)::get(this,"","vif",vif))
            `uvm_error("AES_Driver","Can't get vif from the config db")

        item=AES_Sequence_Item::type_id::create("item");

    endfunction

    task drive_item(input AES_Sequence_Item item);
    
        vif.plain_text <=item.plain_text;
        vif.cipher_key <= item.cipher_key;
        
    endtask:drive_item
    task run_phase(uvm_phase phase);
        forever begin

        seq_item_port.get_next_item(item);
        drive_item(item);
        seq_item_port.item_done();
        @(posedge vif.Clk);
        end
    endtask

endclass:AES_Driver