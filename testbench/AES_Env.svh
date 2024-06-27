/*######################################################################*\
## Class Name: AES_Env    
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class AES_Env extends uvm_env;
    `uvm_component_utils(AES_Env)

    AES_Agent agent;
    AES_Subscriber cov;
    AES_Scoreboard scb;
    virtual AES_IF vif;

   function new (string name="AES_Env", uvm_component parent =null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual AES_IF)::get(this,"","vif",vif))
            `uvm_error("AES_Env","Can't get vif from the config db")

        uvm_config_db#(virtual AES_IF)::set(this,"agent","vif",vif);
        agent=AES_Agent::type_id::create("agent",this);
        scb=AES_Scoreboard::type_id::create("scb",this);
        cov=AES_Subscriber::type_id::create("cov",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.agent_ap.connect(scb.scb_imp);
        agent.agent_ap.connect(cov.sub_imp);
    endfunction

    

endclass:AES_Env