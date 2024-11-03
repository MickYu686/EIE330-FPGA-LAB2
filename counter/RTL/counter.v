module counter (
    input wire sys_clk,    // 50MHz系统时钟输入
    input wire sys_rst_n,  // 复位按键输入，低电平有效
    output reg led_out     // 控制LED灯的输出
);

// 计数器变量，位宽足够表示50MHz时钟下的计数
reg [25:0] cnt;

// 状态定义
parameter ON_TIME = 25000000;  // 0.5秒（50MHz时钟下，0.5秒等于2500万周期）
parameter OFF_TIME = 25000000; // 0.5秒

// 计数器逻辑
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        cnt <= 26'd0;       // 复位计数器
        led_out <= 1'b1;    // LED初始状态为亮
    end else if (cnt < ON_TIME + OFF_TIME - 1) begin
        cnt <= cnt + 1;     // 增加计数器
    end else begin
        cnt <= 26'd0;       // 计数器到达上限后清零
        led_out <= ~led_out; // 翻转LED状态
    end
end

endmodule
