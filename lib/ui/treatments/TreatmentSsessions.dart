import 'package:flutter/material.dart';
import 'package:theraphy_physiotherapist_app/ui/treatments/NewTreatment.dart';
import 'package:theraphy_physiotherapist_app/ui/treatments/TreatmenteInfo.dart';

class Treatment {
  final String title;
  final int sessionsQuantity;
  final String imageLink;
  final String description;

  Treatment({
    required this.title,
    required this.sessionsQuantity,
    required this.imageLink,
    required this.description,
  });
}

class ListTreatments extends StatefulWidget {
  const ListTreatments({Key? key}) : super(key: key);

  @override
  State<ListTreatments> createState() => _ListTreatmentsState();
}

class _ListTreatmentsState extends State<ListTreatments> {
  String searchText = '';
  int _currentIndex = 0;

  List<Treatment> treatments = [
    Treatment(title: 'Lesion de rodilla', sessionsQuantity: 10, imageLink: 'https://i.blogs.es/0710f8/650_1000_cinesiterapia/1366_2000.jpg', description: 'Una lesión de rodilla es un problema doloroso y limitante que afecta la articulación central de la pierna. Puede ser causada por movimientos bruscos, caídas o impactos directos en la rodilla. Los síntomas comunes incluyen dolor, hinchazón, rigidez y dificultad para mover la rodilla. El tratamiento puede incluir terapia física, medicamentos y, en casos graves, cirugía. Es importante buscar atención médica para obtener un diagnóstico preciso y un plan de tratamiento adecuado. El descanso, hielo, compresión y elevación pueden ayudar a controlar el dolor y la inflamación antes de recibir atención médica.'),
    Treatment(title: 'Acupuntura', sessionsQuantity: 8, imageLink: 'https://www.il3.ub.edu/blog/wp-content/uploads/2021/09/iStock-1251542995.jpg', description: 'La terapia de acupuntura es una técnica utilizada por los fisioterapeutas para aliviar el dolor y promover la curación. Se insertan agujas delgadas en puntos específicos del cuerpo para estimular los mecanismos de autocuración del organismo. La acupuntura puede ser utilizada como complemento en el tratamiento de diversas condiciones musculoesqueléticas y dolor crónico.'),
    Treatment(title: 'Vendaje neuromuscular', sessionsQuantity: 12, imageLink: 'https://www.virgendelalcazar.com/wp-content/uploads/2018/05/camilla_traccion.jpg', description: 'La terapia de vendaje neuromuscular, también conocida como kinesiotaping, es una técnica utilizada por los fisioterapeutas para proporcionar soporte, estabilidad y alivio del dolor en áreas específicas del cuerpo. Se aplican cintas elásticas especiales sobre la piel en patrones específicos para estimular la función muscular, mejorar la circulación y promover la recuperación.'),
    Treatment(title: 'Electroterapia', sessionsQuantity: 6, imageLink: 'https://www.metropolsalud.com/wp-content/uploads/2021/07/diatermia.jpg', description: 'La electroterapia es una técnica que utiliza corrientes eléctricas de baja intensidad para aliviar el dolor, reducir la inflamación y promover la recuperación de lesiones. Los fisioterapeutas utilizan diferentes modalidades de electroterapia, como la estimulación muscular, la terapia de ondas de choque o la terapia con corrientes interferenciales, según las necesidades del paciente.'),
  ];

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
                  childAspectRatio: 0.8,
                ),
                itemCount: treatments.length,
                itemBuilder: (BuildContext context, int index) {
                  return TreatmentItem(
                    treatment: treatments[index],
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
            Image.network(
              treatment.imageLink,
              height: 90,
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
                  MaterialPageRoute(builder: (context) => TreatmentInfo(treatmentName: treatment.title, treatmentImage: treatment.imageLink, treatmentDescription: treatment.description)),
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
