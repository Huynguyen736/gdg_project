import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdg_project/screens/add_member.dart';
import 'package:gdg_project/screens/profile.dart';
import 'package:gdg_project/widgets/custom_scaffold.dart';
import 'package:icons_plus/icons_plus.dart';

import 'edit_member.dart';

class member_list_memview extends StatefulWidget {
  const member_list_memview({super.key, required this.branch});
  final String branch;

  @override
  State<member_list_memview> createState() => _memberlistState();
}

class _memberlistState extends State<member_list_memview> {


  void deleteContact(String id) async {
    await FirebaseFirestore.instance.collection("members").doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Contact has been deleted")));
  }
  @override
  Widget build(BuildContext context) {
    final membersCollection = FirebaseFirestore.instance.collection("members").where('branch', whereIn: [widget.branch]).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.branch} members"),
        centerTitle: true,
      ),
      body: StreamBuilder(stream: membersCollection, builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          if (documents.isEmpty) {
            return Center(child: Text("No member has been there", style: Theme.of(context).textTheme.headlineMedium,),);
          }
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final contact = documents[index].data() as Map<String, dynamic>;
                final contactID = documents[index].id;
                final String name = contact["name"];
                final String phone = contact["phone"];
                final String email = contact["email"];
                final String gen = contact["gen"];
                final String role = contact["role"];
                final birthday = contact["date"];
                final branch = contact["branch"];
                final avatar = "https://api.dicebear.com/9.x/bottts-neutral/png?seed=$email";
                return InkWell(
                  onTap: () {
                    // Navigate to the profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profile(
                          avatar: avatar,
                          name: name,
                          gen: gen,
                          role: role,
                          email: email,
                          birthday: birthday,
                          phone: phone,
                          contactID: contactID,
                          branch: branch,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text("$name - $role", style: const TextStyle(fontWeight: FontWeight.w600),),
                    subtitle: Text("Generation: $gen \nPhone: $phone"),
                    leading: Hero(
                      tag: contactID,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(avatar),
                      ),
                    ),
                  ),
                );
              });
        }
        else if (snapshot.hasError) {
          return const Center(child: Text("Error to get data. Please check the network connection"),);
        }
        return const Center(child: CircularProgressIndicator.adaptive(),);
      }),
    );
  }
}
