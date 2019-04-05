`default_nettype none

/* verilator lint_off DECLFILENAME */
module uart_tx(i_clock, i_data, i_act, o_signal, o_busy);
    input wire   [7:0] i_data;
    input  wire  i_act;
    output  wire o_signal;
    input  wire  i_clock;
    output  reg o_busy;

    reg [8:0] shift_register;
    reg [3:0] state_register;

    initial o_busy = 0;
    initial shift_register = 9'b0;
    initial state_register = 4'b0;

    always @(*)
    begin
        o_signal = shift_register[0];
    end

    always @(posedge i_clock)
    begin
      if (i_act && !o_busy)
            begin
                shift_register[8:1] <= i_data;
                o_busy <= 1;                
            end
      else if (o_busy && state_register < 4'd8)
            begin
                state_register <= state_register + 1;
                shift_register[7:0] <= shift_register[8:1];

            end
      else
            begin
              o_busy <= 0;
              state_register <= 0;
            end

    end

endmodule;
/* verilator lint_on DECLFILENAME */