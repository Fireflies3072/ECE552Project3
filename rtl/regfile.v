module regfile (
    input  wire       i_clk,
    input  wire[4:0]  i_rs1_addr,
    input  wire[4:0]  i_rs2_addr,
    input  wire[4:0]  i_rd_addr,
    input  wire[31:0] i_rd_data,
    input  wire       i_rd_wen,
    output wire[31:0] o_rs1_data,
    output wire[31:0] o_rs2_data
);
    // Define 32 registers of 32 bits each
    reg[31:0] regs[0:31];

    // Initialize registers to 0
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            regs[i] = 32'b0;
        end
    end

    // Read registers by directly mapping values to outputs
    assign o_rs1_data = (i_rs1_addr == 5'b0) ? 32'b0 : regs[i_rs1_addr];
    assign o_rs2_data = (i_rs2_addr == 5'b0) ? 32'b0 : regs[i_rs2_addr];

    // Write data to registers synchronously
    always @(posedge i_clk) begin
        // Write only if write enable is true and target register is not 0
        if (i_rd_wen && i_rd_addr != 5'b0) begin
            regs[i_rd_addr] <= i_rd_data;
        end
    end

endmodule
