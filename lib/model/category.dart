import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Category {
  String id = const Uuid().v4();
  String name;
  Color color;
  Icon icon;

  Category({required this.name, required this.color, required this.icon});
}
