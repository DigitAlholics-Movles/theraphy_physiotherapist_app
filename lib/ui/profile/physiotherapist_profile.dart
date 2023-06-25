import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theraphy_physiotherapist_app/data/remote/http_helper.dart';
import 'package:theraphy_physiotherapist_app/ui/initial_views/login.dart';

import '../../data/model/physiotherapist.dart';
import '../appoitments/list_patients.dart';
import '../home/home.dart';
import '../patients/patients_list.dart';
import '../treatments/TreatmentSsessions.dart';

class PhysiotherapistProfile extends StatefulWidget {
  const PhysiotherapistProfile({super.key});

  @override
  State<PhysiotherapistProfile> createState() => _PhysiotherapistProfileState();
}

class _PhysiotherapistProfileState extends State<PhysiotherapistProfile> {
  List<Physiotherapist>? physioterapists;
  HttpHelper? httpHelper;
  Physiotherapist? selectedPhysiotherapist;
  int userLogged = 1;
  int selectedIndex = 4;

  ProfileItem? profileItem;

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
    userLogged = await getData("userId") as int;

    selectedPhysiotherapist =
        await httpHelper?.getPhysiotherapistById(userLogged);

     profileItem =
          ProfileItem(physiotherapist: selectedPhysiotherapist!);

    setState(() {
      // physioterapists =
      //     selectedPhysiotherapist != null ? [selectedPhysiotherapist!] : null;
      selectedPhysiotherapist = selectedPhysiotherapist;
    });
  }

  @override
  void initState() {
    httpHelper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
      
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Profile",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),          
        body: profileItem,
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

class ProfileItem extends StatefulWidget {
  const ProfileItem({super.key, required this.physiotherapist});
  final Physiotherapist? physiotherapist;

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              width: 320,
              height: 250,
              child: Image.network(
                widget.physiotherapist!.photoUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.physiotherapist!.firstName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Column(
              children: [
                Row(children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.physiotherapist!.birthdayDate,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const Icon(Icons.school_outlined),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.physiotherapist!.specialization,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const Icon(Icons.email_outlined),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.physiotherapist!.email,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    //////////////////
                    //MARIAAAA AQUI PONES EL HOMEEEEEEE
                    //////////////
                    builder: (context) => const Login(),
                  ));
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
