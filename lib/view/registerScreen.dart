import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskfrontend/controller/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: const Color.fromARGB(255, 112, 117, 122),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              const Center(
                child: Icon(
                  Icons.task_alt,
                  size: 100,
                  color: Color.fromARGB(255, 65, 66, 67),
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  authController.register(emailController.text, passwordController.text);
                },
                child: const Text('Registrarse'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
