import 'package:flutter/material.dart';
import 'package:theraphy_physiotherapist_app/data/model/treatment.dart';
import 'package:theraphy_physiotherapist_app/data/remote/http_helper.dart';
import 'package:theraphy_physiotherapist_app/ui/treatments/NewTreatment.dart';
import 'package:theraphy_physiotherapist_app/ui/treatments/TreatmenteInfo.dart';

class ListTreatments extends StatefulWidget {
  const ListTreatments({Key? key}) : super(key: key);

  @override
  State<ListTreatments> createState() => _ListTreatmentsState();
}

class _ListTreatmentsState extends State<ListTreatments> {
  String searchText = '';
  int _currentIndex = 0;

  List<Treatment> treatments = [];

  @override
  void initState() {
    super.initState();
    loadTreatments(); // Carga los tratamientos al inicializar el estado
  }

  Future<void> loadTreatments() async {
    // Utiliza la clase HttpHelper para obtener los tratamientos
    final httpHelper = HttpHelper();
    final fetchedTreatments = await httpHelper.getTreatment();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Treatments Sessions'),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 36.0,
                  childAspectRatio: 0.74,
                ),
                itemCount: filteredTreatments.length, // Usar la lista de tratamientos filtrados
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewTreatment()),
                      ).then((newTreatment) {
                        if (newTreatment != null) {
                          setState(() {
                            treatments.add(newTreatment);
                          });
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Icon(
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
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Icon(Icons.people),
              label: 'People',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Icon(Icons.video_settings),
              label: 'Video',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Icon(Icons.person),
              label: 'Person',
            ),
          ],
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
      color: Colors.grey[200],
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0), // Ajusta el radio de borde según tus necesidades
                child: Image.network(
                  treatment.photoUrl,
                  height: 90,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              treatment.title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text('Quantity Sessions: ${treatment.sessionsQuantity}'),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TreatmentInfo(treatmentName: treatment.title, treatmentImage: treatment.photoUrl, treatmentDescription: treatment.description)),
                );
              },
              child: const Text('Información'),
            ),
          ],
        ),
      ),
    );
  }
}