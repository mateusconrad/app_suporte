import 'package:flutter/material.dart';

class Espera extends StatefulWidget {
  @override
  _EsperaState createState() => _EsperaState();
}

class _EsperaState extends State<Espera> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.album),
                  title: Text('Teclado Estragado'),
                  subtitle: Text('Teclado parou de funcionar'),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    children: <Widget>[
                      OutlineButton(
                        child: const Text('Finalizar'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      OutlineButton(
                        child: const Text('Atender'),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.album),
                  title: Text('Teclado Estragado'),
                  subtitle: Text('Teclado parou de funcionar'),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    children: <Widget>[
                      OutlineButton(
                        child: const Text('Finalizar'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      OutlineButton(
                        child: const Text('Atender'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}