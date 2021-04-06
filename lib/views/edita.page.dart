import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarefas_app/models/tarefa.model.dart';
import 'package:tarefas_app/repositories/tarefa.repository.dart';

class EditaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _tarefa = Tarefa();
  final _repository = TarefaRepository();



  onSave(BuildContext context, Tarefa tarefa) {


    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); 
      _repository.update(_tarefa, tarefa);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Tarefa tarefa = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Editar item"),
        centerTitle: true,     
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column (children: [
            TextFormField(
            initialValue: tarefa.texto,
            decoration: InputDecoration(
              labelText: "Descrição",
              border: OutlineInputBorder(
              ),
            ),
            onSaved: (value) => _tarefa.texto = value,
            validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
          ),
          Padding(padding: EdgeInsets.only(top:15)),
            TextFormField(
              inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              initialValue: tarefa.quantidade,
              decoration: InputDecoration(
                labelText: "Quantidade",
                border: OutlineInputBorder(
                ),
              ),
              onSaved: (value) => _tarefa.quantidade = value,
              validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
            ),
            Padding(padding: EdgeInsets.only(top:15)),
            TextButton(
                child: Text("Alterar", style: TextStyle(color: Colors.white),),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue[900])
              ),
              onPressed: () => onSave(context,tarefa),
            ),
          ],) 
        ),
      ),
    );
  }
}
