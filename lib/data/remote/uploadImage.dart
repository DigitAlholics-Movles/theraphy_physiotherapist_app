import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<String?> uploadImage(File image) async {
  try {
    // Obtener la referencia al almacenamiento de Firebase
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = storage.ref().child('images/$fileName');

    print('Error al cargar la imagen: $storageReference');
    
    // Subir la imagen al almacenamiento de Firebase
    TaskSnapshot uploadTask = await storageReference.putFile(image);
    String imageUrl = await uploadTask.ref.getDownloadURL();

    // Retornar la URL de la imagen
    return imageUrl;
  } catch (e) {
    // Si ocurre un error, mostrar el mensaje de error y retornar null
    print('Error al cargar la imagen: $e');
    return null;
  }
}
