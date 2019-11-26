import 'package:app_vai/telas/showInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Andamento extends StatefulWidget {
  @override
  _AndamentoState createState() => _AndamentoState();
}

class _AndamentoState extends State<Andamento> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController resolucaoChamado = TextEditingController();

  // Firestore isAdm = Firestore.instance.document("users").snapshots().where("adm", isEqual).
  @override
  Widget build(BuildContext context) {
    String filtro;
    bool descc;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        PopupMenuButton<int>(

          itemBuilder: (context) => <PopupMenuEntry<int>>[
            PopupMenuItem<int>(
              child: Text("Titulo A-Z"),
              value: 1,
            ),
            PopupMenuItem<int>(
              child: Text("Titulo Z-A"),
              value: 2,
            ),
            PopupMenuItem<int>(
              child: Text("Data Asc"),
              value: 3,
            ),
            PopupMenuItem<int>(
              child: Text("Data Desc"),
              value: 4,
            ),
            PopupMenuItem<int>(
              child: Text("Prioridade Alta"),
              value: 5,
            ),
            PopupMenuItem<int>(
              child: Text("Prioridade Baixa"),
              value: 6,
            ),
          ],
          onSelected: (int resultado) {
            setState(() {
              switch (resultado) {
                case 1:
                  filtro = "titulo";
                  descc  = false;
                  break;
                case 2:
                  filtro = "titulo";
                  descc = true;
                  break;
                case 3:
                  filtro = "data";
                  descc = false;
                  break;
                case 4:
                  filtro = "data";
                  descc = true;
                  break;
//                case 5:
//                  filtro = Firestore.instance
//                      .collection("chamados")
//                      .orderBy("prioridade", descending: false);
//                  break;
//                case 6:
//                  filtro = Firestore.instance
//                      .collection("chamados").where("status", isEqualTo: 3)
//                      .orderBy("prioridade", descending: true);
//                  break;
              }
            });
          },
        ),
        Expanded(
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection("chamados")
                  .where("status", isEqualTo: 3)
                  .orderBy("titulo", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.done:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.data.documents.length == 0) {
                      return Center(
                        child: Text(
                          "Não há dados!",
                          style:
                              TextStyle(color: Colors.redAccent, fontSize: 20),
                        ),
                      );
                    }

                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        padding: EdgeInsets.only(
                            top: 5, left: 5, right: 5, bottom: 10),
                        itemBuilder: (context, index) {
                          return Card(
                              child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                    snapshot
                                        .data.documents[index].data["titulo"],
                                    style: TextStyle(fontSize: 25)),
                                subtitle: Text(
                                  snapshot
                                      .data.documents[index].data["prioridade"],
                                ),
                              ),
                              ButtonTheme.bar(
                                child: ButtonBar(
                                  children: <Widget>[
                                    OutlineButton(
                                      child: const Text('Finalizar'),
                                      onPressed: () => finalizarChamado(
                                          context, index, snapshot),
                                    ),
                                    OutlineButton(
                                      child: const Text('Pausar'),
                                      onPressed: () => pausarChamado(
                                          context, index, snapshot),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.info),
                                      onPressed: () =>
                                          showInfo(context, index, snapshot),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                        });
                }
              }),
        ),
      ],
    );
  }

  finalizarChamado(BuildContext context, index, snapshot) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                //  Firestore.instance.collection("chamados").getDocuments()
                snapshot.data.documents[index].data["titulo"]
                    .toString()
                    .toUpperCase()),
            content: Column(
              children: <Widget>[
                Text(snapshot.data.documents[index].data["descricao"]
                    .toString()),
                _resolucaoChamado("Resolução"),
              ],
            ),
            actions: <Widget>[
              //prioridade menu goes here
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Concluir'),
                onPressed: () {
                  snapshot.data.documents[index].data["chamados"].toString();
                  Firestore.instance
                      .collection("chamados")
                      .document(
                          snapshot.data.documents[index].documentID.toString())
                      .updateData({
                    "status": 4,
                    "resolucao": resolucaoChamado.text,
                  });
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  pausarChamado(BuildContext context, index, snapshot) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                //  Firestore.instance.collection("chamados").getDocuments()
                snapshot.data.documents[index].data["titulo"]
                    .toString()
                    .toUpperCase()),
            content: Column(
              children: <Widget>[
                Text(snapshot.data.documents[index].data["descricao"]
                    .toString()),
              ],
            ),
            actions: <Widget>[
              //prioridade menu goes here
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),

              FlatButton(
                child: Text('Concluir'),
                onPressed: () {
                  snapshot.data.documents[index].data["chamados"].toString();
                  Firestore.instance
                      .collection("chamados")
                      .document(
                          snapshot.data.documents[index].documentID.toString())
                      .updateData({
                    "status": 2,
                  });
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  _resolucaoChamado(String label) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: 10,
      decoration: InputDecoration(
          labelText: label, hintMaxLines: 10, border: OutlineInputBorder()),
      controller: resolucaoChamado,
      validator: (value) {
        if (value.isEmpty) {
          return "infome o título!";
        }
        return null;
      },
    );
  }

  resultadoFiltro(resultado) {
    switch (resultado) {
      case 1:
        Firestore.instance
            .collection("chamados")
            .orderBy("titulo", descending: false);
        break;
      case 2:
        Firestore.instance
            .collection("chamados")
            .orderBy("titulo", descending: true);
        break;
      case 3:
        Firestore.instance
            .collection("chamados")
            .orderBy("data", descending: false);
        break;
      case 4:
        Firestore.instance
            .collection("chamados")
            .orderBy("data", descending: true);
        break;
      case 5:
        Firestore.instance
            .collection("chamados")
            .orderBy("prioridade", descending: false);
        break;
      case 6:
        Firestore.instance
            .collection("chamados")
            .orderBy("prioridade", descending: true);
        break;
    }
  }
}
