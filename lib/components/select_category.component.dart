import 'package:belt/controller/category.controller.dart';
import 'package:belt/model/category.model.dart';
import 'package:belt/repository/category.repository_impl.dart';
import 'package:belt/service/api.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SelectCategory extends StatelessWidget {
  SelectCategory({super.key});

  final _controller = CategoryController(CategoryRepositoryImpl(APIService()));

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) => DropdownButtonFormField<Category>(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      items: _controller.categorys
          .map((e) => DropdownMenuItem<Category>(
              value: e,
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: e.color, child: e.icon),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(e.name),
                ],
              )))
          .toList(),
      value: _controller.categorys.first,
      hint: const Text("Categoria"),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null) {
          return "Selecione uma categoria.";
        }
        return null;
      },
      onChanged: (value) => print(value),
    ));
  }
}
