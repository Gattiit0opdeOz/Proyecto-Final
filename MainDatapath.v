`timescale 1ns/1ns

// 1. Crear Módulo - Definir I/O "atributos"
module MainDatapath(
    input clk,
    input reset
);

// 2. Elementos internos (wires y reg)
wire [31:0] PC_in, PC_out, Instruction, ReadData1, ReadData2;
wire [31:0] SignImm, ALUResult, MemData, PCBranch, PCPlus4;
wire [31:0] ALUSrcB, WriteData, ShiftedImm;
wire [4:0] WriteReg;
wire [3:0] ALUControl;
wire [1:0] ALUOp;
wire Zero, Branch, MemRead, MemWrite, MemtoReg, ALUSrc, RegDst, RegWrite;

// 3. Cuerpo
    // Instancias de módulos
    PC pc(.clk(clk), .reset(reset), .PC_in(PC_in), .PC_out(PC_out));
    InstructionMemory im(.Address(PC_out), .Instruction(Instruction));
    ControlUnit cu(.Opcode(Instruction[31:26]), .RegDst(RegDst), .ALUSrc(ALUSrc),
                   .MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead),
                   .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp));
    RegisterFile rf(.clk(clk), .RegWrite(RegWrite), .ReadReg1(Instruction[25:21]),
                    .ReadReg2(Instruction[20:16]), .WriteReg(WriteReg),
                    .WriteData(WriteData), .ReadData1(ReadData1), .ReadData2(ReadData2));
    SignExtend se(.Instr(Instruction[15:0]), .SignImm(SignImm));
    MUX2to1 mux_reg(.A(Instruction[20:16]), .B(Instruction[15:11]),
                    .Sel(RegDst), .Out(WriteReg));
    ALUControl aluc(.ALUOp(ALUOp), .Funct(Instruction[5:0]), .ALUControl(ALUControl));
    MUX2to1 mux_alu(.A(ReadData2), .B(SignImm), .Sel(ALUSrc), .Out(ALUSrcB));
    ALU alu(.A(ReadData1), .B(ALUSrcB), .ALUControl(ALUControl),
            .Result(ALUResult), .Zero(Zero));
    DataMemory dm(.clk(clk), .MemWrite(MemWrite), .MemRead(MemRead),
                  .Address(ALUResult), .WriteData(ReadData2), .ReadData(MemData));
    MUX2to1 mux_mem(.A(ALUResult), .B(MemData), .Sel(MemtoReg), .Out(WriteData));
    ShiftLeft2 sl2(.In(SignImm), .Out(ShiftedImm));
    Adder adder_pc(.A(PC_out), .B(32'd4), .Sum(PCPlus4));
    Adder adder_branch(.A(PCPlus4), .B(ShiftedImm), .Sum(PCBranch));
    MUX2to1 mux_pc(.A(PCPlus4), .B(PCBranch), .Sel(Branch & Zero), .Out(PC_in));
endmodule
