import 'package:flutter/material.dart';
import 'package:gdg_project/models/user.dart';
import 'package:gdg_project/screens/welcome.dart';
import 'package:gdg_project/screens/authenticate/login.dart';
import 'package:provider/provider.dart';

import 'home/dashboard.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Userdata?>(context);

    if (user == null) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GDG Mana',
          theme: ThemeData(
            dividerColor: Colors.black,
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
          useMaterial3: true,
    ),
        home: const WelcomeScreen());
    }else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GDG Mana',
        theme: ThemeData(
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
          useMaterial3: true,
        ),
        home: const dashboardScreen(),
      );
    }
  }
}
