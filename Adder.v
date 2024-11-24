`timescale 1ns/1ns

// 1. Crear Módulo - Definir I/O "atributos"
module Adder(
    input [31:0] A,
    input [31:0] B,
    output [31:0] Sum
);

// 2. Elementos internos (wires y reg)
// No se requieren elementos internos adicionales

// 3. Cuerpo
    // Asignaciones
    assign Sum = A + B; // Suma
endmodule
