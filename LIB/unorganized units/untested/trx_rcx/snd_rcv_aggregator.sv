module snd_rcv_aggregator #(
    parameter N = 4,
    parameter M = 2 
) (
  input  clk,          
  input  rst_n,         

  input  vld_in,           
  input  [N-1:0] data_in,  
  output rdy_out,           

  output vld_out,             
  output [M*N-1:0] data_out,  
  input  rdy_in               
);

    logic [$clog2(M):0]  count;
    logic [$clog2(M):0]    blocked_count;
    logic [M*N-1:0]        buffer;

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin 
            count <= 0;
            blocked_count <= 0;
            buffer <= 0;
            data_out <= 0;
        end
        else begin
            if (rdy_out && vld_in) begin
                count <= (count < 2*M-1 )?count +1:0;
                buffer <= {(buffer[(M-1)*N-1:0] << N), data_in}
            end
            else begin 
                count <= count;
            end
            if (~rdy_in and vld_out) begin
                blocked_count <= (blocked_count < 2*M-1)? blocked_count +1: blocked_count;
            end else begin
                blocked_count <= 0;
            end
            
            data_out <= (count[$clog2(M)-1:0] == M-1)? buffer: data_in;
        
        end
    end
    
    always_comb begin 
        rdy_out = (blocked_count != 2*M-1);
        vld_out = (count > M-1) && rdy_in;
        
    end
endmodule