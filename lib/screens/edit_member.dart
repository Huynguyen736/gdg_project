import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditMemberPage extends StatefulWidget {
  const EditMemberPage({super.key, required this.avatar, required this.name, required this.email, required this.phone, required this.gen, required this.role, required this.date, required this.id, required this.branch});
  final String avatar;
  final String name;
  final String email;
  final String phone;
  final String gen;
  final String role;
  final String date;
  final String id;
  final String branch;

  @override
  State<EditMemberPage> createState() => _EditMemberPageState();
}

class _EditMemberPageState extends State<EditMemberPage> {
  final _formkey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController dateController;
  late String _genController;
  late String _roleController;
  late String _branchController;

  void editContact() async {
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection("members").doc(widget.id).update(
            { "name": nameController.text.trim(),
              "phone": phoneController.text.trim(),
              "email": emailController.text.trim(),
              "gen": _genController.trim(),
              "date": "07-03-2006",
              "role": _roleController.trim(),
              "branch": _branchController.trim()},
        );
        if (mounted) {
          Navigator.pop(context);
        }
      } on FirebaseException {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to edit contact")));
      }
    }
  }

  @override
  void initState() {
    nameController = TextEditingController(
      text: widget.name,
    );
    phoneController = TextEditingController(
      text: widget.phone,
    );
    emailController = TextEditingController(
      text: widget.email,
    );
    dateController = TextEditingController(
      text: widget.date,
    );
    _genController = widget.gen;
    _roleController = widget.role;
    _branchController = widget.branch;

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    dateController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add contact"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14.0),
        children: [
          Form(
              key: _formkey,
              child: Column(
                children: [
                  Center(
                    child: Hero(
                      tag: widget.id,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(widget.avatar),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a name";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a phone number";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Phone",
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a email";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const TextField(
                    decoration: InputDecoration(
                        label: Text("Birthday"),
                        filled: true,
                        prefixIcon: Icon(Icons.calendar_month),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                        )
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20,),
                  DropdownButton<String>(
                    value: _genController, // The currently selected value
                    onChanged: (String? newValue) {  // Called when the user selects a new value
                      setState(() {
                        _genController = newValue!;
                      });
                    },
                    items: <String>['Gen 1', 'Gen 2', 'Gen 3', 'Gen 4']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),),
                  const SizedBox(height: 20,),
                  DropdownButton<String>(
                    value: _branchController, // The currently selected value
                    onChanged: (String? newValue) {  // Called when the user selects a new value
                      setState(() {
                        _branchController = newValue!;
                      });
                    },
                    items: <String>['Developer', 'Marcom', 'Operation']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),),
                  const SizedBox(height: 20,),
                  DropdownButton<String>(
                    value: _roleController, // The currently selected value
                    onChanged: (String? newValue) {  // Called when the user selects a new value
                      setState(() {
                        _roleController = newValue!;
                      });
                    },
                    items: <String>["Member", "Leader"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),),
                  const SizedBox(height: 40,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(onPressed: editContact, icon: const Icon(Icons.person), label: const Text("Edit member")),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
