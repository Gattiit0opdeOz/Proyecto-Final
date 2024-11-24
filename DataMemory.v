module DataMemory (
    input clk,                // Señal de reloj
    input MemWrite,           // Señal de escritura en memoria
    input MemRead,            // Señal de lectura de memoria
    input [31:0] Address,     // Dirección de memoria
    input [31:0] WriteData,   // Datos a escribir
    output reg [31:0] ReadData // Datos leídos
);
    // Memoria de datos: 256 palabras de 32 bits
    reg [31:0] memory [0:255];

    // Inicialización de la memoria
    initial begin
        // Valores iniciales para pruebas
        memory[0] = 32'd5;    // Dirección 0: Valor 5
        memory[1] = 32'd10;   // Dirección 4: Valor 10
        memory[2] = 32'd0;    // Dirección 8: Espacio para almacenar el resultado
        // Puedes agregar más valores si es necesario
    end

    // Escritura en memoria (en flanco positivo del reloj)
    always @(posedge clk) begin
        if (MemWrite) begin
            memory[Address[7:2]] <= WriteData; // Escribir datos en la dirección especificada
        end
    end

    // Lectura de memoria (combinacional)
    always @(*) begin
        if (MemRead) begin
            ReadData = memory[Address[7:2]]; // Leer datos de la dirección especificada
        end else begin
            ReadData = 32'b0; // Si no hay lectura, salida en 0
        end
    end
endmodule