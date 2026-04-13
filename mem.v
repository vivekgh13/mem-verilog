module mem(clk,rst,ready,valid,addr,wr_rd,w_data,r_data);
parameter WIDTH=8,
          DEPTH=8,
		  ADDR_WIDTH=$clog2(DEPTH);
input clk,rst,valid,wr_rd;
input [WIDTH-1:0] w_data;
input [ADDR_WIDTH-1:0] addr;
output reg [WIDTH-1:0] r_data;
output reg ready;

reg [WIDTH-1:0] mem [DEPTH-1:0];
integer i;

always@(posedge clk) begin
if(rst==1) begin
r_data=0;
ready=0;
for(i=0;i<DEPTH;i=i+1) begin
mem[i]=0;
end
end
else begin

if(valid==1) begin
ready=1;
if(wr_rd==1) mem[addr]=w_data;
else r_data=mem[addr];
        end
        else ready=0;
        end
  end
  

endmodule
