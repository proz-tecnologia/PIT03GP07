import 'package:uuid/uuid.dart';

class Category {
  String id = const Uuid().v4();
  String name;

  Category({this.name = "Não definido"});
}
