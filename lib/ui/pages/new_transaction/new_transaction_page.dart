// ignore_for_file: must_be_immutable

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proz_project_finance/controller/transaction_controller.dart';
import 'package:proz_project_finance/model/category.dart';
import 'package:proz_project_finance/model/transaction.dart';

class NewTransactionPage extends StatefulWidget {
  TransactionType transactionType;

  NewTransactionPage(this.transactionType, {super.key});

  @override
  State<NewTransactionPage> createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  final _formKey = GlobalKey<FormState>();

  get _transactionType => widget.transactionType;

  var _value = 0.0;

  var _description = "";

  Category? _category;

  var _dateTime = DateTime.now();

  final _txtDateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.transactionType == TransactionType.INCOME
            ? Colors.green
            : Colors.red,
        title: Text(widget.transactionType == TransactionType.INCOME
            ? "Nova receita"
            : " Nova despesa"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w700),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 24,
              ),

              Container(
                decoration:const  BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 218, 218, 218), width: 1))),
                child: Row(
                  children: [
                    Expanded(child: Icon(Icons.attach_money_outlined,color: Colors.grey[400],)),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 15,
                      child: TextFormField(
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
                            border: InputBorder.none
                          ),
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration:const  BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 218, 218, 218), width: 1))),
                child: Row(
                  children: [
                    Expanded(child: Icon(Icons.turned_in_not,color: Colors.grey[400])),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 15,
                      child: Consumer<TransactionController>(
                          builder: (context, transactionController, child) {
                        return DropdownButtonFormField<Category>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          items: transactionController.categories
                              .map((e) => DropdownMenuItem<Category>(
                                  value: e, child: Row(
                                    children: [
                                      CircleAvatar(backgroundColor: e.color,child: e.icon),
                                      SizedBox(width: 10,),
                                      Text(e.name),
                                    ],
                                  )))
                              .toList(),
                          value: _category,
                          onChanged: (newValue) => _category = newValue,
                          hint: const Text("Categoria"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null) {
                              return "Selecione uma categoria.";
                            }
                            return null;
                          },
                          onSaved: (newValue) => _category = newValue,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 218, 218, 218), width: 1))),
                child: Row(
                  children: [
                    Expanded(child: Icon(Icons.description_outlined, color: Colors.grey[400])),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 15,
                      child: TextFormField(
                        style: TextStyle(fontSize: 16),
                        decoration: const InputDecoration(labelText: "Descrição",border: InputBorder.none, labelStyle: TextStyle(fontSize: 16)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.length < 3 || value.length > 30) {
                            return "Campo deve ter ao menos 3 e no máximo 30 caractéres.";
                          }
                          return null;
                        },
                        onSaved: ((newValue) => _description = newValue!),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration:const  BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 218, 218, 218), width: 1))),
                child: Row(
                  children: [
                    Expanded(child: Icon(Icons.calendar_today_outlined, color: Colors.grey[400])),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 15,
                      child: TextFormField(
                        controller: _txtDateTimeController,
                        keyboardType: TextInputType.datetime,
                        decoration:
                            const InputDecoration(labelText: "Data da Operação",border: InputBorder.none),
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
                              lastDate: DateTime.now(),
                              initialDate: _dateTime);
                          _dateTime = date ?? _dateTime;
                          _txtDateTimeController.text =
                              "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}";
                        },
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final transaction = Transaction(
                      transactionType: _transactionType,
                      dateTime: _dateTime,
                      description: _description,
                      category: _category,
                      value: _value);
                  Provider.of<TransactionController>(context, listen: false)
                      .add(transaction);
                  Navigator.pop(context);
                }
        },
        child: Icon(Icons.check),
        backgroundColor: widget.transactionType == TransactionType.INCOME
            ? Colors.green
            : Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
