import 'package:flutter/material.dart';

class TreatmentInfo extends StatelessWidget {
  final String treatmentName;
  final String treatmentImage;
  final String treatmentDescription;

  const TreatmentInfo({Key? key, required this.treatmentName, required this.treatmentImage, required this.treatmentDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(treatmentName, style: const TextStyle(color: Colors.black)),backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: 330,
                  height: 250,
                  child: Image.network(
                    treatmentImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 25),
            const Padding(
              padding:  EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left, // Align the text to the left
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                treatmentDescription,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


