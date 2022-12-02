import 'package:belt/components/alert_transaction_dialog.component.dart';
import 'package:belt/components/progress_dialog.component.dart';
import 'package:belt/controller/category.controller.dart';
import 'package:belt/controller/transactions_form.controller.dart';
import 'package:belt/model/category.model.dart';
import 'package:belt/model/transaction.model.dart';
import 'package:belt/repository/category.repository_impl.dart';
import 'package:belt/repository/transaction.repository_impl.dart';
import 'package:belt/service/api.service.dart';
import 'package:belt/ui/pages/newTransaction/widget/container.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// ignore: must_be_immutable
class NewTransaction extends StatefulWidget {
  NewTransaction(this.transactionType, {super.key});
  TransactionType transactionType;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _controller =
      TransactionFormController(TransactionRepositoryImpl(APIService()));
  final _controllerCategory =
      CategoryController(CategoryRepositoryImpl(APIService()));

  final _formKey = GlobalKey<FormState>();

  late final BuildContext _context;
  late final AlertTransactionDialog _alertTransactionDialog;
  late final ProgressDialog _progressDialog;

  final _txtDateTimeController = TextEditingController();
  var _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _controller.saveTransactionType(widget.transactionType);
    _context = context;
    _alertTransactionDialog = AlertTransactionDialog(context);
    _progressDialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.transactionType == TransactionType.INCOME
            ? const Text("Nova receita")
            : const Text("Nova despesa"),
        backgroundColor: widget.transactionType == TransactionType.INCOME
            ? Colors.green
            : Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ContainerWidget(
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money_outlined,
                        color: Colors.grey[400],
                        size: 25,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: _controller.validateValue,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: _controller.saveValue,
                          inputFormatters: [
                            CurrencyTextInputFormatter(
                                locale: "pt_BR", decimalDigits: 2, symbol: '')
                          ],
                          decoration: const InputDecoration(
                              labelText: "Valor",
                              hintText: "0,00",
                              prefix: Text("R\$ "),
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                ContainerWidget(Row(
                  children: [
                    Icon(
                      Icons.description_outlined,
                      color: Colors.grey[400],
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        validator: _controller.validateDescription,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: _controller.saveDescription,
                        decoration:
                          const InputDecoration(border: InputBorder.none, labelText: "Descrição"),
                      ),
                    ),
                  ],
                )),
                ContainerWidget(Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey[400],
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _txtDateTimeController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                            labelText: "Data da Operação",
                            border: InputBorder.none),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: _controller.validateDate,
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
                          _controller.saveData(date.toString());
                        },
                        
                      ),
                    ),
                  ],
                )),
                ContainerWidget(Row(
                  children: [
                    Icon(
                      Icons.turned_in_not,
                      color: Colors.grey[400],
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Observer(
                        builder: (_) => DropdownButtonFormField<Category>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          items: _controllerCategory.categorys
                              .map((e) => DropdownMenuItem<Category>(
                                    value: e,
                                    child: Text(e.name),
                                  ))
                              .toList(),
                          hint: const Text("Categoria"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: _controller.validateSelect,
                          onChanged: (value) => _controller.saveCategory(value!),
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: save,
        backgroundColor: widget.transactionType == TransactionType.INCOME
            ? Colors.green
            : Colors.red,
        child: const Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void save() async {
    if (_formKey.currentState!.validate()) {
      _progressDialog.show();

      _formKey.currentState!.save();
      final response = await _controller.save();

      _progressDialog.hide();
      
      if (response.isSuccess) {
        _alertTransactionDialog.show(
          title: "Cadastrado com sucesso",
          message: "Sucesso",
        );
        await Future.delayed(const Duration(milliseconds: 1300));
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(_context, '/home', (route) => false);
      } else {
        _alertTransactionDialog.showInfo(
            title: "Não foi :(", message: "Erro no servidor");
      }
    }
  }
}
