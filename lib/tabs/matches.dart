import 'package:flutter/material.dart';

class matches extends StatelessWidget {
  const matches({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.indigoAccent,
      child: Center(
        child: Text(
            'afficher les matchs',
        style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
