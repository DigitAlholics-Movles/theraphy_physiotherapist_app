// import 'package:flutter/material.dart';
// import 'package:theraphy_physiotherapist_app/data/model/appointment.dart';
// import 'package:theraphy_physiotherapist_app/data/model/patient.dart';

// import 'package:theraphy_physiotherapist_app/data/remote/http_helper.dart';

// class MyAppointment extends StatefulWidget {
//   final Appointment appointment;
//   const MyAppointment({super.key, required this.appointment});

//   @override
//   State<MyAppointment> createState() => _MyAppointmentState();
// }

// class _MyAppointmentState extends State<MyAppointment> {
//   String searchText = '';
//   int _currentIndex = 0;
//   int selectedIndex = 1;
//   int currentUser = 3;
//   List<Patient>? patients = [];
//   List<Patient>? myPatients = [];
//   List<Appointment>? appointments = [];
//   HttpHelper? httpHelper;

//   final List<Widget> _screens = [
//     // Aquí puedes agregar tus pantallas adicionales
//     // por ejemplo: Screen1(), Screen2(), Screen3(), ...
//   ];

//   Future initialize() async {
//     bool equalElement(int number) {
//       if (myPatients != null) {
//         for (var patient in myPatients!) {
//           if (patient.id == number) {
//             return false;
//           }
//         }
//       }
//       return true;
//     }

//     // ignore: sdk_version_since
//     patients = List.empty();
//     patients = await httpHelper?.getPatients();
//     setState(() {
//       patients = patients;
//     });

//     // ignore: sdk_version_since
//     appointments = List.empty();
//     appointments = await httpHelper?.getAppointments();
//     setState(() {
//       appointments = appointments;
//     });

//     appointments?.forEach((appointment) {
//       if (appointment.physiotherapist.id == currentUser) {
//         patients?.forEach((patient) {
//           if (patient.id == appointment.patient.id &&
//               equalElement(patient.id)) {
//             myPatients?.add(patient);
//           }
//         });
//       }
//     });

//     //filteredPatients = myPatients;
//   }

//   @override
//   void initState() {
//     super.initState();
//     httpHelper = HttpHelper();
//     initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My appointments"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Image.asset('assets/logotheraphy.png'),
//           ),
//           const SizedBox(height: 50),
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.black,
//                 width: 2.0,
//               ),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: const Text(
//               "Patient's Name",
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 children: [
//                   const Text(
//                     'Topic',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.black,
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: const Text(
//                       'Knees',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 children: [
//                   const Text(
//                     'Date',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.black,
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: const Text(
//                       '25/08/2023',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 children: [
//                   const Text(
//                     'Time',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.black,
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: const Text(
//                       '4pm',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.all(10),
//             width: double.infinity, // Ocupar todo el ancho disponible
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Diagnosis',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 10),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black,
//                       width: 2.0,
//                     ),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: const TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Ingrese el texto',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               // Acción del botón
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//       bottomNavigationBar: ClipRRect(
//         borderRadius: const BorderRadius.vertical(
//             top: Radius.circular(
//                 10.0)), // Ajusta el radio de las esquinas según tus preferencias
//         child: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (int index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           items: const [
//             BottomNavigationBarItem(
//               backgroundColor: Colors.transparent, // Fondo transparente
//               icon: Icon(Icons.home),
//               label: 'Inicio',
//             ),
//             BottomNavigationBarItem(
//               backgroundColor: Colors.transparent, // Fondo transparente
//               icon: Icon(Icons.people),
//               label: 'People',
//             ),
//             BottomNavigationBarItem(
//               backgroundColor: Colors.transparent, // Fondo transparente
//               icon: Icon(Icons.calendar_month),
//               label: 'Calendar',
//             ),
//             BottomNavigationBarItem(
//               backgroundColor: Colors.transparent, // Fondo transparente
//               icon: Icon(Icons.video_settings),
//               label: 'Video',
//             ),
//             BottomNavigationBarItem(
//               backgroundColor: Colors.transparent, // Fondo transparente
//               icon: Icon(Icons.person),
//               label: 'Person',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
