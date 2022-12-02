import 'package:belt/components/container_card.dart';
import 'package:belt/controller/transactions.controller.dart';
import 'package:belt/ui/pages/home/widget/balance.dart';
import 'package:belt/ui/pages/home/widget/card_graphics.dart';
import 'package:belt/ui/pages/home/widget/cards_incoming_outcoming.dart';
import 'package:belt/ui/pages/home/widget/container_empaty.dart';
import 'package:belt/ui/pages/home/widget/progress_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// ignore: must_be_immutable
class HomeContentPage extends StatefulWidget {
  HomeContentPage({required this.controller, super.key});
  TransactionController controller;

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  bool isVisibility = true;

  void changedVisibility() {
    setState(() {
      isVisibility = !isVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Observer(
        builder: (_) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(
                      30,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    BalanceValue(
                      value: widget.controller.totalBalance,
                      isVisibility: isVisibility,
                    ),
                    IconButton(
                        onPressed: changedVisibility,
                        icon: Icon(
                          isVisibility ? Icons.visibility_off : Icons.visibility,
                          size: 25,
                        )),
                    const SizedBox(height: 10),
                    CardsIncomingOutcoming(
                      icoming: widget.controller.getTotalIncoming,
                      outcoming: widget.controller.getTotalOutcoming,
                      isVisibility: isVisibility,
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
              const SizedBox(height: 40),
              widget.controller.isLoading
                  ? const Expanded(child: ProgressContainer())
                  : widget.controller.transactions.isEmpty
                      ? const Expanded(child: ContainerEmpaty())
                      : ContainerCard(child: CardChart(transaction: widget.controller.getListCategoryValue,totalOutcoming: widget.controller.getTotalOutcoming,),)
            ],
          ),
        ),
      ),
    );
  }
}
