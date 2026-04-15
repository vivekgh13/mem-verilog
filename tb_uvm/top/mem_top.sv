module top;
//clk rst
bit clk,rst;

always #5 clk=~clk;

mem_if pif(clk,rst);

mem dut(.clk(clk),
        .rst(rst),
        .wr_rd(pif.wr_rd),
        .addr(pif.addr),
        .w_data(pif.wdata),
        .r_data(pif.rdata),
        .valid(pif.valid),
        .ready(pif.ready));

initial begin
rst=1;
pif.wdata=0;

pif.wr_rd=0;
pif.valid=0;
repeat(2) @(posedge clk);
rst=0;
end

initial begin
 uvm_config_db#(virtual mem_if)::set(null,"*.agent_h.*","mem_pif",pif);
 run_test("mem_one_wr_one_rd_test");
end
  
 initial begin
   $dumpfile("dump.vcd");
    $dumpvars(0,top);
  end
endmodule
