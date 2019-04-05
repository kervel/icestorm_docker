module test(i_clock, o_signal);
    input wire i_clock;

    reg [7:0] data;
    reg next;
    output wire o_signal;
    reg act;
    wire busy;

    initial next = 1;

    helloworld_rom r(i_clock, next, data);


    uart_tx tx(i_clock, data, act, o_signal,  busy);


    always @(posedge i_clock)
        begin
            next <= (!busy && !act && !next);
            act <= next;
        end

endmodule;
