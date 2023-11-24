import 'package:crud_firebase/services/firebase_services.dart';
import 'package:flutter/material.dart';

class EditData extends StatefulWidget {
  const EditData({Key? key}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  // Controlador para el campo de entrada de nombre
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    // Obteniendo los argumentos pasados a esta pantalla
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // Estableciendo el valor del controlador con el nombre actual
    nameController.text = arguments['name'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // Campo de entrada para el nuevo nombre
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese nuevo nombre',
              ),
            ),

            // Botón para actualizar los datos
            ElevatedButton(
              onPressed: () async {
                // Llamando a la función para actualizar la información en Firebase
                await updatePeople(arguments["uid"], nameController.text)
                    .then((_) {
                  // Volviendo a la pantalla anterior después de la actualización
                  Navigator.pop(context);
                });
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
