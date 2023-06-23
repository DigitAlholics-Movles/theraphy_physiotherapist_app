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
        title: Text(treatmentName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                treatmentImage,
                height: 200, // Adjust the image height according to your needs
                width: 400, // Adjust the image width according to your needs
                fit: BoxFit.contain, // Ensure the image fits within the specified dimensions
              ),
            ),
            const SizedBox(height: 25),
            Row(
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
            const SizedBox(height: 20),
            Text(
              treatmentDescription,
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}


