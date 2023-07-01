import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theraphy_physiotherapist_app/data/model/appointment.dart';
import 'package:theraphy_physiotherapist_app/ui/appoitments/list_patients.dart';
import 'package:theraphy_physiotherapist_app/ui/patients/patients_list.dart';
import 'package:theraphy_physiotherapist_app/ui/profile/physiotherapist_profile.dart';

import '../../data/model/patient.dart';
import '../../data/model/physiotherapist.dart';
import '../../data/model/treatment.dart';
import '../../data/remote/http_helper.dart';
import '../treatments/TreatmentSsessions.dart';

class HomePhysiotherapist extends StatefulWidget {
  const HomePhysiotherapist({
    super.key,
  });

  @override
  State<HomePhysiotherapist> createState() => _HomePhysiotherapistState();
}

class _HomePhysiotherapistState extends State<HomePhysiotherapist> {
  List<Patient>? patients;
  List<Appointment>? appointments;
  List<Physiotherapist>? physiotherapists;
  List<Physiotherapist>? physioterapist;
  List<Treatment>? treatments;
  HttpHelper? httpHelper;
  int userLogged = 4;
  String physiotherapistName = '';

  int? treatmentCount;

  int selectedIndex = 0;

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
      userLogged = parsedValue ?? 0;
    }
    return userLogged;
    //print('Valor recuperado del almacenamiento local: $value');
  }

  Future initialize() async {
    appointments = List.empty();
    physiotherapists = List.empty();
    treatments = List.empty();

    userLogged = await getData("userId") as int;

    appointments = await httpHelper?.getAppointments();
    physiotherapists = await httpHelper?.getPhysiotherapist();
    treatments = await httpHelper?.getTreatments();
    physiotherapistName = getPhysiotherapistNameById(userLogged);

    //appointments = await httpHelper?.getAppointments();
    //appointments = await httpHelper?.getAppointmentsByPhysiotherapist(2);
    setState(() {
      appointments = appointments;
      physiotherapists = physiotherapists;
      treatments = treatments;
    });
  }

  List<Appointment>? getAndAppointmentsByPhysiotherapistId(
      int physiotherapistId) {
    if (appointments != null) {
      return appointments!
          .where((appointment) =>
              appointment.physiotherapist.id == physiotherapistId &&
              appointment.done == "0")
          .toList();
    }
    return null;
  }

  List<Appointment>? getPatientsByPhysiotherapistId(int physiotherapistId) {
    if (appointments != null) {
      List<Appointment> filteredAppointments = appointments!
          .where((appointment) =>
              appointment.physiotherapist.id == physiotherapistId)
          .toList();

      int patientCount = filteredAppointments
          .map((appointment) => appointment.patient.id)
          .toSet()
          .length;

      print('Number of patients: $patientCount');
      print('Error al cargar la imagen: $userLogged');
      return filteredAppointments;
    }
    return null;
  }

  void countTreatmentsByPhysiotherapistId() async {
    print('Number of patdfsdfs: ');
    print('Error al cargar la imagen: $userLogged');
    treatments = await httpHelper?.getTreatmentsByPhysiotherapistId(userLogged);
    treatmentCount =
        (await httpHelper?.getTreatmentsByPhysiotherapistId(userLogged))
            ?.length;
    print('Number of patdfsdfs: $treatmentCount');

    treatments?.forEach((element) {
      print('Number of patdfsdfs: ${element.title}');
    });
    // if (treatments != null) {
    //   int treatmentCount = treatments!
    //       .where(
    //           (treatment) => treatment.physiotherapistId == physiotherapistid)
    //       .length;

    //   print(
    //       'Number of treatments for physiotherapist $physiotherapistid: $treatmentCount');

    //   //return treatmentCount;
    // }
    // //return 0;
  }

  String getPhysiotherapistNameById(int physiotherapistId) {
    Physiotherapist? physiotherapist = physiotherapists!.firstWhere(
        (physiotherapist) => physiotherapist.id == physiotherapistId);
    return physiotherapist.firstName;
  }

  @override
  void initState() {
    super.initState();
    httpHelper = HttpHelper();
    countTreatmentsByPhysiotherapistId();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    List<Appointment>? filteredAppointments =
            getAndAppointmentsByPhysiotherapistId(userLogged),
        filteredAppointments2 = getPatientsByPhysiotherapistId(userLogged);

    //treatmentCount = countTreatmentsByPhysiotherapistId(userLogged);
    // Filtrar citas para el fisioterapeuta con ID 1
    // String physiotherapistName = getPhysiotherapistNameById(userLogged); // Obtener el nombre del fisioterapeuta con ID 3

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello, $physiotherapistName",
            style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 25, bottom: 5),
                  child: Text(
                    'Today appointments',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    color: const Color(0xFFC762FF),
                    child: filteredAppointments != null &&
                            filteredAppointments.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredAppointments.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: CardItem(
                                    appointment: filteredAppointments[index]),
                              );
                            },
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal:
                                    10.0), // Ajusta el valor vertical según tus necesidades
                            child: Center(
                              child: Text(
                                'You don\'t have appointments',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 3,
                                  blurRadius: 9,
                                  offset: const Offset(0,5),
                                ),
                               
                              ]),
                              child: Card(
                                color: const Color.fromARGB(0, 193, 168, 212),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${getPatientsByPhysiotherapistId(userLogged)?.length ?? 0}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text('Patients count'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),

                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 3,
                                  blurRadius: 9,
                                  offset: const Offset(0,5),
                                ),
                              ]),
                              child: Card(
                                color: const Color.fromARGB(0, 193, 168, 212),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '$treatmentCount',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text('Treatments count'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )//container
                          ),
                        
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 25, bottom: 5),
                  child: Text(
                    'My patients',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal:
                          10.0), // Ajusta el valor vertical según tus necesidades
                  child: PatientItemByPhysitoherapist(
                      appointment: filteredAppointments2![index]),
                );
              },
              childCount: filteredAppointments2?.length ?? 0,
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

class PatientItemByPhysitoherapist extends StatefulWidget {
  const PatientItemByPhysitoherapist({super.key, required this.appointment});
  final Appointment appointment;

  @override
  State<PatientItemByPhysitoherapist> createState() =>
      _PatientItemByPhysitoherapistState();
}

class _PatientItemByPhysitoherapistState
    extends State<PatientItemByPhysitoherapist> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF0069D0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(
                widget.appointment.patient.photoUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            widget.appointment.patient.firstName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.appointment});
  final Appointment appointment;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: 8),
        Row(
          children: [
            const Icon(Icons.notifications_none_outlined),
            const SizedBox(width: 8),
            Expanded(
              child: Text(widget.appointment.patient.firstName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.left),
            ),
            Expanded(
              child: Text(
                widget.appointment.scheduledDate,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}
