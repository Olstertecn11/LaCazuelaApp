import 'package:flutter/material.dart';
import 'package:lacazuela_mobile/helpers/handle_request.dart';
import 'package:lacazuela_mobile/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  Future<void> _login(BuildContext context)async{
    final correo = emailController.text;
    final String contrasenia = passwordController.text;

    final result = await HandleRequest.request(() => api.post('/login', data: {'correo': correo, 'contrasenia': contrasenia}));

    // i need print the result
    print(result);

    // check if email or password are empty
    if(correo.isEmpty || contrasenia.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, completa todos los campos')));
      return;
    }

    if(result['status'] == 200){
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', result['data']['token']);
      Navigator.pushReplacementNamed(context, '/home');
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['error']['message'] ?? 'Error al iniciar sesión')));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212), // Fondo oscuro
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E), // Fondo oscuro del contenedor
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDBA800), // Color dorado para el título
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  filled: true,
                  fillColor: Color(0xFF2A2A2A), // Color oscuro de fondo para el input
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  filled: true,
                  fillColor: Color(0xFF2A2A2A), // Color oscuro para el input
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()=>_login(context),
                child: Text('Ingresar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDBA800), // Color dorado para el botón
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
