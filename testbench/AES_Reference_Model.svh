/*######################################################################*\
## Class Name: AES_Reference_Model   
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class AES_Reference_Model extends uvm_component;
    `uvm_component_utils(AES_Reference_Model)
    
    extern function new(string name="AES_Reference_Model",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);

    extern function bit[127:0] add_round_key(input bit[127:0]plain_text,input bit[127:0] cipher_key);
    extern function bit[127:0] substitute_bytes(input bit[127:0] in);
    extern function bit[127:0] shift_row(input bit[127:0] in);
    extern function bit[127:0] mix_columns(input bit[127:0] in);
    extern function bit[31:0] g_function(input bit[31:0] in_word,input bit[3:0]round_num);
    extern function bit[127:0] key_expansion(input bit[127:0] in_key,input bit[3:0]round_num);
    extern function bit[127:0] round1(input bit[127:0] plain_text,input bit[127:0] cipher_key);
    extern function bit[127:0] round10(input bit[127:0] plain_text,input bit[127:0] cipher_key);
    extern function bit[127:0] encryption_process(input bit[127:0] plain_text,input bit[127:0] cipher_key);

endclass:AES_Reference_Model
function AES_Reference_Model::new (string name="AES_Reference_Model", uvm_component parent =null);
    super.new(name,parent);
endfunction
function void AES_Reference_Model::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction
function bit[127:0] AES_Reference_Model::substitute_bytes(input bit[127:0] in);
    bit [7:0] sbox[16][16];//{0:15]
    sbox='{
            
  '{8'h63 , 8'h7c , 8'h77 , 8'h7b  ,8'hf2, 8'h6b, 8'h6f, 8'hc5, 8'h30, 8'h01 , 8'h67, 8'h2b, 8'hfe, 8'hd7, 8'hab, 8'h76}, 
  '{8'hca , 8'h82 , 8'hc9 , 8'h7d  ,8'hfa, 8'h59, 8'h47, 8'hf0, 8'had, 8'hd4 , 8'ha2, 8'haf, 8'h9c, 8'ha4, 8'h72, 8'hc0}, 
  '{8'hb7 , 8'hfd , 8'h93 , 8'h26  ,8'h36, 8'h3f, 8'hf7, 8'hcc, 8'h34, 8'ha5 , 8'he5, 8'hf1, 8'h71, 8'hd8, 8'h31, 8'h15}, 
  '{8'h04 , 8'hc7 , 8'h23 , 8'hc3  ,8'h18, 8'h96, 8'h05, 8'h9a, 8'h07, 8'h12 , 8'h80, 8'he2, 8'heb, 8'h27, 8'hb2, 8'h75}, 
  '{8'h09 , 8'h83 , 8'h2c , 8'h1a  ,8'h1b, 8'h6e, 8'h5a, 8'ha0, 8'h52, 8'h3b , 8'hd6, 8'hb3, 8'h29, 8'he3, 8'h2f, 8'h84}, 
  '{8'h53 , 8'hd1 , 8'h00 , 8'hed  ,8'h20, 8'hfc, 8'hb1, 8'h5b, 8'h6a, 8'hcb , 8'hbe, 8'h39, 8'h4a, 8'h4c, 8'h58, 8'hcf}, 
  '{8'hd0 , 8'hef , 8'haa , 8'hfb  ,8'h43, 8'h4d, 8'h33, 8'h85, 8'h45, 8'hf9 , 8'h02, 8'h7f, 8'h50, 8'h3c, 8'h9f, 8'ha8}, 
  '{8'h51 , 8'ha3 , 8'h40 , 8'h8f  ,8'h92, 8'h9d, 8'h38, 8'hf5, 8'hbc, 8'hb6 , 8'hda, 8'h21, 8'h10, 8'hff, 8'hf3, 8'hd2}, 
  '{8'hcd , 8'h0c , 8'h13 , 8'hec  ,8'h5f, 8'h97, 8'h44, 8'h17, 8'hc4, 8'ha7 , 8'h7e, 8'h3d, 8'h64, 8'h5d, 8'h19, 8'h73}, 
  '{8'h60 , 8'h81 , 8'h4f , 8'hdc  ,8'h22, 8'h2a, 8'h90, 8'h88, 8'h46, 8'hee , 8'hb8, 8'h14, 8'hde, 8'h5e, 8'h0b, 8'hdb}, 
  '{8'he0 , 8'h32 , 8'h3a , 8'h0a  ,8'h49, 8'h06, 8'h24, 8'h5c, 8'hc2, 8'hd3 , 8'hac, 8'h62, 8'h91, 8'h95, 8'he4, 8'h79}, 
  '{8'he7 , 8'hc8 , 8'h37 , 8'h6d  ,8'h8d, 8'hd5, 8'h4e, 8'ha9, 8'h6c, 8'h56 , 8'hf4, 8'hea, 8'h65, 8'h7a, 8'hae, 8'h08}, 
  '{8'hba , 8'h78 , 8'h25 , 8'h2e  ,8'h1c, 8'ha6, 8'hb4, 8'hc6, 8'he8, 8'hdd , 8'h74, 8'h1f, 8'h4b, 8'hbd, 8'h8b, 8'h8a}, 
  '{8'h70 , 8'h3e , 8'hb5 , 8'h66  ,8'h48, 8'h03, 8'hf6, 8'h0e, 8'h61, 8'h35 , 8'h57, 8'hb9, 8'h86, 8'hc1, 8'h1d, 8'h9e}, 
  '{8'he1 , 8'hf8 , 8'h98 , 8'h11  ,8'h69, 8'hd9, 8'h8e, 8'h94, 8'h9b, 8'h1e , 8'h87, 8'he9, 8'hce, 8'h55, 8'h28, 8'hdf}, 
  '{8'h8c , 8'ha1 , 8'h89 , 8'h0d  ,8'hbf, 8'he6, 8'h42, 8'h68, 8'h41, 8'h99 , 8'h2d, 8'h0f, 8'hb0, 8'h54, 8'hbb, 8'h16}         
    };
    
    for(int i=0;i<4;i++)begin
        substitute_bytes[120-(i*32)+:8]=sbox[in[124-(i*32)+:4]][in[120-(i*32)+:4]];
        substitute_bytes[112-(i*32)+:8]=sbox[in[116-(i*32)+:4]][in[112-(i*32)+:4]];
        substitute_bytes[104-(i*32)+:8]=sbox[in[108-(i*32)+:4]][in[104-(i*32)+:4]];
        substitute_bytes[96-(i*32)+:8]=sbox[in[100-(i*32)+:4]][in[96-(i*32)+:4]];
    
    end
   
endfunction
function bit[127:0] AES_Reference_Model::shift_row(input bit[127:0] in);
        {shift_row[127:120],shift_row[95:88],shift_row[63:56],shift_row[31:24]}= {in[127:120],in[95:88],in[63:56],in[31:24]};
        {shift_row[119:112],shift_row[87:80],shift_row[55:48],shift_row[23:16]}={in[87:80],in[55:48],in[23:16],in[119:112]};
        {shift_row[111:104],shift_row[79:72],shift_row[47:40],shift_row[15:8]}={in[47:40],in[15:8],in[111:104],in[79:72]};
        {shift_row[103:96],shift_row[71:64],shift_row[39:32],shift_row[7:0]}={in[7:0],in[103:96],in[71:64],in[39:32]};
     
endfunction

function bit[127:0] AES_Reference_Model::mix_columns(input bit[127:0] in);
bit [7:0] multiply_2[16][16];
bit [7:0] multiply_3[16][16];
    multiply_2='{
    '{8'h00 , 8'h02 , 8'h04 , 8'h06 , 8'h08 , 8'h0a , 8'h0c , 8'h0e , 8'h10 , 8'h12 , 8'h14 , 8'h16 , 8'h18 , 8'h1a , 8'h1c , 8'h1e},
    '{8'h20 , 8'h22 , 8'h24 , 8'h26 , 8'h28 , 8'h2a , 8'h2c , 8'h2e , 8'h30 , 8'h32 , 8'h34 , 8'h36 , 8'h38 , 8'h3a , 8'h3c , 8'h3e},
    '{8'h40 , 8'h42 , 8'h44 , 8'h46 , 8'h48 , 8'h4a , 8'h4c , 8'h4e , 8'h50 , 8'h52 , 8'h54 , 8'h56 , 8'h58 , 8'h5a , 8'h5c , 8'h5e},
    '{8'h60 , 8'h62 , 8'h64 , 8'h66 , 8'h68 , 8'h6a , 8'h6c , 8'h6e , 8'h70 , 8'h72 , 8'h74 , 8'h76 , 8'h78 , 8'h7a , 8'h7c , 8'h7e},
    '{8'h80 , 8'h82 , 8'h84 , 8'h86 , 8'h88 , 8'h8a , 8'h8c , 8'h8e , 8'h90 , 8'h92 , 8'h94 , 8'h96 , 8'h98 , 8'h9a , 8'h9c , 8'h9e},
    '{8'ha0 , 8'ha2 , 8'ha4 , 8'ha6 , 8'ha8 , 8'haa , 8'hac , 8'hae , 8'hb0 , 8'hb2 , 8'hb4 , 8'hb6 , 8'hb8 , 8'hba , 8'hbc , 8'hbe},
    '{8'hc0 , 8'hc2 , 8'hc4 , 8'hc6 , 8'hc8 , 8'hca , 8'hcc , 8'hce , 8'hd0 , 8'hd2 , 8'hd4 , 8'hd6 , 8'hd8 , 8'hda , 8'hdc , 8'hde},
    '{8'he0 , 8'he2 , 8'he4 , 8'he6 , 8'he8 , 8'hea , 8'hec , 8'hee , 8'hf0 , 8'hf2 , 8'hf4 , 8'hf6 , 8'hf8 , 8'hfa , 8'hfc , 8'hfe},
    '{8'h1b , 8'h19 , 8'h1f , 8'h1d , 8'h13 , 8'h11 , 8'h17 , 8'h15 , 8'h0b , 8'h09 , 8'h0f , 8'h0d , 8'h03 , 8'h01 , 8'h07 , 8'h05},
    '{8'h3b , 8'h39 , 8'h3f , 8'h3d , 8'h33 , 8'h31 , 8'h37 , 8'h35 , 8'h2b , 8'h29 , 8'h2f , 8'h2d , 8'h23 , 8'h21 , 8'h27 , 8'h25},
    '{8'h5b , 8'h59 , 8'h5f , 8'h5d , 8'h53 , 8'h51 , 8'h57 , 8'h55 , 8'h4b , 8'h49 , 8'h4f , 8'h4d , 8'h43 , 8'h41 , 8'h47 , 8'h45},
    '{8'h7b , 8'h79 , 8'h7f , 8'h7d , 8'h73 , 8'h71 , 8'h77 , 8'h75 , 8'h6b , 8'h69 , 8'h6f , 8'h6d , 8'h63 , 8'h61 , 8'h67 , 8'h65},
    '{8'h9b , 8'h99 , 8'h9f , 8'h9d , 8'h93 , 8'h91 , 8'h97 , 8'h95 , 8'h8b , 8'h89 , 8'h8f , 8'h8d , 8'h83 , 8'h81 , 8'h87 , 8'h85},
    '{8'hbb , 8'hb9 , 8'hbf , 8'hbd , 8'hb3 , 8'hb1 , 8'hb7 , 8'hb5 , 8'hab , 8'ha9 , 8'haf , 8'had , 8'ha3 , 8'ha1 , 8'ha7 , 8'ha5},
    '{8'hdb , 8'hd9 , 8'hdf , 8'hdd , 8'hd3 , 8'hd1 , 8'hd7 , 8'hd5 , 8'hcb , 8'hc9 , 8'hcf , 8'hcd , 8'hc3 , 8'hc1 , 8'hc7 , 8'hc5},
    '{8'hfb , 8'hf9 , 8'hff , 8'hfd , 8'hf3 , 8'hf1 , 8'hf7 , 8'hf5 , 8'heb , 8'he9 , 8'hef , 8'hed , 8'he3 , 8'he1 , 8'he7 , 8'he5}
};
    multiply_3='{
    '{8'h00 , 8'h03 , 8'h06 , 8'h05 , 8'h0c , 8'h0f , 8'h0a , 8'h09 , 8'h18 , 8'h1b , 8'h1e , 8'h1d , 8'h14 , 8'h17 , 8'h12 , 8'h11},
    '{8'h30 , 8'h33 , 8'h36 , 8'h35 , 8'h3c , 8'h3f , 8'h3a , 8'h39 , 8'h28 , 8'h2b , 8'h2e , 8'h2d , 8'h24 , 8'h27 , 8'h22 , 8'h21},
    '{8'h60 , 8'h63 , 8'h66 , 8'h65 , 8'h6c , 8'h6f , 8'h6a , 8'h69 , 8'h78 , 8'h7b , 8'h7e , 8'h7d , 8'h74 , 8'h77 , 8'h72 , 8'h71},
    '{8'h50 , 8'h53 , 8'h56 , 8'h55 , 8'h5c , 8'h5f , 8'h5a , 8'h59 , 8'h48 , 8'h4b , 8'h4e , 8'h4d , 8'h44 , 8'h47 , 8'h42 , 8'h41},
    '{8'hc0 , 8'hc3 , 8'hc6 , 8'hc5 , 8'hcc , 8'hcf , 8'hca , 8'hc9 , 8'hd8 , 8'hdb , 8'hde , 8'hdd , 8'hd4 , 8'hd7 , 8'hd2 , 8'hd1},
    '{8'hf0 , 8'hf3 , 8'hf6 , 8'hf5 , 8'hfc , 8'hff , 8'hfa , 8'hf9 , 8'he8 , 8'heb , 8'hee , 8'hed , 8'he4 , 8'he7 , 8'he2 , 8'he1},
    '{8'ha0 , 8'ha3 , 8'ha6 , 8'ha5 , 8'hac , 8'haf , 8'haa , 8'ha9 , 8'hb8 , 8'hbb , 8'hbe , 8'hbd , 8'hb4 , 8'hb7 , 8'hb2 , 8'hb1},
    '{8'h90 , 8'h93 , 8'h96 , 8'h95 , 8'h9c , 8'h9f , 8'h9a , 8'h99 , 8'h88 , 8'h8b , 8'h8e , 8'h8d , 8'h84 , 8'h87 , 8'h82 , 8'h81},
    '{8'h9b , 8'h98 , 8'h9d , 8'h9e , 8'h97 , 8'h94 , 8'h91 , 8'h92 , 8'h83 , 8'h80 , 8'h85 , 8'h86 , 8'h8f , 8'h8c , 8'h89 , 8'h8a},
    '{8'hab , 8'ha8 , 8'had , 8'hae , 8'ha7 , 8'ha4 , 8'ha1 , 8'ha2 , 8'hb3 , 8'hb0 , 8'hb5 , 8'hb6 , 8'hbf , 8'hbc , 8'hb9 , 8'hba},
    '{8'hfb , 8'hf8 , 8'hfd , 8'hfe , 8'hf7 , 8'hf4 , 8'hf1 , 8'hf2 , 8'he3 , 8'he0 , 8'he5 , 8'he6 , 8'hef , 8'hec , 8'he9 , 8'hea},
    '{8'hcb , 8'hc8 , 8'hcd , 8'hce , 8'hc7 , 8'hc4 , 8'hc1 , 8'hc2 , 8'hd3 , 8'hd0 , 8'hd5 , 8'hd6 , 8'hdf , 8'hdc , 8'hd9 , 8'hda},
    '{8'h5b , 8'h58 , 8'h5d , 8'h5e , 8'h57 , 8'h54 , 8'h51 , 8'h52 , 8'h43 , 8'h40 , 8'h45 , 8'h46 , 8'h4f , 8'h4c , 8'h49 , 8'h4a},
    '{8'h6b , 8'h68 , 8'h6d , 8'h6e , 8'h67 , 8'h64 , 8'h61 , 8'h62 , 8'h73 , 8'h70 , 8'h75 , 8'h76 , 8'h7f , 8'h7c , 8'h79 , 8'h7a},
    '{8'h3b , 8'h38 , 8'h3d , 8'h3e , 8'h37 , 8'h34 , 8'h31 , 8'h32 , 8'h23 , 8'h20 , 8'h25 , 8'h26 , 8'h2f , 8'h2c , 8'h29 , 8'h2a},
    '{8'h0b , 8'h08 , 8'h0d , 8'h0e , 8'h07 , 8'h04 , 8'h01 , 8'h02 , 8'h13 , 8'h10 , 8'h15 , 8'h16 , 8'h1f , 8'h1c , 8'h19 , 8'h1a}
};
    for(int i=0;i<4;i++)begin
        /*
            mix_columns[127-(i*8):120-(i*8)]=(multiply_2[in[127-(i*8):124-(i*8)]][in[123-(i*8):120-(i*8)]])^(multiply_3[in[119-(i*8):116-(i*8)]][in[115-(i*8):112-(i*8)]])^(in[111-(i*8):104-(i*8)])^(in[103-(i*8):96-(i*8)]);
            mix_columns[119:112]=(in[127:120])^(multiply_2[in[119:116]][in[115:112]])^(multiply_3[in[111:108]][in[107:104]])^(in[103:96]);
            mix_columns[111:104]=(in[127:120])^(in[119:112])^(multiply_2[in[111:108]][in[107:104]])^(multiply_3[in[103:100]][in[99:96]]);
            mix_columns[103:96]=(multiply_3[in[127:124]][in[123:120]])^(in[119:112])^(in[111:104])^(multiply_2[in[103:100]][in[99:96]]);
            
       */
            mix_columns[120-(i*32)+:8]=(multiply_2[in[124-(i*32)+:4]][in[120-(i*32)+:4]])^(multiply_3[in[116-(i*32)+:4]][in[112-(i*32)+:4]])^(in[104-(i*32)+:8])^(in[96-(i*32)+:8]);
            mix_columns[112-(i*32)+:8]=(in[120-(i*32)+:8])^(multiply_2[in[116-(i*32)+:4]][in[112-(i*32)+:4]])^(multiply_3[in[108-(i*32)+:4]][in[104-(i*32)+:4]])^(in[96-(i*32)+:8]);
            mix_columns[104-(i*32)+:8]=(in[120-(i*32)+:8])^(in[112-(i*32)+:8])^(multiply_2[in[108-(i*32)+:4]][in[104-(i*32)+:4]])^(multiply_3[in[100-(i*32)+:4]][in[96-(i*32)+:4]]);
            mix_columns[96-(i*32)+:8]=(multiply_3[in[124-(i*32)+:4]][in[120-(i*32)+:4]])^(in[112-(i*32)+:8])^(in[104-(i*32)+:8])^(multiply_2[in[100-(i*32)+:4]][in[96-(i*32)+:4]]);
    
    end
    
