import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:theraphy_physiotherapist_app/ui/treatments/TreatmentSsessions.dart';

class NewTreatment extends StatefulWidget {
  const NewTreatment({Key? key}) : super(key: key);

  @override
  State<NewTreatment> createState() => _NewTreatmentState();
}

class _NewTreatmentState extends State<NewTreatment> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _sessionsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final int maxDescriptionLength = 500;
  final ScrollController _descriptionScrollController = ScrollController();
  PickedFile? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    _sessionsController.dispose();
    _descriptionController.dispose();
    _descriptionScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(updateDescriptionCount);
  }

  void updateDescriptionCount() {
    setState(() {});
    if (_descriptionController.selection.extentOffset >= maxDescriptionLength) {
      _descriptionScrollController.jumpTo(_descriptionScrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildSelectedImage() {
      if (_selectedImage != null) {
        final file = File(_selectedImage!.path);
        return Image.file(file);
      } else {
        return Text('No image selected');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Treatment'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 1.0, 16.0, 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Center(
                child: Container(
                  width: 308,
                  height: 175,
                  child: Stack(
                    children: [
                      _selectedImage != null
                          ? Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(_selectedImage!.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                          : Container(),
                      ElevatedButton(
                        onPressed: () async {
                          final imagePicker = ImagePicker();
                          final image = await imagePicker.getImage(source: ImageSource.gallery);
                          setState(() {
                            _selectedImage = image;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(309, 222),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                        child: _selectedImage != null
                            ? Container()
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.image,
                              size: 100,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              'Select Image',
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left, // Align the text to the left
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.5, 8.0, 0),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left, // Align the text to the left
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 507, // Ancho personalizado
                height: 120, // Alto personalizado
                child: buildDescriptionField(),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Sessions Quantity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left, // Align the text to the left
              ),
              const SizedBox(height: 3),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.5, 8.0, 0),
                  child: TextField(
                    controller: _sessionsController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final String title = _titleController.text;
                      final int sessionsQuantity = int.parse(_sessionsController.text);
                      final String description = _descriptionController.text;

                      final newTreatment = Treatment(
                        title: title,
                        sessionsQuantity: sessionsQuantity,
                        imageLink: _selectedImage != null ? File(_selectedImage!.path).path : '',
                        description: description,
                      );

                      Navigator.pop(context, newTreatment);
                    },
                    child: const Text('Add Treatment'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Navegar hacia atrás sin pasar datos
                    },
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDescriptionField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 8.0, 0),
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              maxLines: 4,
              scrollController: _descriptionScrollController,
              keyboardType: TextInputType.multiline,
            ),
          ),
          Positioned(
            bottom: 8.0,
            right: 12.0,
            child: Text(
              '${_descriptionController.text.length}/$maxDescriptionLength',
              style: TextStyle(
                color: _descriptionController.text.length > maxDescriptionLength ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
