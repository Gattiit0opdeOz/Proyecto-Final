`timescale 1ns/1ns

// 1. Crear Módulo - Definir I/O "atributos"
module MUX2to1(
    input [31:0] A,
    input [31:0] B,
    input Sel,
    output [31:0] Out
);

// 2. Elementos internos (wires y reg)
// No se requieren elementos internos adicionales

// 3. Cuerpo
    // Asignaciones
    assign Out = (Sel) ? B : A; // Selección de entrada
endmodule
