import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdg_project/services/auth.dart';

import '../widgets/Info_Widget.dart';
import '../widgets/profile_widget.dart';

class profile extends StatefulWidget {
  const profile({super.key, required this.contactID, required this.name, required this.phone, required this.email, required this.gen, required this.role, required this.birthday, required this.branch, required this.avatar});

  @override
  State<profile> createState() => _profileState();
  final String contactID;
  final String name;
  final String phone;
  final String email;
  final String gen;
  final String role;
  final String birthday;
  final String branch;
  final String avatar;
}

class _profileState extends State<profile> {

  final AuthService _auth = AuthService();
  static final String title = "Profile";

  late String _contactID;
  late String _name;
  late String _phone;
  late String _email;
  late String _gen;
  late String _role;
  late String _birthday;
  late String _branch;
  late String _avatar;

  @override
  void initState() {
    _contactID = widget.contactID;
    _name = widget.name;
    _phone = widget.phone;
    _email = widget.email;
    _gen = widget.gen;
    _role = widget.role;
    _birthday = widget.birthday;
    _branch = widget.branch;
    _avatar = widget.avatar;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(imagePath: _avatar, onClicked: () {  },),
            const SizedBox(height: 24,),
            buildName(_name, _email,_phone,_birthday),
            const SizedBox(height: 24,),
            InfoWidget(gen: _gen,branch: _branch,role: _role,),
          ],
        ),
      );
  }

  Widget buildName(String name, String email, String phone, String date) => Column(
    children: [
      Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 24,),
      Text(
        email,
        style: const TextStyle(color: Colors.grey),
      ),
      Text(
        phone,
        style: const TextStyle(color: Colors.grey),
      ),
      Text(
        date,
        style: const TextStyle(color: Colors.grey),
      )
    ],
  );
}