endfunction
function bit[127:0] AES_Reference_Model::add_round_key(input bit[127:0]plain_text,input bit[127:0] cipher_key);

    add_round_key = plain_text ^ cipher_key;
    
endfunction
function bit[31:0] AES_Reference_Model::g_function(input bit[31:0] in_word,input bit[3:0]round_num);
    bit[31:0] rot_word;
    bit[31:0] sub_word;
    bit[7:0] rc[10];
    bit[31:0] rcon[10];
    bit [7:0] sbox[16][16];//{0:15]
    rc='{8'h01,8'h02,8'h04,8'h08,8'h10,8'h20,8'h40,8'h80,8'h1b,8'h36};
    foreach(rcon[i])begin
        rcon[i]={rc[i],8'h00,8'h00,8'h00};
    end
    sbox='{     
  '{8'h63 , 8'h7c , 8'h77 , 8'h7b  ,8'hf2, 8'h6b, 8'h6f, 8'hc5, 8'h30, 8'h01 , 8'h67, 8'h2b, 8'hfe, 8'hd7, 8'hab, 8'h76}, 
  '{8'hca , 8'h82 , 8'hc9 , 8'h7d  ,8'hfa, 8'h59, 8'h47, 8'hf0, 8'had, 8'hd4 , 8'ha2, 8'haf, 8'h9c, 8'ha4, 8'h72, 8'hc0}, 
  '{8'hb7 , 8'hfd , 8'h93 , 8'h26  ,8'h36, 8'h3f, 8'hf7, 8'hcc, 8'h34, 8'ha5 , 8'he5, 8'hf1, 8'h71, 8'hd8, 8'h31, 8'h15}, 
  '{8'h04 , 8'hc7 , 8'h23 , 8'hc3  ,8'h18, 8'h96, 8'h05, 8'h9a, 8'h07, 8'h12 , 8'h80, 8'he2, 8'heb, 8'h27, 8'hb2, 8'h75}, 
  '{8'h09 , 8'h83 , 8'h2c , 8'h1a  ,8'h1b, 8'h6e, 8'h5a, 8'ha0, 8'h52, 8'h3b , 8'hd6, 8'hb3, 8'h29, 8'he3, 8'h2f, 8'h84}, 
  '{8'h53 , 8'hd1 , 8'h00 , 8'hed  ,8'h20, 8'hfc, 8'hb1, 8'h5b, 8'h6a, 8'hcb , 8'hbe, 8'h39, 8'h4a, 8'h4c, 8'h58, 8'hcf}, 
  '{8'hd0 , 8'hef , 8'haa , 8'hfb  ,8'h43, 8'h4d, 8'h33, 8'h85, 8'h45, 8'hf9 , 8'h02, 8'h7f, 8'h50, 8'h3c, 8'h9f, 8'ha8}, 
  '{8'h51 , 8'ha3 , 8'h40 , 8'h8f  ,8'h92, 8'h9d, 8'h38, 8'hf5, 8'hbc, 8'hb6 , 8'hda, 8'h21, 8'h10, 8'hff, 8'hf3, 8'hd2}, 
  '{8'hcd , 8'h0c , 8'h13 , 8'hec  ,8'h5f, 8'h97, 8'h44, 8'h17, 8'hc4, 8'ha7 , 8'h7e, 8'h3d, 8'h64, 8'h5d, 8'h19, 8'h73}, 
  '{8'h60 , 8'h81 , 8'h4f , 8'hdc  ,8'h22, 8'h2a, 8'h90, 8'h88, 8'h46, 8'hee , 8'hb8, 8'h14, 8'hde, 8'h5e, 8'h0b, 8'hdb}, 
  '{8'he0 , 8'h32 , 8'h3a , 8'h0a  ,8'h49, 8'h06, 8'h24, 8'h5c, 8'hc2, 8'hd3 , 8'hac, 8'h62, 8'h91, 8'h95, 8'he4, 8'h79}, 
  '{8'he7 , 8'hc8 , 8'h37 , 8'h6d  ,8'h8d, 8'hd5, 8'h4e, 8'ha9, 8'h6c, 8'h56 , 8'hf4, 8'hea, 8'h65, 8'h7a, 8'hae, 8'h08}, 
  '{8'hba , 8'h78 , 8'h25 , 8'h2e  ,8'h1c, 8'ha6, 8'hb4, 8'hc6, 8'he8, 8'hdd , 8'h74, 8'h1f, 8'h4b, 8'hbd, 8'h8b, 8'h8a}, 
  '{8'h70 , 8'h3e , 8'hb5 , 8'h66  ,8'h48, 8'h03, 8'hf6, 8'h0e, 8'h61, 8'h35 , 8'h57, 8'hb9, 8'h86, 8'hc1, 8'h1d, 8'h9e}, 
  '{8'he1 , 8'hf8 , 8'h98 , 8'h11  ,8'h69, 8'hd9, 8'h8e, 8'h94, 8'h9b, 8'h1e , 8'h87, 8'he9, 8'hce, 8'h55, 8'h28, 8'hdf}, 
  '{8'h8c , 8'ha1 , 8'h89 , 8'h0d  ,8'hbf, 8'he6, 8'h42, 8'h68, 8'h41, 8'h99 , 8'h2d, 8'h0f, 8'hb0, 8'h54, 8'hbb, 8'h16}         
    };
    rot_word={in_word[23:16],in_word[15:8],in_word[7:0],in_word[31:24]};
    sub_word={sbox[rot_word[31:28]][rot_word[27:24]],sbox[rot_word[23:20]][rot_word[19:16]],sbox[rot_word[15:12]][rot_word[11:8]],sbox[rot_word[7:4]][rot_word[3:0]]};
    g_function=sub_word ^ rcon[round_num] ;
