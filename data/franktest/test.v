module test(clk_100mhz, pmod1_1, led1, led2, led3);
    input wire clk_100mhz;
    output wire led1;
    output wire led2;
    output wire led3;

    reg [7:0] data;
    reg next;
    output wire pmod1_1;
    reg act;
    wire busy;

    initial next = 1;
    wire i_clock;
    wire o_signal;
    assign i_clock = clk_100mhz;
    assign pmod1_1 = o_signal;

    helloworld_rom r(i_clock, next, act, data);

    assign led1 = o_signal;
    assign led2 = act;
    assign led3 = busy;

    //single_char s(i_clock, data, act);

    uart_tx tx(i_clock, data, act, o_signal,  busy);


    always @(posedge i_clock)
        begin
            next <= (!busy && !act && !next);
            //act <= next;
        end

endmodule