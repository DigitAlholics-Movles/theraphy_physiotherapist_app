import 'package:flutter/material.dart';
import 'package:theraphy_physiotherapist_app/data/model/patient.dart';
import 'package:theraphy_physiotherapist_app/ui/patients/patient_details.dart';

class PatientsList extends StatefulWidget {
  const PatientsList({super.key});

  @override
  State<PatientsList> createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  List<Patient> patients = [];

  List<Patient> filteredPatients = [];
  TextEditingController searchController = TextEditingController(); // Controlador del campo de búsqueda
  
  @override
  void initState() {
    super.initState();
    patients = [
      Patient(
        id: "1",
        userId: "1",
        firstName: "John",
        lastName: "Doe",
        age: "30",
        birthdayDate: "1992-05-15",
        email: "john.doe@example.com",
        appointmentQuantity: "2",
        photoUrl: "https://st4.depositphotos.com/1017228/20766/i/600/depositphotos_207663178-stock-photo-image-of-happy-young-man.jpg",
      ),
      Patient(
        id: "2",
        userId: "2",
        firstName: "Jane",
        lastName: "Smith",
        age: "25",
        birthdayDate: "1997-10-23",
        email: "jane.smith@example.com",
        appointmentQuantity: "1",
        photoUrl: "https://st4.depositphotos.com/1017228/20766/i/600/depositphotos_207663178-stock-photo-image-of-happy-young-man.jpg",
      ),
      Patient(
        id: "3",
        userId: "3",
        firstName: "David",
        lastName: "Johnson",
        age: "40",
        birthdayDate: "1982-02-07",
        email: "david.johnson@example.com",
        appointmentQuantity: "3",
        photoUrl: "https://st4.depositphotos.com/1017228/20766/i/600/depositphotos_207663178-stock-photo-image-of-happy-young-man.jpg",
      ),
      
    ];
    filteredPatients=patients;
  }
  
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Patients", 
        style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        
      ),
       body: Column(
  children: [
    Padding(
      padding: const EdgeInsets.fromLTRB(4,40, 4,20 ),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: 360, // Establece el ancho deseado
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              filteredPatients = patients
                  .where((patient) =>
                      ('${patient.firstName} ${patient.lastName}')
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                  .toList();
            });
          },
          decoration: const InputDecoration(
            labelText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    ),
    Expanded(
      child: ListView.builder(
        itemCount: filteredPatients.length,
        itemBuilder: (context, index) {
          return PatientItem(patient: filteredPatients[index]);
        },
      ),
    ),
  ],
),

    );
  }
}


class PatientItem extends StatefulWidget {
  const PatientItem({super.key, required this.patient});
  final Patient patient;

  @override
  State<PatientItem> createState() => _PatientItemState();
}

class _PatientItemState extends State<PatientItem> {
  
  @override
  Widget build(BuildContext context) {
     return FractionallySizedBox(
  widthFactor: 0.9,
  child: Card(
    color: Colors.blue,
    child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            "${widget.patient.firstName} ${widget.patient.lastName}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          const SizedBox(height: 8),
          SizedBox(
            width: 80,
            height: 30, // Establece el ancho deseado para el botón
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Age: ${widget.patient.age}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12, // Ajusta el tamaño de fuente según tus necesidades
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const SizedBox(width: 8),
          SizedBox(
            width: 140,
            height: 30, // Establece el ancho deseado para el botón
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Appointments Quantity: ${widget.patient.appointmentQuantity}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 10, // Ajusta el tamaño de fuente según tus necesidades
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      leading: Hero(
        tag: widget.patient.id,
        child: Image(
          image: NetworkImage(widget.patient.photoUrl),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDetails(
                patient: widget.patient,
              ),
            ),
          );


      },
    ),
  ),
);


    
  }
}
