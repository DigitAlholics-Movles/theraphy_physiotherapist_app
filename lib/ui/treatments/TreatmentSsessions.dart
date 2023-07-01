import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theraphy_physiotherapist_app/data/model/treatment.dart';
import 'package:theraphy_physiotherapist_app/data/remote/http_helper.dart';
import 'package:theraphy_physiotherapist_app/ui/treatments/NewTreatment.dart';
import 'package:theraphy_physiotherapist_app/ui/treatments/TreatmenteInfo.dart';

import '../appoitments/list_patients.dart';
import '../home/home.dart';
import '../patients/patients_list.dart';
import '../profile/physiotherapist_profile.dart';

class ListTreatments extends StatefulWidget {
  const ListTreatments({Key? key}) : super(key: key);

  @override
  State<ListTreatments> createState() => _ListTreatmentsState();
}

class _ListTreatmentsState extends State<ListTreatments> {
  String searchText = '';
  int userLogged = 1;
  int selectedIndex = 3;

  List<Treatment> treatments = [];

  List<Widget> pages = const [
    HomePhysiotherapist(),
    PatientsList(),
    ListAppointments(),
    ListTreatments(),
    PhysiotherapistProfile(),
  ];

  @override
  void initState() {
    super.initState();
    loadTreatments(); // Carga los tratamientos al inicializar el estado
  }

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

  Future<void> loadTreatments() async {
    // Utiliza la clase HttpHelper para obtener los tratamientos
    userLogged = await getData("userId") as int;
    print('paraver:');
    print('Error al cargar la imagen: $userLogged');
    final httpHelper = HttpHelper();
    final fetchedTreatments =
        await httpHelper.getTreatmentsByPhysiotherapistId(userLogged);

    if (fetchedTreatments != null) {
      setState(() {
        treatments = fetchedTreatments;
      });
    }
  }

  List<Treatment> get filteredTreatments {
    // Obtener la lista de tratamientos filtrados en función del texto de búsqueda
    if (searchText.isEmpty) {
      return treatments; // Si no hay texto de búsqueda, mostrar todos los tratamientos
    } else {
      return treatments.where((treatment) {
        final titleLower = treatment.title.toLowerCase();
        final queryLower = searchText.toLowerCase();
        return titleLower.contains(queryLower);
      }).toList();
    }
  }

  Future<void> addNewTreatment() async {
    final newTreatment = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewTreatment(userLogged: userLogged),
      ),
    );

    if (newTreatment != null) {
      setState(() {
        treatments.add(newTreatment);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Treatments Sessions',
            style: TextStyle(color: Colors.black)),
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
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple),
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 36.0,
                  childAspectRatio: 0.74,
                ),
                itemCount: filteredTreatments
                    .length, // Usar la lista de tratamientos filtrados
                itemBuilder: (BuildContext context, int index) {
                  return TreatmentItem(
                    treatment: filteredTreatments[index],
                    selectTreatment: () {
                      // Acción al seleccionar el tratamiento
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed:
                        addNewTreatment, // Utiliza el método addNewTreatment
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 32.0,
                    ),
                  ),
                ),
              ],
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

class TreatmentItem extends StatelessWidget {
  final Treatment treatment;
  final VoidCallback selectTreatment;

  const TreatmentItem({
    required this.treatment,
    required this.selectTreatment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
                
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      5.0), // Ajusta el radio de borde según tus necesidades
                  child: Image.network(
                    treatment.photoUrl,
                    height: 90,
                  ),
                ),
              
              const SizedBox(height: 5),
              Text(
                treatment.title,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text('N° of Sessions: ${treatment.sessionsQuantity}'),
              ),
              
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TreatmentInfo(
                        treatmentName: treatment.title,
                        treatmentImage: treatment.photoUrl,
                        treatmentDescription: treatment.description,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // Color de fondo blanco
                  // Color de texto negro
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Borde de radio 10
                   
                  ),
                   minimumSize: const Size(0, 25),
                ),
                
                child: const Text(
                  'Información',
                  style: TextStyle(color: Colors.black), // Color de texto negro
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
