class mem_mon extends uvm_monitor;

virtual mem_if vif;

uvm_analysis_port#(mem_tx) mon_ap_h;

`uvm_component_utils(mem_mon);

  function new(string name,uvm_component parent);
super.new(name,parent);
mon_ap_h=new("mon_ap_h",this);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
  if(!uvm_config_db#(virtual mem_if)::get(this,"","mem_pif",vif))
`uvm_fatal("mem_mon","No vif")
  
endfunction

task run_phase(uvm_phase phase);
  mem_tx tx;
 forever begin
   @(vif.mon_cb);
   if(vif.mon_cb.valid && vif.mon_cb.ready)begin
    tx = mem_tx::type_id::create("tx");
     tx.wr_rd=vif.mon_cb.wr_rd;
	 tx.addr=vif.mon_cb.addr;
     if(vif.mon_cb.wr_rd==1) tx.wdata=vif.mon_cb.wdata;
     if(vif.mon_cb.wr_rd==0) tx.rdata=vif.mon_cb.rdata;

     `uvm_info("mem_drv",$sformatf("CMD=%s addr=%h data=%h",
                tx.wr_rd?"WR":"RD", tx.addr,tx.wr_rd? tx.wdata:tx.rdata),UVM_NONE);
	
	mon_ap_h.write(tx);
   end 
 end
endtask


endclass



