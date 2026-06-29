// Code your design here
module seq_detector_mealy_overlap (
    input  wire CLK, RESET, IN,
    output reg  Z
);
    typedef enum reg [1:0] {S0, S1, S2, S3} state_t;
    state_t state, next_state;

    always @(posedge CLK) begin
        if (RESET) state <= S0;
        else       state <= next_state;
    end

    always @(*) begin
        Z = 0;
        case (state)
            S0: next_state = IN ? S1 : S0;
            S1: next_state = IN ? S1 : S2;
            S2: next_state = IN ? S3 : S0;
            S3: begin
                if (IN) begin
                    Z = 1;          // detection
                    next_state = S1; // overlap reuse
                end else
                    next_state = S2;
            end
        endcase
    end
