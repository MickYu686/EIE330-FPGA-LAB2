`timescale 1ns/1ps 

module tb_counter;

reg sys_clk;
reg sys_rst_n;
wire led_out;

counter uut (
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .led_out(led_out)
);


always #10 sys_clk = ~sys_clk;

initial begin
    sys_clk = 0;
    sys_rst_n = 0;
    
    #20;
    sys_rst_n = 1;
    #100000000;
    $stop;
end

initial begin
    $monitor("Time: %0t ns, sys_rst_n = %b, led_out = %b", $time, sys_rst_n, led_out);
end

endmodule
