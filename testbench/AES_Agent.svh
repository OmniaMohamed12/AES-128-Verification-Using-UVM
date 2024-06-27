/*######################################################################*\
## Class Name: AES_Agent    
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class AES_Agent extends uvm_agent;
    `uvm_component_utils(AES_Agent)

    AES_Sequencer sqr;
    AES_Driver drv;
    AES_Monitor mon;
    uvm_analysis_port#(AES_Sequence_Item) agent_ap;
    virtual AES_IF vif;

    function new (string name="AES_Agent", uvm_component parent =null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual AES_IF)::get(this,"","vif",vif))
            `uvm_error("AES_Agent","Can't get vif from the config db")
        uvm_config_db#(virtual AES_IF)::set(this,"drv","vif",vif);
        uvm_config_db#(virtual AES_IF)::set(this,"mon","vif",vif);
        sqr=AES_Sequencer::type_id::create("sqr",this);
        drv=AES_Driver::type_id::create("drv",this);
        mon=AES_Monitor::type_id::create("mon",this);
        agent_ap=new("agent_ap",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        mon.mon_ap.connect(this.agent_ap);
    endfunction

    
endclass:AES_Agent