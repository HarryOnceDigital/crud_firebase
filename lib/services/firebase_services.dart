import 'package:cloud_firestore/cloud_firestore.dart';

//iniciamos instancia de la bd
FirebaseFirestore database = FirebaseFirestore.instance;

//obtiene los registros de la colección
Future<List> getPeople() async {
  List people = [];

  CollectionReference collectionReferencePeople = database.collection('people');
  QuerySnapshot queryPeople = await collectionReferencePeople.get();

  for (var element in queryPeople.docs) {
    final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    final person = {
      "name": data['name'],
      "uid": element.id,
    };
    people.add(person);
  }

  await Future.delayed(const Duration(seconds: 2));

  return people;
}

//insertando registro
Future<void> addPeople(String name) async {
  await database.collection("people").add({"name": name});
}

//actualizar registro
Future<void> updatePeople(String uid, String newName) async {
  await database.collection("people").doc(uid).update({"name": newName});
}

//borrar registro
Future<void> deletePeople(String uid) async {
  await database.collection("people").doc(uid).delete();
}
