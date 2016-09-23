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