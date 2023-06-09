#include <iostream>
#include <openssl/sha.h>
#include <cstring>
#include <sstream>
#include <iomanip>

using namespace std;

string sha256(const string& password) {
    unsigned char hash[SHA256_DIGEST_LENGTH];
    SHA256_CTX sha256;
    SHA256_Init(&sha256);
    SHA256_Update(&sha256, password.c_str(), password.length());
    SHA256_Final(hash, &sha256);

    stringstream ss;
    for (int i = 0; i < SHA256_DIGEST_LENGTH; ++i) {
        ss << hex << setw(2) << setfill('0') << static_cast<int>(hash[i]);
    }

    return ss.str();
}

int main() {
    system("clear");
    string password;
    cout << "Ingrese la contraseña a encriptar: ";
    cin >> password;

    string hashedPassword = sha256(password);
    cout << "Contraseña encriptada: " << hashedPassword << endl;

    return 0;
}
