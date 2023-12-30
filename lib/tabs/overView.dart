import 'package:flutter/material.dart';

class overView extends StatelessWidget {
  const overView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: Center(
        child: Text(
            'afficher la vue d ensemble',
        style: TextStyle(fontSize: 40),
      ),
      ),
    );
  }
}
