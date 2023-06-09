import requests


### AVISOS DE COPIA DE SEGURIDAD SQL ###
def checkoutCopia(fecha):
    chat_id = "-886607732"
    token = "5847938384:AAFR2zzAR7PtIb2DDido4INL3W3lkV4RDLs"
    mensaje = f"Se realizo una copia de seguridad correctamente. \nEl archivo sql esta en el NAS! 😁👍🏻\nFecha y Hora: {fecha}"
    url = f"https://api.telegram.org/bot{token}/sendmessage"

    params = {
        "chat_id": chat_id,
        "text": mensaje
    }

    response = requests.post(url, data=params)
    #print(response.json())
    
def failCopia():
    chat_id = "-886607732"
    token = "5847938384:AAFR2zzAR7PtIb2DDido4INL3W3lkV4RDLs"
    mensaje = "Se realizo una copia de seguridad incorrectamente! 😢"
    url = f"https://api.telegram.org/bot{token}/sendmessage"

    params = {
        "chat_id": chat_id,
        "text": mensaje
    }

    response = requests.post(url, data=params)
    #print(response.json())

### AVISOS DE COPIA DE SEGURIDAD TAR.GZ ###
def successTar(fecha):
    chat_id = "-886607732"
    token = "5847938384:AAFR2zzAR7PtIb2DDido4INL3W3lkV4RDLs"
    mensaje = f"Se comprimio la copia de seguridad, ahora usamos menos espacio en el NAS! 😱😱😱😍\nFecha y Hora: {fecha}"
    url = f"https://api.telegram.org/bot{token}/sendmessage"

    params = {
        "chat_id": chat_id,
        "text": mensaje
    }

    response = requests.post(url, data=params)
    #print(response.
    
def failTar():
    chat_id = "-886607732"
    token = "5847938384:AAFR2zzAR7PtIb2DDido4INL3W3lkV4RDLs"
    mensaje = "No se pudo comprimir la copia de seguridad en caliente! 😢"
    url = f"https://api.telegram.org/bot{token}/sendmessage"

    params = {
        "chat_id": chat_id,
        "text": mensaje
    }

    response = requests.post(url, data=params)
    #print(response.json())
    
### AVISOS DE CORREO ELECTRONICO ###
def waitCorreo():
    chat_id = "-886607732"
    token = "5847938384:AAFR2zzAR7PtIb2DDido4INL3W3lkV4RDLs"
    mensaje = "En un momento recibiras el archivo .tar.gz a tu correo electronico! 📬"
    url = f"https://api.telegram.org/bot{token}/sendmessage"

    params = {
        "chat_id": chat_id,
        "text": mensaje
    }

    response = requests.post(url, data=params)
    #print(response.json())

def sendmail():
    chat_id = "-886607732"
    token = "5847938384:AAFR2zzAR7PtIb2DDido4INL3W3lkV4RDLs"
    mensaje = f"Se ha enviado un correo con el archivo de la copia de seguridad a tu cuenta! Verificalo ahora mismo ✅"
    url = f"https://api.telegram.org/bot{token}/sendmessage"

    params = {
        "chat_id": chat_id,
        "text": mensaje
    }
    response = requests.post(url, data=params)
    #print(response.json())

def fallomail():
    chat_id = "-886607732"
    token = "5847938384:AAFR2zzAR7PtIb2DDido4INL3W3lkV4RDLs"
    mensaje = f"No he podido enviarte un correo electronico! ⚠️"
    url = f"https://api.telegram.org/bot{token}/sendmessage"

    params = {
        "chat_id": chat_id,
        "text": mensaje
    }
    response = requests.post(url, data=params)
    #print(response.json())
    
### AVISOS DE PROXIMAMENTE ###
def wait():
    chat_id = "-886607732"
    token = "5847938384:AAFR2zzAR7PtIb2DDido4INL3W3lkV4RDLs"
    mensaje = f"Tu proxima copia de seguridad en caliente es en una hora! 📌"
    url = f"https://api.telegram.org/bot{token}/sendmessage"

    params = {
        "chat_id": chat_id,
        "text": mensaje
    }
    response = requests.post(url, data=params)
    #print(response.json())
