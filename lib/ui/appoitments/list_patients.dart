import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theraphy_physiotherapist_app/data/model/appointment.dart';
import 'package:theraphy_physiotherapist_app/data/model/patient.dart';
import 'package:theraphy_physiotherapist_app/data/remote/http_helper.dart';

import '../home/home.dart';
import '../patients/patients_list.dart';
import '../profile/physiotherapist_profile.dart';
import '../treatments/TreatmentSsessions.dart';

class ListAppointments extends StatefulWidget {
  const ListAppointments({super.key});

  @override
  State<ListAppointments> createState() => _ListAppointmentsState();
}

class _ListAppointmentsState extends State<ListAppointments> {
  String searchText = '';
  int _currentIndex = 2;
  int selectedIndex = 2;
  int currentUser = 3;
  List<Patient>? patients = [];
  List<Appointment>? myAppointments = [];
  List<Appointment>? appointments = [];
  HttpHelper? httpHelper;

  List<Widget> pages = const [
    HomePhysiotherapist(),
    PatientsList(),
    ListAppointments(),
    ListTreatments(),
    PhysiotherapistProfile(),
  ];

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

  final List<Widget> _screens = [
    // Aquí puedes agregar tus pantallas adicionales
    // por ejemplo: Screen1(), Screen2(), Screen3(), ...
  ];

  Future initialize() async {
    currentUser = await getData("userId") as int;

    // ignore: sdk_version_since
    bool equalElement(int number) {
      if (myAppointments != null) {
        for (var patient in myAppointments!) {
          if (patient.id == number) {
            return false;
          }
        }
      }
      return true;
    }
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
            myAppointments?.add(appointment);
          }
        });
        
      }
    });

    appointments = myAppointments;

    //filteredPatients = myPatients;
  }

  TextEditingController searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    httpHelper = HttpHelper();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("My appointments"),
    //   ),
    //   body: const Center(
    //     child: Text("Hello flutter"),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Appointments",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                   appointments = myAppointments
                        ?.where((patient) =>
                            ('${patient.patient.firstName} ${patient.patient.lastName}')
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                        .toList();
                });
                //
              },
              decoration: InputDecoration(
                labelText: 'Buscar',
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.purple), // Color del borde
                  borderRadius: BorderRadius.circular(
                      10), // Radio de las esquinas del borde
                ),
                suffixIcon:
                    const Icon(Icons.search), // Icono de búsqueda a la derecha
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: appointments?.length,
                // separatorBuilder: (BuildContext context, int index) =>
                //     const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 100.0, // Altura deseada de las tarjetas
                    child: Card(
                      color: const Color(0xFFC762FF),
                      child: Container(
                        alignment: Alignment.center, // Centra el contenido
                        child: ListTile(
                          leading: Image.network(
                            appointments![index].patient.photoUrl,
                            width: 50,
                            height: 50,
                          ), // Ruta de la imagen
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start, // Centra los elementos horizontalmente
                              children: [
                                Text(
                                  "${appointments![index].patient.firstName} ${appointments![index].patient.lastName}",
                                  style: const TextStyle(
                                    color: Colors.white, // Color blanco
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ), // Espacio entre los elementos
                              ],
                            ),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .start, // Centra los elementos horizontalmente
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Color de fondo blanco
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                    (appointments![index].topic.length > 12
                                        ? appointments![index]
                                            .topic
                                            .replaceRange(
                                                10,
                                                appointments![index]
                                                    .topic
                                                    .length,
                                                "...")
                                        : appointments![index].topic),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              ),

                              const SizedBox(
                                width: 10,
                              ), // Espacio entre los elementos
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(appointments![index].scheduledDate,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              ),
                              const SizedBox(
                                width: 10,
                              ), // Espacio entre los elementos
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Text('4pm',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyAppointment(
                                  appointment: appointments![
                                      index], // Pasar el objeto appointment al siguiente widget
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                  }
                
              ),
            ),
          ],
        ),
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

class MyAppointment extends StatefulWidget {
  final Appointment appointment;
  const MyAppointment({super.key, required this.appointment});

  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  String searchText = '';
  int _currentIndex = 0;
  int selectedIndex = 2;
  int currentUser = 3;
  List<Patient>? patients = [];
  List<Patient>? myPatients = [];
  List<Appointment>? appointments = [];
  HttpHelper? httpHelper;

  List<Widget> pages = const [
    HomePhysiotherapist(),
    PatientsList(),
    ListAppointments(),
    PatientsList(),
    PhysiotherapistProfile(),
  ];

  final List<Widget> _screens = [
    // Aquí puedes agregar tus pantallas adicionales
    // por ejemplo: Screen1(), Screen2(), Screen3(), ...
  ];

  // Future initialize() async {
  //   bool equalElement(int number) {
  //     if (myPatients != null) {
  //       for (var patient in myPatients!) {
  //         if (patient.id == number) {
  //           return false;
  //         }
  //       }
  //     }
  //     return true;
  //   }

  //   // ignore: sdk_version_since
  //   patients = List.empty();
  //   patients = await httpHelper?.getPatients();
  //   setState(() {
  //     patients = patients;
  //   });

  //   // ignore: sdk_version_since
  //   appointments = List.empty();
  //   appointments = await httpHelper?.getAppointments();
  //   setState(() {
  //     appointments = appointments;
  //   });

  //   appointments?.forEach((appointment) {
  //     if (appointment.physiotherapist.id == currentUser) {
  //       patients?.forEach((patient) {
  //         if (patient.id == appointment.patient.id &&
  //             equalElement(patient.id)) {
  //           myPatients?.add(patient);
  //         }
  //       });
  //     }
  //   });

  //   //filteredPatients = myPatients;
  // }

  // Future postUserId(userId, diagnosis) async {
  //   final appointment = await httpHelper?.updatePost(userId, diagnosis);
  // }

  final TextEditingController _textFieldController = TextEditingController();
  String enteredText = "";

  @override
  void initState() {
    super.initState();
    httpHelper = HttpHelper();
    // initialize();
  }

  void _handleButtonPress() async {
    enteredText = _textFieldController.text;
    await httpHelper?.updatePost(widget.appointment.id.toString(), enteredText);
    // postUserId(widget.appointment.patient.id, enteredText);
    print('Texto ingresado: $enteredText');
    print('id: ${widget.appointment.id.toString()}');
    // Puedes realizar cualquier otra acción con el texto ingresado aquí
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine
    _textFieldController.dispose();
    super.dispose();
  }

// // Llamada al método para realizar el POST
// appointment.updateAppointment('Nuevo diagnóstico');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Appointments",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: 330,
                  height: 250,
                  child: Image.network(
                    widget.appointment.patient.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0D6D6),
                  border: Border.all(
                    color: const Color(0xFFE0D6D6),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Text(
                      widget.appointment.patient.firstName,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.appointment.patient.lastName,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Topic',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0D6D6),
                          border: Border.all(
                            color: const Color(0xFFE0D6D6),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          widget.appointment.topic,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Date',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0D6D6),
                          border: Border.all(
                            color: const Color(0xFFE0D6D6),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          widget.appointment.scheduledDate,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Time',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0D6D6),
                          border: Border.all(
                            color: const Color(0xFFE0D6D6),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          '4pm',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(0),
                width: double.infinity, // Ocupar todo el ancho disponible
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Diagnosis',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: _textFieldController,
                        decoration: const InputDecoration(
                          hintText: 'Ingrese el texto',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _handleButtonPress();
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
