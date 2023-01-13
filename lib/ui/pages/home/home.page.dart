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

  final _controller =
      TransactionController(TransactionRepositoryImpl(APIService()));

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.blue,
              child: Image.network(
                "https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large",
                fit: BoxFit.cover,
              )),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controllerPage,
        children: [
          HomeContentPage(
            controller: _controller,
          ),
          TransactionsPage(
              _controller.getAllTransaction, _controller.totalBalance)
        ],
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
            backgroundColor: Colors.white,
            icon: const Icon(Icons.home_outlined),
            title: const Text("home", style: TextStyle(color: Colors.black)),
            activeIcon: const Icon(Icons.home, color: Colors.black),
          ),
          BubbleBarItem(
              backgroundColor: Colors.white,
              icon: const Icon(Icons.list_outlined, color: Colors.black),
              activeIcon: const Icon(Icons.list, color: Colors.black),
              title: const Text("Transações",
                  style: TextStyle(color: Colors.black)))
        ],
        onTap: (value) {
          setState(() {
            pageCurrent = value!;
          });
          controllerPage.animateToPage(
            value!,
            duration: const Duration(microseconds: 200),
            curve: Curves.easeInOut,
          );
        },
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isVisibility ? const FloatingButtonAnimate() : null,
    );
  }
}
