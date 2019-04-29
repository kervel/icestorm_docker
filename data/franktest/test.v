module test(clk_100mhz, pmod1_1);
    input wire clk_100mhz;

    reg [7:0] data;
    reg next;
    output wire pmod1_1;
    reg act;
    wire busy;

    initial next = 1;
    wire i_clock;
    wire o_signal;
    assign i_clock = clk_100mhz;
    assign pmos1_1 = o_signal;

    helloworld_rom r(i_clock, next, act, data);



    //single_char s(i_clock, data, act);

    uart_tx tx(i_clock, data, act, o_signal,  busy);


    always @(posedge i_clock)
        begin
            next <= (!busy && !act && !next);
            //act <= next;
        end

endmodule