interface mem_if(input logic clk,input logic rst);

logic wr_rd;
logic [`WIDTH-1:0]wdata;
logic [`WIDTH-1:0]rdata;
logic [`ADDR_WIDTH-1:0]addr;
logic valid;
logic ready;

  clocking drv_cb@(posedge clk);
  default input#1 output#1;
   output wr_rd;
   output valid;
   output wdata;
   output addr;

   input rdata;
   input ready;
endclocking

  clocking mon_cb@(posedge clk);
  default input#1 ;
   input wr_rd;
   input valid;
   input wdata;
   input addr;

   input rdata;
   input ready;
 endclocking
endinterface

