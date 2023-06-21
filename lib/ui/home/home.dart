import 'package:flutter/material.dart';


class HomePhysiotherapist extends StatefulWidget {
  const HomePhysiotherapist({super.key,});
  
  @override
  State<HomePhysiotherapist> createState() => _HomePhysiotherapistState();
}

class _HomePhysiotherapistState extends State<HomePhysiotherapist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello, Cristhian'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, top: 25, bottom: 5),
            child: Text(
              'Today appointments',
              style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20
              ),
            ),
          ),
          SizedBox(
            child: CardItem(),
          ),
          SizedBox(
            child: ContainerItem(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 25, bottom: 5),
            child: Text(
              'My patients',
              style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20
              ),
            ),
          ),
          SizedBox(
            child: PatientItem(),
          ),
          SizedBox(
            child: PatientItem(),
          ),
          Spacer(),
          SizedBox(
            child: PatientItem(),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatefulWidget {
  const CardItem({super.key});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        color: const Color(0xFFC762FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Icon(Icons.notifications_none_outlined),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('Patient name 1', textAlign: TextAlign.left),
                  ),
                  Expanded(
                    child: Text(
                      '00:00',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.notifications_none_outlined),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('Patient name 2', textAlign: TextAlign.left),
                  ),
                  Expanded(
                    child: Text(
                      '00:00',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.notifications_none_outlined),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('Patient name 3', textAlign: TextAlign.left),
                  ),
                  Expanded(
                    child: Text(
                      '00:00',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerItem extends StatefulWidget {
  const ContainerItem({super.key,});


  
  

  @override
  State<ContainerItem> createState() => _ContainerItemState();
}

class _ContainerItemState extends State<ContainerItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Card(
                  color: const Color.fromARGB(0, 193, 168, 212),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Text(
                          '15',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Patients count'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:  const EdgeInsets.all(1.0),
                child: Card(
                  color: const Color.fromARGB(0, 193, 168, 212),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Text(
                          '15',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        
                         SizedBox(
                          height: 5,
                        ),
                         Text('Treatments count'),
                    
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  
  }
}


class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppSuperZound'),
      ),
      body: const Column(
        children: [
          Text('adsafs')
        ],
        /*itemBuilder: (context, index) {
          //return PatientItem(album: albums![index]);
        },*/
      ),
    );
  }
}



class PatientItem extends StatefulWidget {
  const PatientItem({super.key});

  @override
  State<PatientItem> createState() => _PatientList2State();
}

class _PatientList2State extends State<PatientItem> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        color: const Color.fromARGB(243, 22, 50, 209),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, top: 15.0, bottom: 15.0),
          child: ListTile(
              leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.network(
                            'https://static.vecteezy.com/system/resources/previews/004/759/418/original/cute-astronaut-with-star-and-moon-free-vector.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: const Text('adsf'),
          ),
        ),
      ),
      
    );
  }
}
