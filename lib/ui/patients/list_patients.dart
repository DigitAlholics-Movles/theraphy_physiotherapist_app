import 'package:flutter/material.dart';
import 'package:theraphy_physiotherapist_app/data/model/appointment.dart';
import 'package:theraphy_physiotherapist_app/data/model/patient.dart';
import 'package:theraphy_physiotherapist_app/data/remote/http_helper.dart';

class ListAppointments extends StatefulWidget {
  const ListAppointments({super.key});

  @override
  State<ListAppointments> createState() => _ListAppointmentsState();
}

class _ListAppointmentsState extends State<ListAppointments> {
  String searchText = '';
  int _currentIndex = 0;
  int selectedIndex = 1;
  int currentUser = 3;
  List<Patient>? patients = [];
  List<Patient>? myPatients = [];
  List<Appointment>? appointments = [];
  HttpHelper? httpHelper;

  final List<Widget> _screens = [
    // Aquí puedes agregar tus pantallas adicionales
    // por ejemplo: Screen1(), Screen2(), Screen3(), ...
  ];

  Future initialize() async {
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

    //filteredPatients = myPatients;
  }

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
        title: const Text('My Appointments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
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
                itemCount: appointments!.length,
                // separatorBuilder: (BuildContext context, int index) =>
                //     const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 120.0, // Altura deseada de las tarjetas
                    child: Card(
                      child: Container(
                        alignment: Alignment.center, // Centra el contenido
                        child: ListTile(
                          leading: Image.network(
                            appointments![index].patient.photoUrl,
                            width: 50,
                            height: 50,
                          ), // Ruta de la imagen
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Centra los elementos horizontalmente
                            children: [
                              Text(appointments![index].patient.firstName),
                              Text(appointments![index].patient.lastName),
                              const SizedBox(
                                width: 10,
                              ), // Espacio entre los elementos
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centra los elementos horizontalmente
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text(appointments![index].topic),
                              ),
                              const SizedBox(
                                width: 10,
                              ), // Espacio entre los elementos
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text(appointments![index].scheduledDate),
                              ),
                              const SizedBox(
                                width: 10,
                              ), // Espacio entre los elementos
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const Text('4pm'),
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
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10.0),
        ), // Ajusta el radio de las esquinas según tus preferencias
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent, // Fondo transparente
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent, // Fondo transparente
              icon: Icon(Icons.people),
              label: 'People',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent, // Fondo transparente
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent, // Fondo transparente
              icon: Icon(Icons.video_settings),
              label: 'Video',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent, // Fondo transparente
              icon: Icon(Icons.person),
              label: 'Person',
            ),
          ],
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
  int selectedIndex = 1;
  int currentUser = 3;
  List<Patient>? patients = [];
  List<Patient>? myPatients = [];
  List<Appointment>? appointments = [];
  HttpHelper? httpHelper;

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
        title: const Text("My appointments"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                widget.appointment.patient.photoUrl,
                width: 250,
                height: 250,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                        border: Border.all(
                          color: Colors.black,
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
                const SizedBox(width: 10),
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
                        border: Border.all(
                          color: Colors.black,
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
                const SizedBox(width: 10),
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
                        border: Border.all(
                          color: Colors.black,
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
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
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
                    padding: const EdgeInsets.all(10),
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
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(
                10.0)), // Ajusta el radio de las esquinas según tus preferencias
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent, // Fondo transparente
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent, // Fondo transparente
              icon: Icon(Icons.people),
              label: 'People',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent, // Fondo transparente
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent, // Fondo transparente
              icon: Icon(Icons.video_settings),
              label: 'Video',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent, // Fondo transparente
              icon: Icon(Icons.person),
              label: 'Person',
            ),
          ],
        ),
      ),
    );
  }
}
