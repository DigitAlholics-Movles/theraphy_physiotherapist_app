import 'package:flutter/material.dart';

import '../../data/model/physiotherapist.dart';
import '../../data/remote/http_helper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Physiotherapist>? physioterapists;
  HttpHelper? httpHelper;
  Physiotherapist? selectedPhysiotherapist;
  int userLogged=1;

  Future initialize() async {
    // physioterapists = await httpHelper?.getPhysiotherapist();
    selectedPhysiotherapist = await httpHelper?.getPhysiotherapistById(userLogged);
    setState(() {
      physioterapists =
          selectedPhysiotherapist != null ? [selectedPhysiotherapist!] : null;
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
    if (selectedPhysiotherapist == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('AppSuperZound'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      ProfileItem profileItem =
          ProfileItem(physiotherapist: selectedPhysiotherapist!);
      return Scaffold(
        appBar: AppBar(
          title: const Text('AppSuperZound'),
        ),
        body: profileItem,
        
      );
    }
  }
}

class ProfileItem extends StatefulWidget {
  const ProfileItem({super.key, required this.physiotherapist});
  final Physiotherapist physiotherapist;

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.physiotherapist.firstName),
          Text(widget.physiotherapist.paternalSurname),
          Text(widget.physiotherapist.maternalSurname),
          Text(widget.physiotherapist.age.toString()),
          Text(widget.physiotherapist.rating.toString()),
          Text(widget.physiotherapist.location),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              width: 320,
              height: 250,
              child: Image.network(
                widget.physiotherapist.photoUrl,
                // scale: 0.1, // Opcional: si deseas ajustar el parámetro de escala
              ),
            ),
          ),
          Text(widget.physiotherapist.birthdayDate),
          Text(widget.physiotherapist.consultationsQuantity.toString()),
          Text(widget.physiotherapist.specialization),
          Text(widget.physiotherapist.email),
        ],
      ),
    ));
  }
}
