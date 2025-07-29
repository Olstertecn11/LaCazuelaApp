import 'package:flutter/material.dart';
import 'package:lacazuela_mobile/screens/base_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(title: 'Inicio', body: Center(
      child: Text('Bienvenido a la aplicacion')
    ));
  }
}
