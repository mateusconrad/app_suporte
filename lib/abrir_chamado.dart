import 'package:flutter/material.dart';

class AbrirChamado extends StatefulWidget {
  @override
  _AbrirChamadoState createState() => _AbrirChamadoState();
}

class _AbrirChamadoState extends State<AbrirChamado> {
  var _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Abrir Chamado"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 350,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _sizedBox(30, 30),
                _textoChamado("Título"),
                _sizedBox(15, 15),
                _textoDescr("Descrição"),
                _sizedBox(0, 20),
                Row(
                  children: <Widget>[
                    _sizedBox(1, 15),
                    Text(
                      "Prioridade: ",
                    ),
                    _sizedBox(10, 10),
                    _prioridadeMenu(),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _sizedBox(1, 15),
                    Text("Classificação"),
                    _sizedBox(10, 10),

                    DropdownButton<String>(
                      items: [
                        DropdownMenuItem<String>(
                          value: "1",
                          child: Text(
                            "Hardware",
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "2",
                          child: Text(
                            "Software",
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "3",
                          child: Text(
                            "Rede",
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "4",
                          child: Text(
                            "Impressoras",
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "5",
                          child: Text(
                            "Telefonia",
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                      value: _value,
                      elevation: 2,
                      //style: TextStyle(color: Colors.black, fontSize: 30),
                      //isDense: true,
                      iconSize: 40.0,
                    ),
                  ],
                ),

            Row(
              children: <Widget>[
                Flexible(
                    flex: 2, child: _botaoAbrirChamado("Cancelar", Colors.red)),
                Flexible(flex: 1, child: _sizedBox(15, 0)),
                Flexible(flex: 2,
                    child: _botaoAbrirChamado("Concluir", Colors.indigo)),
              ],
            ),
            ],
          ),
        ),
      ),
    ),);
  }


  RaisedButton _botaoAbrirChamado(String text, Color cor) {
    return RaisedButton(
      child: Text(text),
      color: cor,
      onPressed: () {
        return AlertDialog(
          title: Text("certeza??"),
          content: Text("certoo"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  SizedBox _sizedBox(double largura, double altura) =>
      SizedBox(
        height: altura,
        width: largura,
      );

  TextFormField _textoChamado(String label) {
    return TextFormField(
      decoration:
      InputDecoration(labelText: label, border: OutlineInputBorder()),
    );
  }

  TextField _textoDescr(String label) {
    return TextField(
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: 10,
      decoration: InputDecoration(
          labelText: label, hintMaxLines: 10, border: OutlineInputBorder()),
    );
  }

  DropdownButton _prioridadeMenu() =>
      DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            value: "1",
            child: Text(
              "Baixa",
            ),
          ),
          DropdownMenuItem<String>(
            value: "2",
            child: Text(
              "Média",
            ),
          ),
          DropdownMenuItem<String>(
            value: "3",
            child: Text(
              "Alta",
            ),
          ),
          DropdownMenuItem<String>(
            value: "4",
            child: Text(
              "Crítica",
            ),
          ),
        ],

        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
        elevation: 2,
        //style: TextStyle(color: Colors.black, fontSize: 30),
        //isDense: true,
        iconSize: 40.0,
      );
}

//cor vermelho abase(169, 36, 37)
//cor azul abase (62, 64, 149)