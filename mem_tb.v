`include "mem.v"
module tb;
parameter WIDTH=8,
          DEPTH=8,
		  ADDR_WIDTH=$clog2(DEPTH);
reg clk,rst,valid,wr_rd;
  
reg [WIDTH-1:0] w_data;
reg [ADDR_WIDTH-1:0] addr;
 wire [WIDTH-1:0] r_data;
 wire ready;
 integer i;
  reg [8*20:1] testname;
  

mem dut(clk,rst,ready,valid,addr,wr_rd,w_data,r_data);

  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
  end
  
initial begin
clk=0;
forever #5 clk=~clk;
end


  task reset_dut();  
rst=1;
w_data=0;
wr_rd=0;
valid=0;
addr=0;
repeat(2) @(posedge clk);
rst=0;
  endtask
  
  task full_wr_full_rd();
//write
for(i=0;i<DEPTH;i=i+1) begin
@(posedge clk);
addr=i;
w_data=$random;
wr_rd=1;

valid=1;
  wait(ready==1);

@(posedge clk);
//dr=0;
wr_rd=0;
//data=0;
valid=0;
end
  
  //read
for(i=0;i<DEPTH;i=i+1) begin
@(posedge clk);
addr=i;
wr_rd=0;

valid=1;
  wait(ready==1);

@(posedge clk);
//addr=0;
wr_rd=0;
w_data=0;
valid=0;
end
  endtask
  
  task one_wr_one_rd();
//write
//for(i=0;i<DEPTH;i=i+1) begin
@(posedge clk);
addr=3;
w_data=8'h7;
wr_rd=1;

valid=1;
  wait(ready==1);

@(posedge clk);
//dr=0;
wr_rd=0;
//data=0;
valid=0;

  
  //read
//for(i=0;i<DEPTH;i=i+1) begin
@(posedge clk);
addr=3;
wr_rd=0;

valid=1;
  wait(ready==1);

@(posedge clk);
addr=0;
wr_rd=0;
w_data=0;
valid=0;

  endtask
  
  task n_wr_n_rd(int N);
//write
    for(i=0;i<N;i=i+1) begin
@(posedge clk);
addr=i%DEPTH;
w_data=$random;
wr_rd=1;

valid=1;
  wait(ready==1);

@(posedge clk);
//dr=0;
wr_rd=0;
//data=0;
valid=0;
    end
  
  //read
    for(i=0;i<N;i=i+1) begin
@(posedge clk);
addr=i%DEPTH;
wr_rd=0;

valid=1;
  wait(ready==1);

@(posedge clk);
//addr=0;
wr_rd=0;
w_data=0;
valid=0;
end
  endtask
  
      initial begin
        reset_dut();
        if( $value$plusargs("TEST=%s",testname)) begin
        case(testname)
          "one":one_wr_one_rd();
          "full":full_wr_full_rd();
          "N":n_wr_n_rd(5);
          default:$display("unknown test");
        endcase
        end
      end
  
initial begin
#1000;
$finish;
end
endmodule


