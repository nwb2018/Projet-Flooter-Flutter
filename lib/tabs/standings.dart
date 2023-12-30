import 'package:flutter/material.dart';

class standings extends StatelessWidget {
  const standings({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.lightBlueAccent,
      child: Center(
        child: Text(
            'afficher le standing',
            style: TextStyle(fontSize: 40),
      ),
      ),
    );
  }
}
