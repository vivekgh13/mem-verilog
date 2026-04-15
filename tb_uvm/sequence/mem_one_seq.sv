class mem_one_wr_one_rd_seq extends uvm_sequence#(mem_tx);

  mem_tx tx_t;
`uvm_object_utils(mem_one_wr_one_rd_seq)

  function new(string name="seq_h");
super.new(name);
endfunction

task body();
  `uvm_do_with(req,{req.wr_rd==1;});
   tx_t=new req;
  `uvm_do_with(req,{req.wr_rd==0;
                    req.addr==tx_t.addr;});

endtask
endclass

