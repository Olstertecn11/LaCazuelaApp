import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lacazuela_mobile/screens/base_screen.dart';
import 'package:lacazuela_mobile/screens/usuarios_screen.dart';
import 'package:lacazuela_mobile/screens/productos_screen.dart';
import 'package:lacazuela_mobile/screens/home_screen.dart';
import 'package:lacazuela_mobile/screens/login_screen.dart';
import 'package:lacazuela_mobile/screens/catalogo_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Cazuela Chapina',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MainScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/productos': (context) => ProductosScreen(),
        '/usuarios': (context) => UsuariosScreen(),
        '/catalogos': (context) => CatalogoScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  // Verificar si el usuario está autenticado
  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'La Cazuela Chapina', // Título para el AppBar
      body: Center(
        child: Text('Contenido de la pantalla'),
      ),
    );
  }
}
