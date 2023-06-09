import os
import datetime
import sys

import getCuentas
import telegram
import tar
import mail

def respaldo():
    #ruta para guardar la copia de seguridad
    ruta_guardado="/mnt/backup/archivos/"
    #obtener fecha actual
    getFecha = datetime.datetime.now()
    fecha= getFecha.strftime("%Y-%m-%d_%H-%M-%S")
    #crear nombre para el archivo
    fileName = "Respaldo_uv_"+fecha
    
    #llamar a las credenciales
    credenciales = getCuentas.decrypt()
    usuario = credenciales[0]
    clave = credenciales[1]
    
    #escritura del mysqldump
    script = os.system("sudo mysqldump -u "+usuario+" -p"+clave+" --single-transaction --databases uv > "+ruta_guardado+fileName+".sql") #Cambiar por mariadb backup
    
    #comprobar que se ejecute el respaldo
    if script == 0:
        telegram.checkoutCopia(fecha)
        #ahora vamos a comprimir el archivo
        compress = tar.comprimir(fileName)
        if compress == 0:
            telegram.successTar(fecha)
            os.system("sudo rm -r /mnt/backup/archivos/*")
            #telegram.waitCorreo()
            estado = mail.correo(fecha,fileName+".tar.gz",ruta_guardado)
            if estado == 0:
                telegram.sendmail()
            else:
                telegram.fallomail()
        else:
            telegram.failTar()
    else:
        telegram.failCopia()
        sys.exit()
        
respaldo()