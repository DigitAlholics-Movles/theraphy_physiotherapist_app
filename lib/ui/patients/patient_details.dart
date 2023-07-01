import 'package:theraphy_physiotherapist_app/data/model/patient.dart';
import 'package:flutter/material.dart';
import 'package:theraphy_physiotherapist_app/ui/patients/patients_list.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key, required this.patient});
  final Patient patient;

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  int selectedIndex = 1;

  List<Widget> pages = const [
    PatientsList(),
    PatientsList(),
    PatientsList(),
    PatientsList(),
    PatientsList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -10,
        title: const Text(
          "Patient Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
         
             
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: 330,
                  height: 250,
                  child: Image.network(
                    widget.patient.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            

          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(
                    minWidth:
                        330, // Establece el ancho máximo deseado para el cuadro
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "${widget.patient.firstName} ${widget.patient.lastName}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(
                    minWidth:
                        330, // Establece el ancho máximo deseado para el cuadro
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Age',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.patient.age.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(
                    minWidth:
                        330, // Establece el ancho máximo deseado para el cuadro
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Appointments Quantity',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.patient.appointmentQuantity.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(
                    minWidth:
                        330, // Establece el ancho máximo deseado para el cuadro
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.patient.email,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    /*
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAppointments(
            
                    ),
                  ),
                );*/
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Medical appointments',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          // Aquí puedes agregar más contenido si es necesario
        ],
      ),
    );
  }
}
