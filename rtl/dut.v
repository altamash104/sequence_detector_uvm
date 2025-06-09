module sequence_detector(
    input logic clk,
    input logic reset,
    input logic data_in,
    output logic out
);
    //state encoding
  typedef enum logic [2:0] {IDLE, S1, S11, S110, S1101} state_t;

    state_t state, next;

    always_ff @(posedge clk or posedge reset) begin
        if(reset) state <= IDLE;
        else state <= next;
    end

    always_comb begin
        next = IDLE;
        out = 0;
        case(state)
            IDLE: begin
                next = (data_in == 1) ? S1: IDLE;
            end

            S1: begin
                next = (data_in == 1) ? S11: IDLE;
            end

            S11: begin
                next = (data_in == 1) ? S11 : S110;
            end

            S110: begin
              next = (data_in == 1) ? S1101 : IDLE;
            end
          
           S1101: begin
             out = 1'b1;
             next = (data_in == 1) ? S11 : IDLE;
           end
            default: begin
                next = IDLE;
            end
        endcase
    end
endmodule
