import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import '/controllers/add_transaction.controller.dart';
import '/models/category.model.dart';
import '/ui/components/custom_alert_dialog.component.dart';
import '/ui/components/progress_dialog.component.dart';
import '/ui/pages/addTransaction/widget/modal_add_category.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../stores/category.store.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key, required this.transactionType});
  final String transactionType;

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _controller = GetIt.instance.get<AddTransactionController>();
  final _categoryStore = GetIt.instance.get<CategoryStore>();

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

  final _formKey = GlobalKey<FormState>();

  var _value = 0.0;
  var _description = "";
  var _dateTime = DateTime.now();
  var _category = "";

  final _txtDateTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.transactionType == "INCOME" ? Colors.green : Colors.red,
          title: Text(widget.transactionType == "INCOME"? "Nova receita" : "Nova despesa", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
          titleTextStyle: const TextStyle(color: Colors.white),
          leading: IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "/home");
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: widget.transactionType == "INCOME" ? Colors.green : Colors.red,
          child: const Icon(Icons.check),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              _progressDialog.show("Salvando transação...");

              final result = await _controller.registerTransaction(
                  _value,
                  _description,
                  _dateTime,
                  Category(
                      name: _category, typeTransaction: widget.transactionType),
                  widget.transactionType);

              _progressDialog.hide();

              if (result) {
                Navigator.pop(context);
              } else {
                _alertDialog.showInfo(
                    title: "Ops!",
                    message:
                        "Alguma falha aconteceu, tente novamente mais tarde!");
              }
            }
          },
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
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
                        helperText: "No máximo 999.999,99."),
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
                    decoration: const InputDecoration(labelText: "Descrição"),
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
                    decoration:
                        const InputDecoration(labelText: "Data da Operação"),
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
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 360)),
                          lastDate: DateTime.now(),
                          initialDate: _dateTime);
                      _dateTime = date ?? _dateTime;
                      _txtDateTimeController.text =
                          "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}";
                    },
                  ),
                  DropdownButtonFormField(
                      hint: const Text("Selecione uma categoria"),
                      items: _categoryStore.list.isEmpty
                          ? null
                          : _categoryStore.list
                              .where((e) =>
                                  e.typeTransaction == widget.transactionType)
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.name)))
                              .toList(),
                      onChanged: (value) => _category = value!.name),
                  ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0))),
                            context: context,
                            builder: (context) => ModaAddlCategory(
                                transactiontype: widget.transactionType));
                      },
                      child: const Text("Cadastrar categoria"))
                ],
              ),
            )));
  }
}
