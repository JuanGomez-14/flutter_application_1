import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controllers/password_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generador de Contraseñas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PasswordGenerator(controller: PasswordController()),
    );
  }
}

class PasswordGenerator extends StatefulWidget {
  final PasswordController controller;

  const PasswordGenerator({Key? key, required this.controller})
      : super(key: key);

  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  late PasswordController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  void copiarContrasena(String contrasena) {
    Clipboard.setData(ClipboardData(text: contrasena));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contraseña copiada al portapapeles')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generador de Contraseñas'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Longitud de la contraseña: ${_controller.longitudContrasena}',
              textAlign: TextAlign.center,
            ),
            Slider(
              value: _controller.longitudContrasena.toDouble(),
              min: 4,
              max: 15,
              divisions: 11,
              onChanged: (value) {
                setState(() {
                  _controller.longitudContrasena = value.toInt();
                });
              },
            ),
            RadioListTile(
              title: Text('Todas las opciones'),
              value: false,
              groupValue: _controller.facilDeDecir,
              onChanged: (value) {
                setState(() {
                  _controller.facilDeDecir = value ?? false;
                });
              },
            ),
            RadioListTile(
              title: Text('Fácil de decir'),
              value: true,
              groupValue: _controller.facilDeDecir,
              onChanged: (value) {
                setState(() {
                  _controller.facilDeDecir = value ?? false;
                  if (_controller.facilDeDecir) {
                    _controller.incluirNumeros = false;
                    _controller.incluirSimbolos = false;
                  } else {
                    _controller.incluirNumeros = true;
                    _controller.incluirSimbolos = true;
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('Incluir minúsculas'),
              value: _controller.incluirMinusculas,
              onChanged: (value) {
                setState(() {
                  _controller.incluirMinusculas = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Incluir mayúsculas'),
              value: _controller.incluirMayusculas,
              onChanged: (value) {
                setState(() {
                  _controller.incluirMayusculas = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Incluir números'),
              value: _controller.incluirNumeros,
              onChanged: !_controller.facilDeDecir
                  ? (value) {
                      setState(() {
                        _controller.incluirNumeros = value ?? false;
                      });
                    }
                  : null,
            ),
            CheckboxListTile(
              title: Text('Incluir símbolos'),
              value: _controller.incluirSimbolos,
              onChanged: !_controller.facilDeDecir
                  ? (value) {
                      setState(() {
                        _controller.incluirSimbolos = value ?? false;
                      });
                    }
                  : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.hayAlMenosUnCheckboxSeleccionado()) {
                  String contrasena = _controller.generarContrasena();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Contraseña generada'),
                        content: Row(
                          children: [
                            Expanded(
                              child: Text(contrasena),
                            ),
                            IconButton(
                              icon: Icon(Icons.content_copy),
                              onPressed: () {
                                copiarContrasena(contrasena);
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Debes seleccionar al menos una opción.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Generar Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
