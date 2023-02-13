import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:money/controllers/add_wishe.controller.dart';

import '../../../controllers/content.page.controller.dart';
import '../../components/custom_alert_dialog.component.dart';
import '../../components/progress_dialog.component.dart';

class AddNewWishe extends StatefulWidget {
  const AddNewWishe({super.key});

  @override
  State<AddNewWishe> createState() => _AddNewWisheState();
}

class _AddNewWisheState extends State<AddNewWishe> {
  final _controller = GetIt.instance.get<AddWisheController>();
  final _controllerContentPage = ContentPageController();

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

  final _formKey = GlobalKey<FormState>();

  var _value = 0.0;
  var _description = "";
  var _dateExpectedt = DateTime.now();
  final _dateinital = DateTime.now();

  final _txtDateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo desejo"),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: "pt_BR", decimalDigits: 2, symbol: '')
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: "Valor",
                      hintText: "0,00",
                      prefix: Text("R\$ "),
                      helperText: "No máximo 999.999,99.",
                      labelStyle: TextStyle(fontSize: 16)),
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Informe um valor.";
                    }
                    final valueDouble = double.parse(
                        value.replaceAll('.', '').replaceAll(',', '.'));
                    if (valueDouble == 0) {
                      return "Informe um valor diferente de 0";
                    }
                    return null;
                  },
                  onSaved: (newValue) => _value = double.parse(
                      newValue!.replaceAll('.', '').replaceAll(',', '.')),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Descrição",
                      labelStyle: TextStyle(fontSize: 16)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 20,
                  validator: (value) {
                    if (value!.length < 3 || value.length > 20) {
                      return "Campo deve ter ao menos 3 e no máximo 20 caractéres.";
                    }
                    return null;
                  },
                  onSaved: ((newValue) => _description = newValue!),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  controller: _txtDateTimeController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                      labelText: "Data que deseja alcançar o desejo",
                      labelStyle: TextStyle(fontSize: 16)),
                  maxLength: 10,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Informe uma data.";
                    }
                    return null;
                  },
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? date = await showDatePicker(
                        context: context,
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 360)),
                        lastDate: DateTime(2100),
                        initialDate: _dateExpectedt);
                    _dateExpectedt = date ?? _dateExpectedt;
                    _txtDateTimeController.text =
                        "${_dateExpectedt.day}/${_dateExpectedt.month}/${_dateExpectedt.year}";
                  },
                ),
              ],
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            _progressDialog.show("Salvando transação...");

            final result = await _controller.registerWishe(
                _value, _description, _dateExpectedt,_dateinital);

            _progressDialog.hide();

            if (result) {
              // ignore: use_build_context_synchronously
              Navigator.popAndPushNamed(context, "/content");
              _controllerContentPage.pageCurrent = 2;
            } else {
              _alertDialog.showInfo(
                  title: "Ops!",
                  message:
                      "Alguma falha aconteceu, tente novamente mais tarde!");
            }
          }
        },
      ),
    );
  }
}
