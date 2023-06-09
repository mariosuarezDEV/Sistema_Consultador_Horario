//librerias necesarias
#include <iostream>
#include <fstream> //libreria para archivos
#include <stdlib.h>

using namespace std;

string desencriptar(string text, int shift);

int main(int argc, char const *argv[])
{
    //leermos el archivo encriptado (credenciales.txt)
    ifstream archivo;
    archivo.open("credenciales.txt", ios::in); 
    //verificamso que no hay errores
    if (archivo.fail())
    {
        cout<<"Error al leer el archivo encriptado!"<<endl;
        exit(1);
    }
    //obtenemos nuestras lineas encriptadas
    string credenciales[2];
    int i=0;
    while (!archivo.eof())
    {
        getline(archivo, credenciales[i]);
        // Eliminar el carácter de retorno de carro si está presente al final de la cadena
        if (!credenciales[i].empty() && credenciales[i].back() == '\r') {
            credenciales[i].pop_back();
        }
        i++;
    }
    //depuramos para ver que tengamos almacenados nuestros datos
    cout<<credenciales[0]<<endl;
    cout<<credenciales[1]<<endl;
    cout<<credenciales[0]<<" : "<<credenciales[1]<<endl;

    //desencriptamos con nuestras funcion
    int shift = 3;
    string original1,original2;
    original1 = desencriptar(credenciales[0],shift);
    original2 = desencriptar(credenciales[1], shift);
    //verificar que todo este almacenado correctamente
    cout<<original1<<endl;
    cout<<original2<<endl;
    cout<<original1<<" : "<<original2<<endl;
    
    return 0;
}

string desencriptar(string text, int shift){
    string decryptedText = "";
    for (char c : text) {
        if (isalpha(c)) {
            char base = isupper(c) ? 'A' : 'a';
            char decryptedChar = ((c - base - shift + 26) % 26) + base;
            decryptedText += decryptedChar;
        } else {
            decryptedText += c;  // Conservar caracteres que no sean letras
        }
    }
    return decryptedText;
}
