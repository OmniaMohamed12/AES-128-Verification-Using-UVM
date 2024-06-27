/*######################################################################*\
## File Name: AES_Sequences
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class AES_Sequence extends uvm_sequence#(AES_Sequence_Item) ;
 `uvm_object_utils(AES_Sequence)
    AES_Sequence_Item item;
    int num_transactions;
    task do_item();
        item=AES_Sequence_Item::type_id::create("item");
        start_item(item);
        `uvm_info("AES_Sequence","AES_Sequence_Item is starting an item", UVM_LOW)
        assert(item.randomize())
        else 
            `uvm_error(get_type_name(),$sformatf("Randomization Failed"))
        `uvm_info("AES_Sequence","AES_Sequence is randomizing an item", UVM_LOW)
        finish_item(item);
        `uvm_info("AES_Sequence","AES_Sequence is finishing an item", UVM_LOW)
        
    endtask:do_item
    task body();
        repeat(num_transactions)begin 
            do_item();
        end
    endtask:body

    function new(string name="AES_Sequence");
        super.new(name); 
    endfunction
endclass:AES_Sequence

class AES_low_high_Sequence extends AES_Sequence ;
 `uvm_object_utils(AES_low_high_Sequence)
    AES_Sequence_Item item;
    task do_item();
        item=AES_Sequence_Item::type_id::create("item");
        start_item(item);
        `uvm_info("AES_low_high_Sequence","AES_low_high_Sequence is starting an item", UVM_LOW)
        item.constraint_mode(0);
        assert(item.randomize()with{cipher_key==128'h00000000000000000000000000000000 || cipher_key==128'hffffffffffffffffffffffffffffffff ;
        plain_text==128'h00000000000000000000000000000000 || plain_text==128'hffffffffffffffffffffffffffffffff ;})
        else 
            `uvm_error(get_type_name(),$sformatf("Randomization Failed"))
        `uvm_info("AES_low_high_Sequence","AES_low_high_Sequence is randomizing an item", UVM_LOW)
        finish_item(item);
        `uvm_info("AES_low_high_Sequence","AES_low_high_Sequence is finishing an item", UVM_LOW)
        
    endtask:do_item
    task body();
        repeat(num_transactions)begin 
            do_item();
        end
    endtask:body

    function new(string name="AES_low_high_Sequence");
        super.new(name); 
    endfunction
endclass:AES_low_high_Sequence

class all_zeros_key_different_plain_text_Sequence extends AES_Sequence ;
 `uvm_object_utils(all_zeros_key_different_plain_text_Sequence)
    AES_Sequence_Item item;
    int count=0;
    task do_item();
        item=AES_Sequence_Item::type_id::create("item");
        start_item(item);
        `uvm_info("all_zeros_key_different_plain_text_Sequence","all_zeros_key_different_plain_text_Sequence is starting an item", UVM_LOW)
        item.constraint_mode(0);
        assert(item.randomize()with{cipher_key==128'h00000000000000000000000000000000;
                                    $countones(plain_text)==count;})
        else 
            `uvm_error(get_type_name(),$sformatf("Randomization Failed"))
        `uvm_info("all_zeros_key_different_plain_text_Sequence","all_zeros_key_different_plain_text_Sequence is randomizing an item", UVM_LOW)
        finish_item(item);
        `uvm_info("all_zeros_key_different_plain_text_Sequence","all_zeros_key_different_plain_text_Sequence is finishing an item", UVM_LOW)
        count=count+1;
    endtask:do_item
    task body();
        repeat(num_transactions)begin 
            do_item();
        end
    endtask:body

    function new(string name="all_zeros_key_different_plain_text_Sequence");
        super.new(name); 
    endfunction
endclass:all_zeros_key_different_plain_text_Sequence

class all_ones_key_different_plain_text_Sequence extends AES_Sequence ;
 `uvm_object_utils(all_ones_key_different_plain_text_Sequence)
    AES_Sequence_Item item;
    int count=0;
    task do_item();
        item=AES_Sequence_Item::type_id::create("item");
        start_item(item);
        `uvm_info("all_ones_key_different_plain_text_Sequence","all_ones_key_different_plain_text_Sequence is starting an item", UVM_LOW)
        item.constraint_mode(0);
        assert(item.randomize()with{cipher_key==128'hffffffffffffffffffffffffffffffff;
                                    $countones(plain_text)==count;})
        else 
            `uvm_error(get_type_name(),$sformatf("Randomization Failed"))
        `uvm_info("all_ones_key_different_plain_text_Sequence","all_ones_key_different_plain_text_Sequence is randomizing an item", UVM_LOW)
        finish_item(item);
        `uvm_info("all_ones_key_different_plain_text_Sequence","all_ones_key_different_plain_text_Sequence is finishing an item", UVM_LOW)
        count=count+1;
    endtask:do_item
    task body();
        repeat(num_transactions)begin 
            do_item();
        end
    endtask:body

    function new(string name="all_ones_key_different_plain_text_Sequence");
        super.new(name); 
    endfunction
endclass:all_ones_key_different_plain_text_Sequence

class all_zeros_plain_text_different_key_Sequence extends AES_Sequence ;
 `uvm_object_utils(all_zeros_plain_text_different_key_Sequence)
    AES_Sequence_Item item;
    int count=0;
    task do_item();
        item=AES_Sequence_Item::type_id::create("item");
        start_item(item);
        `uvm_info("all_zeros_plain_text_different_key_Sequence","all_zeros_plain_text_different_key_Sequence is starting an item", UVM_LOW)
        item.constraint_mode(0);
        assert(item.randomize()with{plain_text==128'h00000000000000000000000000000000;
                                    $countones(cipher_key)==count;})
        else 
            `uvm_error(get_type_name(),$sformatf("Randomization Failed"))
        `uvm_info("all_zeros_plain_text_different_key_Sequence","all_zeros_plain_text_different_key_Sequence is randomizing an item", UVM_LOW)
        finish_item(item);
        `uvm_info("all_zeros_plain_text_different_key_Sequence","all_zeros_plain_text_different_key_Sequence is finishing an item", UVM_LOW)
        count=count+1;
    endtask:do_item
    task body();
        repeat(num_transactions)begin 
            do_item();
        end
    endtask:body

    function new(string name="all_zeros_plain_text_different_key_Sequence");
        super.new(name); 
    endfunction
endclass:all_zeros_plain_text_different_key_Sequence

class all_ones_plain_text_different_key_Sequence extends AES_Sequence ;
 `uvm_object_utils(all_ones_plain_text_different_key_Sequence)
    AES_Sequence_Item item;
    int count=0;
    task do_item();
        item=AES_Sequence_Item::type_id::create("item");
        start_item(item);
        `uvm_info("all_ones_plain_text_different_key_Sequence","all_ones_plain_text_different_key_Sequence is starting an item", UVM_LOW)
        item.constraint_mode(0);
        assert(item.randomize()with{plain_text==128'hffffffffffffffffffffffffffffffff;
                                    $countones(cipher_key)==count;})
        else 
            `uvm_error(get_type_name(),$sformatf("Randomization Failed"))
        `uvm_info("all_ones_plain_text_different_key_Sequence","all_ones_plain_text_different_key_Sequence is randomizing an item", UVM_LOW)
        finish_item(item);
        `uvm_info("all_ones_plain_text_different_key_Sequence","all_ones_plain_text_different_key_Sequence is finishing an item", UVM_LOW)
        count=count+1;
    endtask:do_item
    task body();
        repeat(num_transactions)begin 
            do_item();
        end
    endtask:body

    function new(string name="all_ones_plain_text_different_key_Sequence");
        super.new(name); 
    endfunction
endclass:all_ones_plain_text_different_key_Sequence

class random_plain_text_key_Sequence extends AES_Sequence ;
 `uvm_object_utils(random_plain_text_key_Sequence)
    AES_Sequence_Item item;
    int count=0;
    task do_item();
        item=AES_Sequence_Item::type_id::create("item");
        start_item(item);
        `uvm_info("random_plain_text_key_Sequence","random_plain_text_key_Sequence is starting an item", UVM_LOW)
        item.constraint_mode(0);
        assert(item.randomize()with{$countones(plain_text)==count;
                                    $countones(cipher_key)==count;})
        else 
            `uvm_error(get_type_name(),$sformatf("Randomization Failed"))
        `uvm_info("random_plain_text_key_Sequence","random_plain_text_key_Sequence is randomizing an item", UVM_LOW)
        finish_item(item);
        `uvm_info("random_plain_text_key_Sequence","random_plain_text_key_Sequence is finishing an item", UVM_LOW)
        count=count+1;
    endtask:do_item
    task body();
        repeat(num_transactions)begin 
            do_item();
        end
    endtask:body

    function new(string name="random_plain_text_key_Sequence");
        super.new(name); 
    endfunction
endclass:random_plain_text_key_Sequence
class random_plain_text_key_Sequence2 extends AES_Sequence ;
 `uvm_object_utils(random_plain_text_key_Sequence2)
    AES_Sequence_Item item;
    
    task do_item();
        item=AES_Sequence_Item::type_id::create("item");
        start_item(item);
        `uvm_info("random_plain_text_key_Sequence2","random_plain_text_key_Sequence2 is starting an item", UVM_LOW)
        item.constraint_mode(0);
        assert(item.randomize()with{plain_text inside {[(2**32):(2**64)-1]};
                                    cipher_key==128'h00000000000000000000000000000000 || cipher_key inside {[(2**32):(2**64)-1],[(2**64):(2**96)-1]};})
        else 
            `uvm_error(get_type_name(),$sformatf("Randomization Failed"))
        `uvm_info("random_plain_text_key_Sequence2","random_plain_text_key_Sequence2 is randomizing an item", UVM_LOW)
        finish_item(item);
        `uvm_info("random_plain_text_key_Sequence2","random_plain_text_key_Sequence2 is finishing an item", UVM_LOW)
       
    endtask:do_item
    task body();
        repeat(num_transactions)begin 
            do_item();
        end
    endtask:body

    function new(string name="random_plain_text_key_Sequence2");
        super.new(name); 
    endfunction
endclass:random_plain_text_key_Sequence2