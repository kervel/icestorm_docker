`default_nettype none

module helloworld_rom(i_clock, i_next, o_act,  o_data);
    input wire i_clock;
    input wire i_next;
    output reg o_act;
    wire[7:0] data;
    output wire [7:0] o_data;

    reg [6:0] idx;
    reg [7:0] romcontents[0:100];
    reg booted;
    initial
        begin
            integer i;
            localparam val = "Hello world";
            booted = 0;
            for (i=0; i<11; i=i+1) begin
                integer j = 10-i;
                romcontents[i] = val[(j*8)+: 8];
            end
            idx = 0;
        end
    assign data = romcontents[idx];
    assign o_data = o_act ? data : 8'b00000000;
    always @(posedge i_clock)
        begin
            booted <= 1;
            if (i_next)
                begin
                    o_act <= 1;
                    if (data == 8'b00000000)
                        begin
                            idx <= 0;
                        end
                    else
                        if (booted) 
                            idx <= idx + 1;
                end
            else
                o_act <= 0;
        end
endmodule
