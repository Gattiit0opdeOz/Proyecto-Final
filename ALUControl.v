`timescale 1ns/1ns

// 1. Crear Módulo - Definir I/O "atributos"
module ALUControl(
    input [1:0] ALUOp,
    input [5:0] Funct,
    output reg [3:0] ALUControl
);

// 2. Elementos internos (wires y reg)
// No se requieren elementos internos adicionales

// 3. Cuerpo
    // Bloque always
    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0010; // LW/SW -> ADD
            2'b01: ALUControl = 4'b0110; // BEQ -> SUB
            2'b10: begin
                case (Funct)
                    6'b100000: ALUControl = 4'b0010; // ADD
                    6'b100010: ALUControl = 4'b0110; // SUB
                    6'b100100: ALUControl = 4'b0000; // AND
                    6'b100101: ALUControl = 4'b0001; // OR
                    6'b101010: ALUControl = 4'b0111; // SLT
                    default:   ALUControl = 4'b0000; // Default -> AND
                endcase
            end
            default: ALUControl = 4'b0000; // Default -> AND
        endcase
    end
endmodule