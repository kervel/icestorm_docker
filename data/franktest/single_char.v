module single_char(i_clock, o_data, o_act);
    input wire i_clock;
    output reg [7:0] o_data;
    output reg o_act;

    reg [7:0] state;
    initial state = 8'b0;

    always @(posedge i_clock)
        begin
            state <= state+1;
        end

    always @*
        begin
            if (state == 7)
                o_act = 1;
            else   
                o_act = 0;
            if (state == 7)
                begin
                    o_data = 8'd5;
                end
            else
                begin
                    o_data = 8'b0;
                end
        end

    

endmodule
