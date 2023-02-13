import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:money/controllers/add_wishe.controller.dart';
import 'package:money/ui/components/card_default.dart';
import 'package:money/ui/pages/wishes/components/card_wishe.dart';

import '../../../stores/wishe.store.dart';
import '../../components/progress_dialog.component.dart';

class WishesPage extends StatefulWidget {
  const WishesPage({super.key});

  @override
  State<WishesPage> createState() => _WishesPageState();
}

class _WishesPageState extends State<WishesPage> {
  final _controllerWishestore = GetIt.instance.get<WisheStore>();
  final _controllerWishe = GetIt.instance.get<AddWisheController>();

  final _progressDialog = ProgressDialog();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preload());
  }

  Future preload() async {
    _progressDialog.show("Obtendo dados...");
    await _controllerWishe.getList();
    _progressDialog.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) => SizedBox(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Expanded(
                        child: Center(
                            child: Text("Desejos",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500)))),
                    IconButton(onPressed: _toAddWishe, icon: const Icon(Icons.add))
                  ],
                ),
                _controllerWishestore.list.isEmpty
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                                child: Text("Você não tem desejo cadastrado.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))),
                            Lottie.asset('assets/lottie/wishe2.json',
                                height: 150, width: 150),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _toAddWishe,
                              child: const Text(
                                "Adiconar um novo desejo",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          itemCount: _controllerWishestore.list.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    ),
                            itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CardMain(ListTile(
                                    title: CardWishe(_controllerWishestore.list[index]))
                                  ),
                            )),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _toAddWishe() {
    Navigator.pushNamed(context, '/add-wishe');
  }
}
