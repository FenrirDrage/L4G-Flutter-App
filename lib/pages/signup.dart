import 'package:flutter/material.dart';
import 'package:projeto/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //for JSONencode

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscurePassword = true;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> register() async {
    String apiUrl = 'https://backend-q4m5.onrender.com/register';

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Registro bem-sucedido
        print('Registro bem-sucedido');
        // Mostrar popup de sucesso
        showRegistrationSuccessPopup();
        // Prosseguir para a tela de login se desejado
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LogIn()),
        // );
      } else if (response.statusCode == 409) {
        // Erro de usuário duplicado
        print('Erro de usuário duplicado');
        // Mostrar popup com mensagem de erro
        showRegistrationErrorPopup(
            'Usuário duplicado. Por favor, use um e-mail diferente.');
      } else {
        // Um erro ocorreu
        print('Erro no registro');
        // Mostrar popup com mensagem de erro geral
        showRegistrationErrorPopup('Ocorreu um erro durante o registro.');
      }
    } catch (e) {
      print('Erro ao conectar-se à API: $e');
      // Mostrar popup com mensagem de erro de rede
      showRegistrationErrorPopup(
          'Erro ao conectar-se ao servidor. Por favor, tente novamente mais tarde.');
    }
  }

//Function to show a success pop-up
  void showRegistrationSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registro bem-sucedido'),
          content: Text("You have successfully sign in."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LogIn()));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showRegistrationErrorPopup(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF000B45), // 100%
              Color(0xFF000B45).withOpacity(0.75), // 75%
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome!',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF000B45),
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF000B45),
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                style: TextStyle(color: Colors.white),
                obscureText: _obscurePassword,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF000B45),
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 44.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Chamar a função de registro
                    await register();
                  } catch (e) {
                    // Lidar com erros de registro
                    print('Erro durante o registro: $e');
                    showRegistrationErrorPopup(
                        'Ocorreu um erro inesperado. Por favor, tente novamente.');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF000B45),
                  foregroundColor: Colors.white,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                child: Container(
                  height: 36,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('Sign Up'),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              Text(
                'Already have an account?',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFF000B45), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                child: Container(
                  height: 36,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Color(0xFF000B45)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
