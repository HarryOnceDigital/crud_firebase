import 'package:flutter/material.dart';

// Importando Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Asegúrate de tener este archivo con la configuración de Firebase
import 'package:crud_firebase/pages/edit_data.dart';
import 'package:crud_firebase/pages/home_page.dart';
import 'package:crud_firebase/pages/insert_data.dart';

void main() async {
  // Asegurándose de que los enlaces de Widgets estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializando Firebase con las opciones predeterminadas para la plataforma actual
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ejecutando la aplicación Flutter
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Configuración básica de la aplicación
      title: 'Crud Firestore',
      initialRoute: '/', // Ruta inicial de la aplicación
      debugShowCheckedModeBanner: false, // Ocultar banner de modo de depuración

      // Configuración del tema de la aplicación
      theme: ThemeData(
        primaryColor: Colors.blue, // Color primario de la aplicación
      ),

      // Definición de rutas de la aplicación
      routes: {
        '/': (context) => const Home(), // Página de inicio
        '/insert': (context) =>
            const InsertData(), // Página de inserción de datos
        '/edit': (context) => const EditData(), // Página de edición de datos
      },
    );
  }
}
