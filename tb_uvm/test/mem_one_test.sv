class mem_one_wr_one_rd_test extends uvm_test;

mem_env env_h;

`uvm_component_utils(mem_one_wr_one_rd_test)

function new(string name,uvm_component parent);
 super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 env_h=mem_env::type_id::create("env_h",this);
endfunction

  function void end_of_elaboration();
uvm_top.print_topology();

endfunction

task run_phase(uvm_phase phase);
 mem_one_wr_one_rd_seq seq_h;
phase.raise_objection(this);

seq_h= mem_one_wr_one_rd_seq::type_id::create("seq_h",this);
seq_h.start(env_h.agent_h.sqr_h);
  phase.phase_done.set_drain_time(this,100);

phase.drop_objection(this);

endtask

endclass

