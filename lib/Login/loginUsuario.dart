import 'package:app_vai/Login/loginAtendente.dart';
import 'package:app_vai/drawer/TilesTelas/registrarUsuario.dart';
import 'package:app_vai/drawer/userDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../homeAtendente.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUsuario extends StatefulWidget {
  @override
  _LoginUsuarioState createState() => _LoginUsuarioState();
}

class _LoginUsuarioState extends State<LoginUsuario> {

  final String title = "login";
  TextStyle style = TextStyle(fontSize: 20.0);

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _authusuario = FirebaseAuth.instance;

  Future<FirebaseUser> _signInWithGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser userDetails =
        (await _authusuario.signInWithCredential(credential));
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
    print("Nome " + userDetails.displayName + "\n");
    print("Email " + userDetails.email + "\n");
    print("Photo URL" + userDetails.photoUrl + "\n");

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    // ignore: unused_local_variable
    UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );

    // ignore: unused_local_variable
    final user = UserDetails;
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => new TabBarHome(), //userDetails: details
      ),
    );
    return userDetails;
  }

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
              _logoAbase(),
              tituloApp(),
              MaterialButton(
                child: Text("Login Atendente"),
                color: Colors.indigo,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginAtendente()));
                },
              ),
              botaoLoginUsuario()
            ],
          ),
        ),
      ),
    ));
  }

  TextFormField formSenhaAtendente(BuildContext context) {
    return TextFormField(
      focusNode: focusSenhaUsuario,
      autofocus: true,
      obscureText: true,
      textInputAction: TextInputAction.next,
      validator: (valor) {
        if (valor.isEmpty) {
          FocusScope.of(context).requestFocus(focusSenhaUsuario);
          return "Informe a senha";
        }
        return null;
      },
      decoration: InputDecoration(labelText: "Senha", icon: Icon(Icons.lock)),
      keyboardType: TextInputType.text,
      controller: senhaUsuario,
    );
  }

  TextFormField formLoginAtendente(BuildContext context) {
    return TextFormField(
      validator: (valor) {
        if (valor.isEmpty) {
          FocusScope.of(context).requestFocus(focusNomeUsuario);
          return "Informe o nome";
        }
        return null;
      },
      decoration:
          InputDecoration(labelText: "Usuário", icon: Icon(Icons.people)),
      keyboardType: TextInputType.text,
      controller: nomeUsuario,
    );
  }

  Text tituloApp() {
    return Text(
      "Help Task",
      style: TextStyle(
        fontSize: 24,
      ),
    );
  }

  GoogleSignInButton botaoLoginUsuario() {
    return GoogleSignInButton(
      text: "Login Usuário",
      onPressed: () => _signInWithGoogle()
          .then((FirebaseUser user) => print(user))
          .catchError((e) => print(e)),
    );
  }

  SizedBox _sBox() => SizedBox(height: 100);

  ClipRRect _logoAbase() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(
          "images/abase.jpg",
          height: 200,
        ));
  }
}