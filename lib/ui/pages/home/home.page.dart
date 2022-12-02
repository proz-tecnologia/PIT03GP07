import 'package:belt/components/floating_action_button.dart';
import 'package:belt/controller/transactions.controller.dart';
import 'package:belt/repository/transaction.repository_impl.dart';
import 'package:belt/service/api.service.dart';
import 'package:belt/ui/pages/home/home_content.page.dart';
import 'package:belt/ui/pages/transactions/transactions.page.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageCurrent = 0;
  bool isVisibility = true;

  final controllerPage = PageController();

  final _controller = TransactionController(TransactionRepositoryImpl(APIService()));

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controllerPage,
        children: [ HomeContentPage(controller: _controller,),TransactionsPage(controller: _controller,)],
      ),
      bottomNavigationBar: StylishBottomBar(
        padding: const EdgeInsets.all(8),
        fabLocation: StylishBarFabLocation.center,
        bubbleFillStyle: BubbleFillStyle.fill,
        barStyle: BubbleBarStyle.vertical,
        currentIndex: pageCurrent,
        hasNotch: true,
        items: [
          BubbleBarItem(
            backgroundColor: Colors.blueAccent,
            icon: const Icon(Icons.home_outlined),
            title: const Text("home", style: TextStyle(color: Colors.black)),
            activeIcon: const Icon(Icons.home_outlined, color: Colors.black),
          ),
          BubbleBarItem(
              backgroundColor: Colors.blueAccent,
              icon: const Icon(Icons.list, color: Colors.black),
              activeIcon: const Icon(Icons.list, color: Colors.black),
              title: const Text("Transações",
                  style: TextStyle(color: Colors.black)))
        ],
        onTap: (value) {
          setState(() {
            pageCurrent = value!;
          });
          controllerPage.animateToPage(value!, 
          duration: const Duration(microseconds: 200), curve: Curves.easeInOut,);
        },
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isVisibility ? const FloatingButtonAnimate() : null,
    );
  }
}