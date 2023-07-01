import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theraphy_physiotherapist_app/data/model/appointment.dart';
import 'package:theraphy_physiotherapist_app/data/model/patient.dart';
import 'package:theraphy_physiotherapist_app/data/remote/http_helper.dart';
import 'package:theraphy_physiotherapist_app/ui/patients/patient_details.dart';

import '../appoitments/list_patients.dart';
import '../home/home.dart';
import '../profile/physiotherapist_profile.dart';
import '../treatments/TreatmentSsessions.dart';

class PatientsList extends StatefulWidget {
  const PatientsList({super.key});

  @override
  State<PatientsList> createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  int selectedIndex = 1;
  int currentUser = 3;

  List<Widget> pages = const [
    HomePhysiotherapist(),
    PatientsList(),
    ListAppointments(),
    ListTreatments(),
    PhysiotherapistProfile(),
  ];

  List<Patient>? patients = [];
  List<Patient>? myPatients = [];
  List<Appointment>? appointments = [];

  List<Patient>? filteredPatients = [];
  HttpHelper? httpHelper;

  Future<int> getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    if (value != null) {
    int? parsedValue = int.tryParse(value);
    currentUser = parsedValue ?? 0;
    }
    return currentUser;
    //print('Valor recuperado del almacenamiento local: $value');
  }

  Future initialize() async {
    currentUser = await getData("userId") as int;
    bool equalElement(int number) {
      if (myPatients != null) {
        for (var patient in myPatients!) {
          if (patient.id == number) {
            return false;
          }
        }
      }
      return true;
    }

    // ignore: sdk_version_since
    patients = List.empty();
    patients = await httpHelper?.getPatients();
    setState(() {
      patients = patients;
    });

    // ignore: sdk_version_since
    appointments = List.empty();
    appointments = await httpHelper?.getAppointments();
    setState(() {
      appointments = appointments;
    });

    appointments?.forEach((appointment) {
      if (appointment.physiotherapist.id == currentUser) {
        patients?.forEach((patient) {
          if (patient.id == appointment.patient.id &&
              equalElement(patient.id)) {
            myPatients?.add(patient);
          }
        });
      }
    });

    filteredPatients = myPatients;
  }

  TextEditingController searchController =
      TextEditingController(); // Controlador del campo de búsqueda

  @override
  void initState() {
    super.initState();
    httpHelper = HttpHelper();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Patients",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
            // ignore: sized_box_for_whitespace
            child: Container(
              width: 360, // Establece el ancho deseado
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    filteredPatients = myPatients
                        ?.where((patient) =>
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
              itemCount: filteredPatients?.length,
              itemBuilder: (context, index) {
                return PatientItem(patient: filteredPatients![index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pages[index]),
              );
            },
            unselectedItemColor: const Color.fromARGB(255, 104, 104, 104),
            selectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: const Icon(Icons.home),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: const Icon(Icons.people),
                ),
                label: 'Patients',
              ),
              BottomNavigationBarItem(
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: const Icon(Icons.calendar_month),
                ),
                label: 'Appointments',
              ),
              BottomNavigationBarItem(
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: const Icon(Icons.video_collection),
                ),
                label: 'Treatments',
              ),
              BottomNavigationBarItem(
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: const Icon(Icons.person),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
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
                width: 60,
                height: 30, // Establece el ancho deseado para el botón
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientDetails(
                          patient: widget.patient,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Age: ${widget.patient.age}",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize:
                            12, // Ajusta el tamaño de fuente según tus necesidades
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const SizedBox(width: 8),
              SizedBox(
                width: 120,
                height: 30, // Establece el ancho deseado para el botón
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientDetails(
                          patient: widget.patient,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      
                    ),
                     minimumSize: const Size(10, double.infinity),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "N Appointments: ${widget.patient.appointmentQuantity}",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize:
                            10, // Ajusta el tamaño de fuente según tus necesidades
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: Hero(
            tag: widget.patient.id,
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 85.0, // Establece el ancho mínimo deseado
                maxWidth: 85.0, // Establece el ancho máximo deseado
              ),
              child: Image(
                image: NetworkImage(widget.patient.photoUrl),
                fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
              ),
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
