import 'package:flutter/material.dart';
import 'package:gdg_project/screens/authenticate/signup.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child, this.title});
  final Widget? child;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(title!),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Container(
          //     alignment: Alignment.center,
          //     margin: const EdgeInsets.only(bottom: 400.0),
          //     child: Image.asset("assets/images/logo_start.png"),
          // ),
          SafeArea(
              child: child!,
          )
        ],
      ),
    );
  }
}
