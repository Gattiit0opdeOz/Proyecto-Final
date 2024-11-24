`timescale 1ns/1ns

// 1. Crear Módulo - Definir I/O "atributos"
module InstructionMemory(
    input [31:0] Address,
    output [31:0] Instruction
);

// 2. Elementos internos (wires y reg)
reg [31:0] memory [0:255]; // Memoria de instrucciones de 256 palabras

// 3. Cuerpo
    // Bloque initial para cargar las instrucciones
    initial begin
        $readmemb("instructions.mem", memory); // Carga las instrucciones desde un archivo
    end

    // Asignaciones
    assign Instruction = memory[Address[9:2]]; // Usa las 8 bits más significativas como índice
endmodule