`timescale 1ns/1ns

// 1. Crear Módulo - Definir I/O "atributos"
module PC(
    input clk,
    input reset,
    input [31:0] PC_in,
    output reg [31:0] PC_out
);

// 2. Elementos internos (wires y reg)
// No se requieren elementos internos adicionales

// 3. Cuerpo
    // Bloque always
    always @(posedge clk or posedge reset) begin
        if (reset)
            PC_out <= 32'b0; // Reinicia el contador a 0
        else
            PC_out <= PC_in; // Actualiza el PC con la entrada
    end
endmodule