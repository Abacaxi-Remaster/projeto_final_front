import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import "../all.dart";

class DetalheVaga extends StatefulWidget {
  @override
  State<DetalheVaga> createState() => _DetalheVagaState();
}

class _DetalheVagaState extends State<DetalheVaga> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Vaga vaga = appState.vagaAtual;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(vaga.tituloVaga),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Descrição: ${vaga.descricao}',
                    style: TextStyle(fontSize: 20)),
                Text('Requisitos: ${vaga.requisitos}',
                    style: TextStyle(fontSize: 15)),
                Text('Salário: ${vaga.salario}',
                    style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text('Inscritos:', style: TextStyle(fontSize: 30)),
          ),
          /*for (var inscritos in appState.ins) ...[
            ListTile(
              style: Theme.of(context).listTileTheme.style,
              title: Text(inscritos),
              subtitle: Text(vaga.descricao),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
            ),
          ]*/
          ListaInscritos(),
        ],
      ),
    );
  }
}

class ListaInscritos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return FutureBuilder<List<String>>(
      future: getInscritos(appState.vagaAtual.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Display an error message if data retrieval fails
        } else {
          List<String>? inscritos = snapshot.data;

          return Column(
            children: [
              for (var aluno in inscritos!)
                ListTile(
                  leading: Icon(Icons.face),
                  title: Text(aluno),
                ),
            ],
          );
        }
      },
    );
  }
}
