import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget body;

  BaseScreen({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'La Cazuela Chapina',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.fastfood),
              title: Text('Productos'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/productos');
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Catálogos'),
              onTap: () {
                // Navegar a la pantalla de catálogos
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Pedidos'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/pedidos');
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Usuarios'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/usuarios');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/configuracion');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar sesión'),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
