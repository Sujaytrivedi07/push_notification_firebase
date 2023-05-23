import 'package:flutter/material.dart';
class PageTransition extends StatefulWidget {
  const PageTransition({Key? key}) : super(key: key);

  @override
  State<PageTransition> createState() => _PageTransitionState();
}

class _PageTransitionState extends State<PageTransition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transtion Effect"),
      ),
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
