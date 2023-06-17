import 'package:flutter/material.dart';
import 'package:theraphy_physiotherapist_app/ui/patients/My_appointment.dart';

class ListAppointments extends StatefulWidget {
  const ListAppointments({super.key});

  @override
  State<ListAppointments> createState() => _ListAppointmentsState();
}

class _ListAppointmentsState extends State<ListAppointments> {
  String searchText = '';
  int _currentIndex = 0;

  final List<Widget> _screens = [
    // Aquí puedes agregar tus pantallas adicionales
    // por ejemplo: Screen1(), Screen2(), Screen3(), ...
  ];

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
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 120.0, // Altura deseada de las tarjetas
                    child: Card(
                      child: Container(
                        alignment: Alignment.center, // Centra el contenido
                        child: ListTile(
                          leading: Image.asset(
                            'assets/logotheraphy.png',
                          ), // Ruta de la imagen
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Centra los elementos horizontalmente
                            children: [
                              Text('Tarjeta $index'),
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
                                child: const Text('Kness'),
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
                                child: const Text('25/08/2023'),
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
                                builder: (context) => const MyAppointment(),
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
