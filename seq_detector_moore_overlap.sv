// Code your design here
module seq_detector_moore_overlap (
    input  wire CLK, RESET, IN,
    output reg  Z
);
    typedef enum reg [2:0] {S0, S1, S2, S3, S4} state_t;
    state_t state, next_state;

    always @(posedge CLK) begin
        if (RESET) state <= S0;
        else       state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: next_state = IN ? S1 : S0;
            S1: next_state = IN ? S1 : S2;
            S2: next_state = IN ? S3 : S0;
            S3: next_state = IN ? S4 : S2;
            S4: next_state = IN ? S1 : S2; // overlap reuse
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        Z = (state == S4); // Moore output
    end
endmodule
