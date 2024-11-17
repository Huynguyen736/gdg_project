import 'package:flutter/material.dart';

import '../widgets/custom_scaffold.dart';
import 'member_list.dart';
import 'member_list_memview.dart';

class ChoosebranchScreen extends StatefulWidget {
  const ChoosebranchScreen({super.key, required this.role});
  final String role;

  @override
  State<ChoosebranchScreen> createState() => _ChoosebranchScreenState();
}

class _ChoosebranchScreenState extends State<ChoosebranchScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Access Members",
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ElevatedButton.icon(onPressed: () { widget.role == "Leader" ?
                Navigator.push(context, MaterialPageRoute(builder: (context) => const member_list(branch: "Developer",))) :
                Navigator.push(context, MaterialPageRoute(builder: (context) => const member_list_memview(branch: "Developer",)));  },
                  icon: const Icon(Icons.view_list),
                  label: const Text("Developer")),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ElevatedButton.icon(onPressed: () { widget.role == "lead" ?
              Navigator.push(context, MaterialPageRoute(builder: (context) => const member_list(branch: "Marcom",))) :
              Navigator.push(context, MaterialPageRoute(builder: (context) => const member_list_memview(branch: "Marcom",)));  },
                  icon: const Icon(Icons.view_list),
                  label: const Text("Marcom")),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ElevatedButton.icon(onPressed: () { widget.role == "lead" ?
              Navigator.push(context, MaterialPageRoute(builder: (context) => const member_list(branch: "Operation",))) :
              Navigator.push(context, MaterialPageRoute(builder: (context) => const member_list_memview(branch: "Operation",)));  },
                  icon: const Icon(Icons.view_list),
                  label: const Text("Operator")),
            ),
          ],
        ),
      ),
    );
  }
}
