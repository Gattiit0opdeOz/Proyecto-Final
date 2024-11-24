`timescale 1ns/1ns

// 1. Crear Módulo - Definir I/O "atributos"
module ShiftLeft2(
    input [31:0] In,
    output [31:0] Out
);

// 2. Elementos internos (wires y reg)
// No se requieren elementos internos adicionales

// 3. Cuerpo
    // Asignaciones
    assign Out = In << 2; // Desplazamiento a la izquierda por 2
endmodule
