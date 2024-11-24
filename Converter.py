import tkinter as tk
from tkinter import messagebox, filedialog

# Diccionario con los opcodes e información de las instrucciones
instrucciones = {
    "Addi": {"opcode": "001000", "tipo": "I"},
    "Add": {"opcode": "000000", "func": "100000", "tipo": "R"},
    "Slt": {"opcode": "000000", "func": "101010", "tipo": "R"},
    "Beq": {"opcode": "000100", "tipo": "I"},
    "Sw": {"opcode": "101011", "tipo": "I"},
    "J": {"opcode": "000010", "tipo": "J"},
    "Nop": {"opcode": "000000", "tipo": "R", "func": "000000"},
}

# Diccionario con los registros y sus valores binarios
registros = {
    "$zero": "00000",
    "$t0": "01000",
    "$t1": "01001",
    "$t2": "01010",
    "$t3": "01011",
    "$t4": "01100",
    "$t5": "01101",
}

def ensamblar(linea):
    """Convierte una línea de ensamblador a binario."""
    partes = linea.split()
    instruccion = partes[0]
    if instruccion == "Nop":
        return "00000000000000000000000000000000"
    
    info = instrucciones.get(instruccion)
    if not info:
        return f"Error: Instrucción desconocida '{instruccion}'"
    
    if info["tipo"] == "R":
        rd = registros.get(partes[1].strip(","), "00000")
        rs = registros.get(partes[2].strip(","), "00000")
        rt = registros.get(partes[3], "00000")
        return f"{info['opcode']}{rs}{rt}{rd}00000{info['func']}"
    elif info["tipo"] == "I":
        rt = registros.get(partes[1].strip(","), "00000")
        rs = registros.get(partes[2].strip(","), "00000")
        inmediato = format(int(partes[3]), "016b")
        return f"{info['opcode']}{rs}{rt}{inmediato}"
    elif info["tipo"] == "J":
        address = format(int(partes[1]), "026b")
        return f"{info['opcode']}{address}"

def convertir_a_binario():
    """Convierte el código ensamblador ingresado a binario."""
    codigo = entrada_texto.get("1.0", tk.END).strip()
    lineas = codigo.split("\n")
    resultado = []
    for linea in lineas:
        if linea.strip():  # Ignorar líneas vacías
            binario = ensamblar(linea.strip())
            resultado.append(binario)
    salida_texto.delete("1.0", tk.END)
    salida_texto.insert(tk.END, "\n".join(resultado))

def guardar_archivo():
    """Guarda el contenido binario en un archivo .mem."""
    contenido = salida_texto.get("1.0", tk.END).strip()
    if not contenido:
        messagebox.showerror("Error", "No hay contenido para guardar.")
        return
    archivo = filedialog.asksaveasfilename(defaultextension=".mem", filetypes=[("Archivos .mem", "*.mem")])
    if archivo:
        with open(archivo, "w") as f:
            f.write(contenido)
        messagebox.showinfo("Éxito", f"Archivo guardado como {archivo}")

# Crear la ventana principal
ventana = tk.Tk()
ventana.title("Conversor de Ensamblador a Binario")
ventana.geometry("800x600")

# Etiqueta y cuadro de texto para ingresar el código ensamblador
etiqueta_entrada = tk.Label(ventana, text="Código Ensamblador:", font=("Arial", 12))
etiqueta_entrada.pack(pady=5)

entrada_texto = tk.Text(ventana, height=15, width=80, font=("Courier", 10))
entrada_texto.pack(pady=5)

# Botón para convertir a binario
boton_convertir = tk.Button(ventana, text="Convertir a Binario", font=("Arial", 12), command=convertir_a_binario)
boton_convertir.pack(pady=10)

# Etiqueta y cuadro de texto para mostrar el código binario
etiqueta_salida = tk.Label(ventana, text="Código Binario:", font=("Arial", 12))
etiqueta_salida.pack(pady=5)

salida_texto = tk.Text(ventana, height=15, width=80, font=("Courier", 10))
salida_texto.pack(pady=5)

# Botón para guardar el archivo
boton_guardar = tk.Button(ventana, text="Guardar Archivo", font=("Arial", 12), command=guardar_archivo)
boton_guardar.pack(pady=10)

# Ejecutar la ventana principal
ventana.mainloop()