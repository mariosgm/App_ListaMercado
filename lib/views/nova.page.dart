import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarefas_app/models/tarefa.model.dart';
import 'package:tarefas_app/repositories/tarefa.repository.dart';

class NovaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _tarefa = Tarefa();
  final _repository = TarefaRepository();

  onSave(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); 
      _repository.create(_tarefa);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Colocar um novo produto na lista"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
              TextFormField(
              decoration: InputDecoration(
              labelText: "Descrição",
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => _tarefa.texto = value,
            validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
          ),
          Padding(padding: EdgeInsets.only(top:15)),
          TextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
              labelText: "Quantidade",
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => _tarefa.quantidade = value,
            validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
          ),
          Padding(padding: EdgeInsets.only(top:15)),
          TextButton(
                
                child: Text("Adicionar", style: TextStyle(color: Colors.white),),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue[900])
              ),
              onPressed: () => onSave(context),
            ),
        ],
        ),
        ) 
      ),
    );
  }
}
