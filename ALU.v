`timescale 1ns/1ns

// 1. Crear Módulo - Definir I/O "atributos"
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUControl,
    output reg [31:0] Result,
    output Zero
);

// 2. Elementos internos (wires y reg)
// No se requieren elementos internos adicionales

// 3. Cuerpo
    // Asignaciones
    assign Zero = (Result == 32'b0);

    // Bloque always
    always @(*) begin
        case (ALUControl)
            4'b0010: Result = A + B;  // ADD
            4'b0110: Result = A - B;  // SUB
            4'b0000: Result = A & B;  // AND
            4'b0001: Result = A | B;  // OR
            4'b0111: Result = (A < B) ? 1 : 0; // SLT
            default: Result = 32'b0;  // Default
        endcase
    end
endmodule