import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdg_project/screens/member_list.dart';
import 'package:gdg_project/screens/profile.dart';
import 'package:gdg_project/services/auth.dart';
import 'package:gdg_project/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../widgets/loading.dart';
import '../ChooseBranch.dart';

class dashboardScreen extends StatefulWidget {
  const dashboardScreen({super.key});

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user
    = Provider.of<Userdata?>(context, listen: false);
    if (user != null) {
    Map<String, dynamic>? fetchedData = await user.getUserData();
    setState(() {
    userData = fetchedData;
    });
    }
  }
  @override
  Widget build(BuildContext context) {
    final user
    = Provider.of<Userdata?>(context);
    AuthService auth = AuthService();
    void showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: TextButton.icon(onPressed: () async {
              await auth.signOut();
              Navigator.pop(context);
            },
                icon: const Icon(Icons.person_2),
                label: const Text("Sign out")),
        );
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Dashboard"),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            TextButton.icon(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10.0)
                ),
                icon: const Icon(Icons.person),
                label: const Text(""),
                onPressed: () { userData != null ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profile(
                      contactID: user!.uid,
                      name: userData?["name"],
                      phone: userData?["phone"],
                      email: userData?["email"],
                      branch: userData?["branch"],
                      avatar: "https://api.dicebear.com/9.x/bottts-neutral/png?seed=${userData?["email"]}",
                      birthday: userData?["date"],
                      gen: userData?["gen"],
                      role: userData?["role"],
                    ))) : print("error");},
              ),
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(10.0)
                ),
                icon: const Icon(Icons.settings),
                label: const Text(""),
                onPressed: () => showSettingsPanel(),
              ),
            ),
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("members").doc(user!.uid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();

            }

            // Data has been successfully fetched
            DocumentSnapshot<Object?>? data = snapshot.data;
            return checkRole(data); // Now you can safely use checkRole
            },
        ),
      );
  }

  Widget checkRole(DocumentSnapshot<Object?>? data) {
    if (data != null && data.exists) {
      Map<String, dynamic> dataMap = data.data() as Map<String, dynamic>;
      if (dataMap['role'] == "Leader") {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: ElevatedButton.icon(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ChoosebranchScreen(role: "Leader",)));},
                    icon: const Icon(Icons.view_list),
                    label: const Text("Access Members")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.person), label: const Text("Push notification")),
              ),)
          ],
        ); // Return a widget for the lead role
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: ElevatedButton.icon(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ChoosebranchScreen(role: 'Member',)));},
                    icon: const Icon(Icons.view_list),
                    label: const Text("Access Members")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.person), label: const Text("View notification")),
              ),)
          ],
        ); //// Return a different widget
      }
    } else {
      return const Loading(); // Or a loading indicator
    }
  }
}
