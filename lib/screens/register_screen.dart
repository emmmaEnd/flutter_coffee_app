import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController conName = TextEditingController();
  final TextEditingController conEmail = TextEditingController();
  final TextEditingController conPwd = TextEditingController();

  File? _avatar;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _avatar = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrate!!!"),
        backgroundColor: cs.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // el avatar
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      _avatar != null ? FileImage(_avatar!) : null,
                  child: _avatar == null
                      ? const Icon(Icons.camera_alt, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 20),

              // para nombre
              TextFormField(
                controller: conName,
                decoration: const InputDecoration(
                  labelText: "Escribe tu nombre de usuario",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Requiere nombre de usuario" : null,
              ),
              const SizedBox(height: 15),

              // para emial
              TextFormField(
                controller: conEmail,
                decoration: const InputDecoration(
                  labelText: "Escribe tu correo",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Falta Correo";
                  }
                  final emailRegex =
                      RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return "Correo de composición no valida";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // contra
              TextFormField(
                controller: conPwd,
                decoration: const InputDecoration(
                  labelText: "Escribe contraseña",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) =>
                    value == null || value.isEmpty ? "Necesitas definir contraseña" : null,
              ),
              const SizedBox(height: 25),

              // boton de registro
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Fluttertoast.showToast(
                    msg: "Registro exitoso",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                    // limpiar formulario
                    conName.clear();
                    conEmail.clear();
                    conPwd.clear();
                    setState(() {
                      _avatar = null;
                    });
                    Navigator.pushReplacementNamed(context, "/home");

                  }
                },
                child: const Text("Registrar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
