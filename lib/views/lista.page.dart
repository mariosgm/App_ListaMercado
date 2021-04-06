import 'package:flutter/material.dart';
import 'package:tarefas_app/main.dart';
import 'package:tarefas_app/models/tarefa.model.dart';
import 'package:tarefas_app/repositories/tarefa.repository.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final repository = TarefaRepository(); 

  List<Tarefa> tarefas;

  @override
  initState() {
    super.initState();
    this.tarefas = repository.read();
  }

  Future adicionarTarefa(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/pageAddItem');
    if (result == true) {
      setState(() {
        this.tarefas = repository.read();
      });
    }
  }

  Future<bool> confirmarExclusao(BuildContext context) async{
    return showDialog(
      context: context, 
      barrierDismissible: true,
      builder: (_){
        return AlertDialog(
          title: Text("Deseja realmente excluir esse item ?"),
          actions: [
            FlatButton(
              child: Text("NÃO"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              child: Text("SIM"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      }
    );
  }

  bool canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Lista de compras"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.edit),
          onPressed: () => setState(() => canEdit = !canEdit),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (_, indice) {
          var tarefa = tarefas[indice];
          return Dismissible(
            key: Key(tarefa.texto),
            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.red[500],
              child: Row(children:[Icon(Icons.delete, color: Colors.white,), Text("Excluir", style: TextStyle(color: Colors.white),)],),
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              color: Colors.red[500],
              child: Row(mainAxisAlignment: MainAxisAlignment.end, 
              children:[
                Icon(Icons.delete, color: Colors.white,), 
                Text("Excluir", style: TextStyle(color: Colors.white),), 
                Padding(padding: EdgeInsets.only(left:15))
              ],),
            ), 
            onDismissed: (direction) {
              if(direction == DismissDirection.startToEnd){
                repository.delete(tarefa.texto);
                setState(() => this.tarefas.remove(tarefa));
              }
              else if (direction == DismissDirection.endToStart){
              }
              repository.delete(tarefa.texto);
              setState(() {
                this.tarefas.remove(tarefa);
              });
            }, 
            confirmDismiss: (_) => confirmarExclusao(context), 
            child: CheckboxListTile(
              activeColor: Colors.red,
              title: Row(
                children: [
                  canEdit 
                  ? IconButton(icon: Icon(Icons.edit), onPressed: () async { var result = await Navigator.of(context).pushNamed(
                    '/pageEditar',
                    arguments: tarefa,
                    );
                    if (result) {
                      setState(() => this.tarefas = repository.read());
                    }
                  })
                  : Container(),
                  Text(
                    tarefa.texto,
                    style: TextStyle(
                      color: tarefa.concluido
                          ? Colors.red
                          : Colors.black
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left:15)),
                  Text(
                    tarefa.quantidade,
                    style: TextStyle(
                      color: tarefa.concluido
                          ? Colors.red
                          : Colors.black
                    ),
                  ),
                ],
              ),
              value: tarefa.concluido, 
              onChanged: (value) {
                setState(() { tarefa.concluido = value;});
                setState(() { this.tarefas = repository.read();});
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.add_shopping_cart_sharp, ),
        onPressed: () => adicionarTarefa(context),
      ),
    );
  }
}
