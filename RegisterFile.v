`timescale 1ns/1ns

// 1. Crear Módulo - Definir I/O "atributos"
module RegisterFile(
    input clk,
    input RegWrite,
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);

// 2. Elementos internos (wires y reg)
reg [31:0] registers [0:31]; // Banco de registros de 32 registros de 32 bits

// 3. Cuerpo
    // Asignaciones
    assign ReadData1 = registers[ReadReg1];
    assign ReadData2 = registers[ReadReg2];

    // Bloque always
    always @(posedge clk) begin
        if (RegWrite) begin
            registers[WriteReg] <= WriteData; // Escritura en el registro
        end
    end
endmodule