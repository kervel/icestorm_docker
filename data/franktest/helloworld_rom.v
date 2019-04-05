`default_nettype none

module helloworld_rom(i_clock, i_next, o_data);
    input wire i_clock;
    input wire i_next;
    output wire [7:0] o_data;

    reg [6:0] idx;
    reg [7:0] romcontents[0:100];
    reg have_read;
    initial
        begin
            integer i;
            localparam val = "Hello world";
            have_read = 0;
            for (i=0; i<11; i=i+1) begin
                integer j = 10-i;
                romcontents[i] = val[(j*8)+: 8];
            end
            idx = 0;
        end
    always @(posedge i_clock)
        begin
            o_data <= romcontents[idx];
            have_read <= 1;
            if (i_next)
                if (o_data == 8'b00000000 && have_read)
                    begin
                        idx <= 0;
                        have_read <= 0;
                    end
                else
                    idx <= idx + 1;
        end
endmodule
