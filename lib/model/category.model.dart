import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Category {
  String id = const Uuid().v4();
  String name = '';
  Color? color;
  Icon? icon;
  double value = 0.0;

  Category({this.name = '', this.value = 0.0 ,this.color, this.icon});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    icon = json['icon'];
    icon = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['icon'] = icon;
    data['value'] = icon;
    return data;
  }

  @override
  String toString() {
    return "categorias $value";
  }
}