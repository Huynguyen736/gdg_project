import 'package:flutter/material.dart';
import 'package:gdg_project/screens/authenticate/login.dart';
import 'package:gdg_project/screens/authenticate/signup.dart';
import 'package:gdg_project/widgets/Welcome_button.dart';
import 'package:gdg_project/widgets/custom_scaffold.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GDG Mana',
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Image.asset("assets/images/logo_start.png"),
            Align(
              alignment: Alignment.topCenter,
              child: Flexible(
                flex: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 40.0,
                    ),
                    child: Center(
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Welcome GDGer!\n",
                                  style: TextStyle(
                                    fontSize: 45.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                  )
                                ),
                                TextSpan(
                                    text: "\nPlease login in to Join with us",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    )
                                )
                              ]
                            ))),
              )),
            ),
            const Flexible(
              flex: 1,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      Expanded(child: WelcomeButton(
                        buttonText: "Sign in",
                        onTap: signinScreen(),
                        color: Colors.brown,
                      )),
                      Expanded(child: WelcomeButton(
                        buttonText: "Sign up",
                        onTap: signupScreen(),
                        color: Colors.amberAccent,
                      )),
                  ],
                  )))
          ],
        ),
      ),
    );
  }
}
