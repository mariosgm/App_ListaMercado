import 'package:tarefas_app/models/tarefa.model.dart';

class TarefaRepository {
  static List<Tarefa> tarefas = List<Tarefa>();

  void create(Tarefa tarefa) {
    tarefas.add(tarefa);
  }

  List<Tarefa> read(){
    List<Tarefa>selecionados = [];
    List<Tarefa>nselecionados = [];
    List<Tarefa>retorno = [];

    for (Tarefa x in tarefas){
      print(x.concluido);
      if (x.concluido == true){
        selecionados.add(x);
      }
      else{
        nselecionados.add(x);
      }
    }
    for(Tarefa x in nselecionados){
      retorno.add(x);
    }
     for(Tarefa x in selecionados){
      retorno.add(x);
    }
    
    
    return retorno;
  }

  void delete(String texto) {
    final tarefa = tarefas.singleWhere((t) => t.texto == texto);
    tarefas.remove(tarefa);
  }
  void update(Tarefa newTarefa, Tarefa oldTarefa) {
    final tarefa = tarefas.singleWhere((t) => t.texto == oldTarefa.texto);
    tarefa.texto = newTarefa.texto;
    tarefa.quantidade = newTarefa.quantidade;
  }
}
