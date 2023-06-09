import os
#comanzamos con la estructura del correo

def correo(fecha,copia,ruta):
    asunto = "Se realizo una copia de seguridad!"
    cuerpo = f"Este es un mensaje automático para informarle que la copia de seguridad de la base de datos ha sido creada correctamente. Si tiene alguna otra consulta o necesita ayuda adicional, no dude en contactarnos. Estamos siempre a su disposición para ayudarle con cualquier problema que pueda surgir en su proyecton\n\n¡Información de la copia de seguridad!\nFecha de la creación de la copia de seguridad: {fecha}. ruta:{ruta}"
    destinatario = "l.mario.cs31@gmail.com"
    
    #sintaxis echo "Este es el cuerpo del correo" | mailx -s "Asunto del correo" l.mario.cs31@gmail.com
    instruccion = f"echo '{cuerpo}' | mailx -s '{asunto}' -A /mnt/backup/hot_backup/{copia} {destinatario}"
    script = os.system(instruccion)
    if script == 0:
        return 0
    else:
        return 1