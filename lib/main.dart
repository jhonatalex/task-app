import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:taskfrontend/view/dashboardScreen.dart';
import 'package:taskfrontend/view/loginScreen.dart';
import 'package:taskfrontend/view/registerScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task App',
      initialRoute: '/login',
      getPages: [GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/register', page: () => RegisterScreen()),
          GetPage(name: '/dashboard', page: () => Dashboardscreen())
      
      
      ],
    );
  }
}
