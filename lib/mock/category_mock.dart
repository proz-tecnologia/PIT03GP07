import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:proz_project_finance/model/category.dart';

abstract class CategoryMock {
  static List<Category> getCategories() {
    return [ 
      Category(name: "Alimentação", color: Colors.amber, icon: Icon(Icons.restaurant, color: Colors.black54)),
      Category(name: "Transporte", color: Colors.blueAccent, icon: Icon(Icons.train_outlined,color: Colors.black54)),
      Category(name: "Educação", color: Colors.greenAccent, icon: Icon(Icons.menu_book_sharp, color: Colors.black54)),
      Category(name: "Jogos", color: Colors.yellow, icon: Icon(Icons.games_outlined, color: Colors.black54)),
    ];
  }
}
