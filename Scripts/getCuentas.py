
import sys

#funcion para desencriptar las claves
def desencriptar(texto, shift):
    decryptedText = ""
    for c in texto:
        if c.isalpha():
            base = ord('A') if c.isupper() else ord('a')
            decryptedChar = chr((ord(c) - base - shift + 26) % 26 + base)
            decryptedText += decryptedChar
        else:
            decryptedText += c  # Conservar caracteres que no sean letras
    return decryptedText

def decrypt():
    #abrir el archivo encriptado
    archivo = open("credenciales.txt")
    with open("credenciales.txt", "r") as archivo:
        texto = archivo.read()
        renglones = texto.splitlines()
        #print(texto) (estamos leyenco el archivo)
        if len(texto) >= 2:
            usuario = renglones[0].strip() #almacena el renglongo y borra espacios en blanco
            clave = renglones[1].strip()
            lista = [usuario,clave]
            #print(lista)
            #desencriptar la cuenta
            getUser = desencriptar(lista[0],3)
            getPass = desencriptar(lista[1],3)
            credenciales = [getUser,getPass]
            return credenciales
        else:
            print("El archivo no tiene credenciales")
            sys.exit()
        