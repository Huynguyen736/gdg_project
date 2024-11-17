import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();
  String _genController = "Gen 4";
  String _roleController = "Member";
  String _branchController = "Developer";
  void addContact() async{
    if(_formkey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection("members").add({
          "name": nameController.text.trim(),
          "phone": phoneController.text.trim(),
          "email": emailController.text.trim(),
          "gen": _genController.trim(),
          "date": "07-03-2006",
          "role": _roleController.trim(),
          "branch": _branchController.trim()
        });
        if (mounted) {
        Navigator.pop(context);
        }
      } on FirebaseException {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to add contact"))
          );
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields"))
      );
    }
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
        title: const Text("Add member"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14.0),
        children: [
          Form(
            key: _formkey,
              child: Column(
            children: [
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
                items: <String>['Marcom', 'Developer', 'Operation']
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
                child: ElevatedButton.icon(onPressed: addContact, icon: const Icon(Icons.person), label: const Text("Add member")),
              )
            ],
          ))
        ],
      ),
    );
  }
}
