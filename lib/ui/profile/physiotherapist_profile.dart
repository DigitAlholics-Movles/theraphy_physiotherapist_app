import 'package:flutter/material.dart';
import 'package:theraphy_physiotherapist_app/data/remote/http_helper.dart';

import '../../data/model/physiotherapist.dart';

class PhysiotherapistProfile extends StatefulWidget {
  const PhysiotherapistProfile({super.key});
  
  
  @override
  State<PhysiotherapistProfile> createState() => _PhysiotherapistProfileState();
}

class _PhysiotherapistProfileState extends State<PhysiotherapistProfile> {
  
  List<Physiotherapist>? physioterapists;
  HttpHelper? httpHelper;
  Physiotherapist? selectedPhysiotherapist;


  Future initialize() async {
    physioterapists = List.empty();
    physioterapists = await httpHelper?.getPhysiotherapist();
    selectedPhysiotherapist = physioterapists?.firstWhere((physiotherapist) => physiotherapist.id == 1);
    setState(() {
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
        title: const Text('My profile'),
      ),
      body: 
        Column(
        children: 
        [
          PhysiotherapistById(physiotherapist: selectedPhysiotherapist!),
        ],
      ),
      
    );
  }
}
class PhysiotherapistById extends StatefulWidget {
  const PhysiotherapistById({super.key, required this.physiotherapist});
  final Physiotherapist physiotherapist;

  @override
  State<PhysiotherapistById> createState() => _PhysiotherapistById();
}

class _PhysiotherapistById extends State<PhysiotherapistById> {

  HttpHelper? httpHelper;
  List<Physiotherapist>? physitherapists;

  Future initalize() async {
    // ignore: sdk_version_since
    physitherapists = List.empty();
    physitherapists = await httpHelper?.getTracksByPhysiotherapistById(widget.physiotherapist.id);
    setState(() {
      physitherapists = physitherapists;
    });
  }

  @override
  void initState() {
    httpHelper = HttpHelper();
    initalize();
    super.initState();
  }
  edit(){

  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                widget.physiotherapist.photoUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
           Text(
            widget.physiotherapist.firstName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            height: 50,
          ),
           Padding(
            padding:  const EdgeInsets.only(left: 25.0),
            child:  Column(
              children: [
                 Row(children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.physiotherapist.birthdayDate,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ]),
                 const SizedBox(
              height: 30,
            ),
             Row(children: [
              const Icon(Icons.school_outlined),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.physiotherapist.specialization,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ]),
             const SizedBox(
              height: 30,
            ),
             Row(children: [
              const Icon(Icons.email_outlined),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.physiotherapist.email,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                edit();
              },
              child: const Text('Edit'),
            ),
        ],
      );
  }
}
