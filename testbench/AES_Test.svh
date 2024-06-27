/*######################################################################*\
## Class Name: AES_Test   
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class AES_Test extends uvm_test;
    `uvm_component_utils(AES_Test)
    AES_Env env;
    AES_Sequence base_seq;
    AES_low_high_Sequence seq1;
    all_zeros_key_different_plain_text_Sequence seq2;
    all_ones_key_different_plain_text_Sequence seq3;
    all_zeros_plain_text_different_key_Sequence seq4;
    all_ones_plain_text_different_key_Sequence seq5;
    random_plain_text_key_Sequence seq6;
    random_plain_text_key_Sequence2 seq7;

    virtual AES_IF vif;

    function new (string name="AES_Test", uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual AES_IF)::get(this,"","vif",vif))
            `uvm_error("AES_Test","Can't get vif from the config db")
        uvm_config_db#(virtual AES_IF)::set(this,"env","vif",vif);
        env=AES_Env::type_id::create("env",this);
        base_seq=AES_Sequence::type_id::create("base_seq");
        seq1=AES_low_high_Sequence::type_id::create("seq1");
        seq2=all_zeros_key_different_plain_text_Sequence::type_id::create("seq2");
        seq3=all_ones_key_different_plain_text_Sequence::type_id::create("seq3");
        seq4=all_zeros_plain_text_different_key_Sequence::type_id::create("seq4");
        seq5=all_ones_plain_text_different_key_Sequence::type_id::create("seq5");
        seq6=random_plain_text_key_Sequence::type_id::create("seq6");
        seq7=random_plain_text_key_Sequence2::type_id::create("seq7");
        base_seq.num_transactions=80;
        seq1.num_transactions=10;
        seq2.num_transactions=128;
        seq3.num_transactions=128;
        seq4.num_transactions=128;
        seq5.num_transactions=128;
        seq6.num_transactions=128;
        seq7.num_transactions=10;
        
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        base_seq.start(env.agent.sqr);
        #200;
        seq1.start(env.agent.sqr);
        #100;
        seq2.start(env.agent.sqr);
        #200;
        seq3.start(env.agent.sqr);
        #200;
        seq4.start(env.agent.sqr);
        #200;
        seq5.start(env.agent.sqr);
        #200;
        seq6.start(env.agent.sqr);
        #300;
        seq7.start(env.agent.sqr);
        #300;
        base_seq.start(env.agent.sqr);
        #200;
        phase.drop_objection(this);
    endtask
endclass:AES_Test