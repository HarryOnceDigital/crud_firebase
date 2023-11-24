import 'package:crud_firebase/services/firebase_services.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud Firestore'),
      ),
      body: FutureBuilder(
        // Utilizando FutureBuilder para manejar la carga asíncrona de datos
        future: getPeople(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            // Construyendo una lista de elementos usando ListView.builder
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  // Widget Dismissible para permitir el deslizamiento para eliminar
                  onDismissed: (direction) async {
                    await deletePeople(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "¿Está seguro de eliminar a ${snapshot.data?[index]['name']}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                return Navigator.pop(context, false);
                              },
                              child: const Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                return Navigator.pop(context, true);
                              },
                              child: const Text(
                                "Sí, eliminar",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 5, 35, 6),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  child: ListTile(
                    // Elemento de lista que muestra el nombre y permite la edición
                    title: Text(snapshot.data?[index]['name']),
                    onTap: (() async {
                      // Navegando a la pantalla de edición con argumentos
                      await Navigator.pushNamed(context, '/edit', arguments: {
                        "name": snapshot.data?[index]['name'],
                        "uid": snapshot.data?[index]['uid'],
                      });
                      setState(() {});
                    }),
                  ),
                );
              },
            );
          } else {
            // Widget de indicador de carga si los datos aún no están disponibles
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      // Botón flotante para agregar nuevos registros
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navegando a la pantalla de inserción y actualizando la interfaz después
          await Navigator.pushNamed(context, '/insert');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
