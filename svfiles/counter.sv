module counter(
    input Reset, 
    input Clk,
    input enable, 
    output [7:0] out

);

always_ff @ (posedge Clk)begin

    if(Reset)
        out <= 8'b0;
    else if(enable)
        out <= out + 1; 
end
endmodule 