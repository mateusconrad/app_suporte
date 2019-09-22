
import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String title = "login";
  TextStyle style = TextStyle(fontSize: 20.0);

  final _cLogin = TextEditingController();
  final _cPassw = TextEditingController();
  IconData iconField;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100),
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "images/abase.jpg",
                    height: 200,
                  )),
              SizedBox(height: 50),
              _widgetText(iconField = Icons.person, "login", "Digite o usuário",
                  controller: _cLogin),
              SizedBox(height: 15.0),
              _widgetText(
                iconField = Icons.vpn_key,
                "Senha",
                "Digite a senha",
                password: true,
                controller: _cPassw,
              ),
              SizedBox(height: 45.0),
              _loginButton(context, "Login"),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Material _loginButton(BuildContext context, String label) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.tealAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TabBarHome()));
        },
        child: Text(
          label,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  TextFormField _widgetText(IconData iconField, String label, String hint,
      {bool password = false, TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        prefixIcon: Icon(iconField),
        labelText: label,
        hintText: hint,
      ),
    );
  }
}
//////////////////////
//              TextFormField(
//                obscureText: true,
//                controller: _cPassw,
//              ),
