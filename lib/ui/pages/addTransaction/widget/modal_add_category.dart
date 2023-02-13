import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../controllers/add_category.controller.dart';
import '../../../components/custom_alert_dialog.component.dart';
import '../../../components/progress_dialog.component.dart';

// ignore: must_be_immutable
class ModaAddlCategory extends StatelessWidget {
  ModaAddlCategory({super.key, required this.transactiontype});
  String transactiontype;

  final _controllerCategory = GetIt.instance.get<AddCategoryController>();

  final _progressDialog = ProgressDialog();

  final _alertDialog = CustomAlertDialog();

  var _nameCtaegory = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Cadastrar Categoria",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Categoria"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.length < 3 || value.length > 20) {
                  return "Campo deve ter ao menos 3 e no máximo 20 caractéres.";
                }
                return null;
              },
              onChanged: (newValue) => _nameCtaegory = newValue,
            ),
            ElevatedButton(
                onPressed: () async {
                    _progressDialog.show("Salvando categoria...");

                    final result =
                        await _controllerCategory.registerTransaction(
                            _nameCtaegory, transactiontype);

                    _progressDialog.hide();

                    if (result) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    } else {
                      _alertDialog.showInfo(
                          title: "Ops!",
                          message:
                              "Alguma falha aconteceu, tente novamente mais tarde!");
                    }
                    
                },
                child: const Text("Cadastrar", style: TextStyle(fontSize: 18)))
          ],
        ),
      ),
    );
  }
}
