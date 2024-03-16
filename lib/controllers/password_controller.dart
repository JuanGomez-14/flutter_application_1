import 'dart:math';

class PasswordController {
  int longitudContrasena = 8;
  bool incluirMinusculas = true;
  bool incluirMayusculas = true;
  bool incluirNumeros = true;
  bool incluirSimbolos = true;
  bool facilDeDecir = false;

  String generarContrasena() {
    String caracteresMinusculas = 'abcdefghijklmnopqrstuvwxyz';
    String caracteresMayusculas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String numeros = '0123456789';
    String simbolos = '!@#\$%^&*()-_=+';

    String caracteres = '';
    if (incluirMinusculas) caracteres += caracteresMinusculas;
    if (incluirMayusculas) caracteres += caracteresMayusculas;
    if (incluirNumeros && !facilDeDecir) caracteres += numeros;
    if (incluirSimbolos && !facilDeDecir) caracteres += simbolos;

    String contrasena = '';
    Random random = Random();
    for (int i = 0; i < longitudContrasena; i++) {
      contrasena += caracteres[random.nextInt(caracteres.length)];
    }

    return contrasena;
  }

  bool hayAlMenosUnCheckboxSeleccionado() {
    return incluirMinusculas ||
        incluirMayusculas ||
        incluirNumeros ||
        incluirSimbolos;
  }
}
