/* Copyright (C) 2017 ETH Zurich, University of Bologna
 * All rights reserved.
 *
 * This code is under development and not yet released to the public.
 * Until it is released, the code is under the copyright of ETH Zurich and
 * the University of Bologna, and may contain confidential and/or unpublished 
 * work. Any reuse/redistribution is strictly forbidden without written
 * permission from ETH Zurich.
 *
 * Bug fixes and contributions will eventually be released under the
 * SolderPad open hardware license in the context of the PULP platform
 * (http://www.pulp-platform.org), under the copyright of ETH Zurich and the
 * University of Bologna.
 */

module ID_Gen_1
#(
    parameter ID_WIDTH_IN   = 8,
    parameter ID_WIDTH_OUT  = 6
)
(
    input   logic                               clk,
    input   logic                               rst_n,

    input   logic                               incr_i,
    output  logic                               full_o,
    input   logic [ID_WIDTH_IN-1:0]             ID_i,
    output  logic [ID_WIDTH_OUT-1:0]            ID_o,

    input   logic                               release_ID_i,
    input   logic [ID_WIDTH_OUT-1:0]            BID_i,
    output  logic [ID_WIDTH_IN-1:0]             BID_o,
    output  logic                               empty_o
);

integer i;
localparam     N_ENTRY = 1;
localparam     LOG_N_ENTRY = 0;



logic                                            VALID_TABLE;
logic [ID_WIDTH_IN-1:0]                          ID_TABLE;

logic                                            valid_ID_o;

assign ID_o = '0;

assign full_o  = ~valid_ID_o;
assign empty_o = ~(|VALID_TABLE);

assign BID_o = ID_TABLE;


always_ff @(posedge clk, negedge rst_n)
begin
  if(rst_n == 1'b0)
    begin
      VALID_TABLE <= 1'b0;
      ID_TABLE    <= '0;
    end
  else
    begin
      if(release_ID_i)
        VALID_TABLE <= 1'b0;
      else;
        begin
          if(incr_i)
            begin 
              VALID_TABLE <= 1'b1;
              ID_TABLE    <= ID_i;
            end
        end
    end
end

always_comb
begin
  if(VALID_TABLE)
    valid_ID_o        = 1'b0;
  else
    valid_ID_o        = 1'b1;
end

endmodule