endfunction

function bit[127:0] AES_Reference_Model::key_expansion(input bit[127:0] in_key,input bit[3:0]round_num);
   
    key_expansion[127:96]=in_key[127:96] ^ g_function(in_key[31:0],round_num);
    key_expansion[95:64]=key_expansion[127:96] ^ in_key[95:64] ;
    key_expansion[63:32]=key_expansion[95:64] ^ in_key[63:32] ;
    key_expansion[31:0]=key_expansion[63:32] ^ in_key[31:0] ;
    
endfunction

function bit[127:0] AES_Reference_Model::round1(input bit[127:0] plain_text,input bit[127:0] cipher_key);

    bit[127:0] substitute_bytes_out;
    bit[127:0] shift_row_out;
    bit[127:0] mix_columns_out;
    bit[127:0] add_round_key_out;

    substitute_bytes_out=substitute_bytes(plain_text);
    shift_row_out=shift_row(substitute_bytes_out);
    mix_columns_out=mix_columns(shift_row_out);
    add_round_key_out=add_round_key(mix_columns_out,cipher_key);
    round1=add_round_key_out;
    
endfunction

function bit[127:0] AES_Reference_Model::round10(input bit[127:0] plain_text,input bit[127:0] cipher_key);
    bit[127:0] substitute_bytes_out;
    bit[127:0] shift_row_out;
    bit[127:0] add_round_key_out;
    substitute_bytes_out=substitute_bytes(plain_text);
    shift_row_out=shift_row(substitute_bytes_out);
    add_round_key_out=add_round_key(shift_row_out,cipher_key);
    round10=add_round_key_out;
    
endfunction

function bit[127:0] AES_Reference_Model::encryption_process(input bit[127:0] plain_text,input bit[127:0] cipher_key);

    bit[127:0] substitute_bytes_out;
    bit[127:0] shift_row_out;
    bit[127:0] mix_columns_out;
    bit[127:0] add_round_key_out;
    bit[127:0] key[10];
    bit[127:0] round_out[10];

    add_round_key_out=add_round_key(plain_text,cipher_key);
    key[0]=key_expansion(cipher_key,0);//round 1
    round_out[0]=round1(add_round_key_out,key[0]);
    for(int i=1;i<9;i++)begin//round 2 to round 9
        key[i]=key_expansion(key[i-1],i);
        round_out[i]=round1(round_out[i-1],key[i]);

    end
    key[9]=key_expansion(key[8],9);
    round_out[9]=round10(round_out[8],key[9]);//round10
    encryption_process=round_out[9];
    
endfunction


/*
example
128'h54776F204F6E65204E696E652054776F        plaintext
128'h5468617473206D79204B756E67204675        cipherkey
128'h29C3505F571420F6402299B31A02D73A        ciphertext

*/