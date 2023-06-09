import os

def comprimir(nombreArchivo):
    #ruta para guardar el archivo
    ruta_guardado = "/mnt/backup/hot_backup/"
    #ubicacion original
    ruta_origen = "/mnt/backup/archivos/"
    file = ruta_guardado+nombreArchivo+".tar.gz"
    
    #escribir la consulta
    #sintaxis: tar -czvf archivo.tar.gz archivo_o_directorio
    script = os.system(f"sudo tar -czvf {file} {ruta_origen}")
    if script == 0:
        print("Archivo comprimido")
        return 0
    else:
        print("Error al comprimir el archivo")
        return 1