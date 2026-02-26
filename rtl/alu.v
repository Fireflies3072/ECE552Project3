module alu (
    input  wire[31:0] i_a,
    input  wire[31:0] i_b,
    input  wire[3:0]  i_alu_op,
    output reg[31:0]  o_result,
    output wire       o_zero
);
    // ALU arithmetic operations
    localparam ALU_ADD = 4'd0;
    localparam ALU_SUB = 4'd1;
    localparam ALU_SLL = 4'd2;
    localparam ALU_SLT = 4'd3;
    localparam ALU_SLTU = 4'd4;
    localparam ALU_XOR = 4'd5;
    localparam ALU_SRL = 4'd6;
    localparam ALU_SRA = 4'd7;
    localparam ALU_OR = 4'd8;
    localparam ALU_AND = 4'd9;

    always @(*) begin
        case (i_alu_op)
            ALU_ADD:  o_result = i_a + i_b;
            ALU_SUB:  o_result = i_a - i_b;
            ALU_SLL:  o_result = i_a << i_b[4:0];
            ALU_SLT:  o_result = ($signed(i_a) < $signed(i_b)) ? 32'd1 : 32'd0;
            ALU_SLTU: o_result = (i_a < i_b) ? 32'd1 : 32'd0;
            ALU_XOR:  o_result = i_a ^ i_b;
            ALU_SRL:  o_result = i_a >> i_b[4:0];
            ALU_SRA:  o_result = $signed(i_a) >>> i_b[4:0];
            ALU_OR:   o_result = i_a | i_b;
            ALU_AND:  o_result = i_a & i_b;
            default:  o_result = 32'd0;
        endcase
    end
    
    // Zero flag
    assign o_zero = (o_result == 32'd0);

endmodule
