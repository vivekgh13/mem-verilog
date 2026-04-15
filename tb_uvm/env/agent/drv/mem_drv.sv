class mem_drv extends uvm_driver#(mem_tx);

virtual mem_if vif;

`uvm_component_utils(mem_drv);

function new(string name,uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
  if(!uvm_config_db#(virtual mem_if)::get(this,"","mem_pif",vif))
`uvm_fatal("mem_drv","No vif")
endfunction

task run_phase(uvm_phase phase);
 forever begin
   seq_item_port.get_next_item(req);
   `uvm_info("DRV", "Got transaction", UVM_NONE)
   drive_tx(req);

   seq_item_port.item_done();
 end
endtask

task drive_tx(mem_tx tx);
@(vif.drv_cb);
vif.drv_cb.wr_rd<=tx.wr_rd;
vif.drv_cb.addr<=tx.addr;

if(tx.wr_rd==1)
vif.drv_cb.wdata<=tx.wdata;
vif.drv_cb.valid<=1;
  @(vif.drv_cb);
  wait(vif.drv_cb.ready==1);

if(tx.wr_rd==0)
tx.rdata<=vif.drv_cb.rdata;

`uvm_info("mem_drv",$sformatf("CMD=%s addr=%h data=%h",
           tx.wr_rd?"WR":"RD", tx.addr,tx.wr_rd? tx.wdata:tx.rdata),UVM_NONE);
vif.drv_cb.valid<=0;
vif.drv_cb.wr_rd<=0;
//vif.drv_cb.addr<=0;
//vif.drv_cb.wdata<=0;
`uvm_info("DRV", "Got transaction", UVM_NONE)
endtask
endclass

