`timescale 1ns/1ns

// 1. Crear Módulo - Definir I/O "atributos"
module SignExtend(
    input [15:0] Instr,
    output [31:0] SignImm
);

// 2. Elementos internos (wires y reg)
// No se requieren elementos internos adicionales

// 3. Cuerpo
    // Asignaciones
    assign SignImm = {{16{Instr[15]}}, Instr}; // Extensión de signo
endmodule