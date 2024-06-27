/*######################################################################*\
## Class Name: AES_Subscriber   
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class AES_Subscriber extends uvm_subscriber#(AES_Sequence_Item);
`uvm_component_utils(AES_Subscriber)
    AES_Sequence_Item item;
    uvm_analysis_imp#(AES_Sequence_Item,AES_Subscriber) sub_imp;

    covergroup cg;
        plain_text:coverpoint item.plain_text{
            bins allzeros={128'h00000000000000000000000000000000};
            bins allones={128'hffffffffffffffffffffffffffffffff};
            bins b1={[0:(2**32)-1]};
            bins b2={[(2**32):(2**64)-1]};
            bins b3={[(2**64):(2**96)-1]};
            bins b4={[(2**96):((2**127)-1)]};
        }
        cipher_key:coverpoint item.cipher_key{
            bins allzeros={128'h00000000000000000000000000000000};
            bins allones={128'hffffffffffffffffffffffffffffffff};
            bins b1={[0:(2**32)-1]};
            bins b2={[(2**32):(2**64)-1]};
            bins b3={[(2**64):(2**96)-1]};
            bins b4={[(2**96):((2**127)-1)]};
        }
        
        cipher_text:coverpoint item.cipher_text;
        cross plain_text,cipher_key;
    endgroup
    function new (string name="AES_Subscriber", uvm_component parent =null);
        super.new(name,parent);
        cg=new();
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sub_imp=new("sub_imp",this);
    endfunction
    virtual function void write(AES_Sequence_Item t);
        item=t;
        cg.sample();
    endfunction
    function void report_phase (uvm_phase phase);
        `uvm_info("AES_Subscriber", $sformatf("coverage =%0d", cg.get_coverage), UVM_NONE);
    endfunction
endclass:AES_Subscriber