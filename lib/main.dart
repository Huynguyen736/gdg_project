import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gdg_project/firebase_options.dart';
import 'package:gdg_project/services/auth.dart';
import 'package:gdg_project/screens/wrapper.dart';
import 'package:gdg_project/services/notification.dart';
import 'package:provider/provider.dart';
import 'package:gdg_project/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Message().initNotidications();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'GDG Mana',
    //   theme: ThemeData(
    //     fontFamily: "Poppins",
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
    //
    //     useMaterial3: true,
    //   ),
    //   home: const dashboardScreen(),

    return StreamProvider<Userdata?>.value(
      value: AuthService().user,
      initialData: null,
      child: const Wrapper(),
    );
  }
}
