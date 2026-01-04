import 'package:flutter/material.dart';
import 'fs/item.dart';

class ListNotifier extends ChangeNotifier {
  List<Items> _i = List.empty(growable: true);
  List<Items> get todos => _i;


  void add(Items todo) {
    _i.add(todo);
    notifyListeners();
  }

  void changeDone(int index, bool targ){
    _i[index].done = targ;
    notifyListeners();
  }

  void deleteId(int index){
    _i.removeAt(index);
    notifyListeners();
  }

  int getAllYetTodo(){
    int x = 0;
    for(final n in _i){
      if(!n.done) x++;
    }
    return x;
  }

  void deleteAll(){
    _i = List.empty(growable: true);
    notifyListeners();
  }
}
