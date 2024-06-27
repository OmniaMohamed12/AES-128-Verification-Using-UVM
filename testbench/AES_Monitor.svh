/*######################################################################*\
## Class Name: AES_Monitor    
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class AES_Monitor extends uvm_monitor;
    `uvm_component_utils(AES_Monitor)
    AES_Sequence_Item item;
    virtual AES_IF vif;
    uvm_analysis_port#(AES_Sequence_Item) mon_ap;

    function new(string name="AES_Monitor",uvm_component parent =null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual AES_IF)::get(this,"","vif",vif))
            `uvm_error("AES_Monitor","Can't get vif from the config db")

        item=AES_Sequence_Item::type_id::create("item");
        mon_ap =new("mon_ap",this);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin

        @(posedge vif.Clk);
        item.plain_text <=vif.plain_text;
        item.cipher_key <= vif.cipher_key;
        item.cipher_text<=vif.cipher_text;
        #1step;
        mon_ap.write(item);

        $display(" %0t mon: plain %h",$time,item.plain_text);
        $display(" %0t mon :cipher key %h",$time,item.cipher_key);
        $display(" %0t mon :cipher text %h",$time,item.cipher_text);
        
        end
    endtask
endclass:AES_Monitor
