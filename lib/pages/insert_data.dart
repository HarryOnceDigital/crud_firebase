import 'package:crud_firebase/services/firebase_services.dart';
import 'package:flutter/material.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  // Controlador para el campo de entrada de nombre
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // Campo de entrada para el nombre
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el nombre',
              ),
            ),

            // Botón para guardar el nuevo registro
            ElevatedButton(
              onPressed: () async {
                // Llamando a la función para agregar una nueva persona a Firebase
                await addPeople(nameController.text).then((_) {
                  // Volviendo a la pantalla anterior después de guardar
                  Navigator.pop(context);
                });
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
