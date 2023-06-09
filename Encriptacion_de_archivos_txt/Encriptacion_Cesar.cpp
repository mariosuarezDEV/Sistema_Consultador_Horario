//librerias necesarias
#include <iostream>
#include <fstream> //libreria para archivos
#include <stdlib.h>

using namespace std;

string encriptar(string text, int shift);
void guardar_encriptado(string linea1, string linea2);

int main(int argc, char const *argv[])
{
    //vamos a encriptar las credenciales que tiene un archivo
    //para ello, el archivo ya debe estar creado, el primer renglon será para usuario y el segundo para contraseña.
    //una vez creado y llenado el archivo, podemos utilizar nuestras funciones para encriptar los datos el archivo

    //leer el archivo a encriptar
    ifstream archivo;
    archivo.open("encriptar.txt", ios::in);
    //verificar que no se presente un error
    if (archivo.fail())
    {
        cout<<"Error al leer el archivo a encriptar!"<<endl;
        exit(1); //si hay un error, cierra el programa y no permite que siga ejecutandose
    }
    //sino hay errores, pasamos a obtener el contenido
    string credenciales[2]; //en este arreglo guardaremos el usuario y contraseña
    int i=0; //esta variable nos servira para iterar y asignar una posicion en nuestro arreglo

    //creamos un ciclo para leer nuestro archivo
    while (!archivo.eof()) //hasta que llegue al fin de nuestro archivo
    {
        getline(archivo,credenciales[i]); //pasamos el contenido del renglon a nuestra variable credenciales en posicion i
        //ahora iteramos nuestra variables
        i++;
    }
    //vamos a depurar para saber si se obtuvo correctamente la informacion
    cout<<credenciales[0]<<endl;
    cout<<credenciales[1]<<endl;
    cout<<credenciales[0]<<" : "<<credenciales[1]<<endl;
    //ahora vamos a mandar a encriptar nuestro contenido
    int shift = 3; //valor de desplazamiento
    string encriptado1, encriptado2; //en estas variables se guardaran nuestras encriptaciones
    encriptado1 = encriptar(credenciales[0],shift);
    encriptado2 = encriptar(credenciales[1],shift);
    //ahora vamos a guardar nuestras encriptaciones en el archivo que tiene nuestra funcion correspondiente
    guardar_encriptado(encriptado1,encriptado2);
    //en nuestro explorador de archivo debemos tener nuestro archivo con credenciales encriptadas
    
    return 0;
}

string encriptar(string text, int shift){
    string encryptedText = "";
    for (char c : text) {
        if (isalpha(c)) {
            char base = isupper(c) ? 'A' : 'a';
            char encryptedChar = ((c - base + shift) % 26) + base;
            encryptedText += encryptedChar;
        } else {
            encryptedText += c;  // Conservar caracteres que no sean letras
        }
    }
    return encryptedText;
}

void guardar_encriptado(string linea1, string linea2){
    //vamos a crear un archivo
    ofstream archivo;
    archivo.open("credenciales.txt", ios::out); //creamos un archivo y se abre en modo escritura
    //verificar que se creo el archivo
    if (archivo.fail())
    {
        cout<<"Error al crear el archivo de encriptacion!"<<endl;
        exit(1);
    }
    //si el archivo se guardo correctamente, guardamos nuestras encriptaciones
    archivo << linea1;
    archivo << endl;
    archivo <<linea2;
    //una ver guardado, cerramos la escritura del archivo
    archivo.close();
}
