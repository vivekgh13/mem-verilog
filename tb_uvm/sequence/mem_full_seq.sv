class mem_full_wr_full_rd_seq extends uvm_sequence;

`uvm_object_utils(mem_full_wr_full_rd_seq)



rand bit [`ADDR_WIDTH-1:0]addr[$];

constraint size{
  addr.size()==7;
}

constraint addr_c{
  unique {addr};
   foreach(addr[i])
     addr[i] inside {[0:`DEPTH-1]};
}

  function new(string name="seq_h");
super.new(name);
endfunction

task body();
  mem_tx req;
  assert(this.randomize());

foreach(addr[i]) begin
 `uvm_do_with(req,{req.wr_rd==1;
                   req.addr==local::addr[i];});
end
   foreach (addr[i]) begin
   `uvm_do_with(req,{req.wr_rd==0;
                     req.addr==local::addr[i];});
	end
  `uvm_info("SEQ", "Sequence started", UVM_NONE)
endtask
endclass

