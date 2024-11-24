`timescale 1ns/1ns

module tb_datapath();

    // Señales para el datapath
    reg clk, reset;
    wire [31:0] PC_out, Instruction, ALUResult, WriteData, MemData;

    // Instanciar el datapath principal
    MainDatapath uut (
        .clk(clk),
        .reset(reset)
    );

    // Generar reloj
    always #5 clk = ~clk; // Periodo de 10ns

    // Secuencia de prueba
    initial begin
        // Inicialización
        clk = 0; 
        reset = 1;

        // Liberar reset después de 20ns
        #20 reset = 0;

        // Simulación corre por 200ns
        #200 $stop;
    end

    // Monitorear señales clave
    initial begin
        $monitor("Time: %0t | PC: %h | Instruction: %h | ALUResult: %h | WriteData: %h | MemData: %h",
                 $time, PC_out, Instruction, ALUResult, WriteData, MemData);
    end

endmodule