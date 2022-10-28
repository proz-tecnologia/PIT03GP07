import 'package:flutter/material.dart';
import 'package:proz_project_finance/ui/pages/home/home_content_page.dart';
import 'package:proz_project_finance/ui/pages/home/widgets/floating_action.dart';
import 'package:proz_project_finance/ui/pages/trasactions/transactions_page.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageCurrent = 0;

  final contollerPage = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffe8f5ff),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: contollerPage,
          children: const [
            HomeContentPage(),
            TransactionsPage(),
          ],
        ),
        floatingActionButton: const FloatingButtonAnimate(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: StylishBottomBar(
          padding: const EdgeInsets.all(8.0),
          bubbleFillStyle: BubbleFillStyle.fill,
          barStyle: BubbleBarStyle.vertical,
          fabLocation: StylishBarFabLocation.center,
          opacity: 0.2,
          hasNotch: true,
          currentIndex: pageCurrent,
          items: [
            BubbleBarItem(
              backgroundColor: Colors.blueAccent,
              icon: const Icon(Icons.home_outlined),
              title: const  Text("Home",style: TextStyle(color: Colors.black)),
              activeIcon: const  Icon(Icons.home_outlined, color: Colors.black),
            ),
            BubbleBarItem(
              backgroundColor: Colors.blueAccent,
              icon: const Icon(Icons.list, color: Colors.black,),
              activeIcon: const Icon(Icons.list, color: Colors.black,),
              title: const Text("Transções", style: TextStyle(color: Colors.black))
            ),
          ],
          onTap: (value) {
            setState(() {
              pageCurrent = value!;
            });
            contollerPage.animateToPage(value!, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
          },
        )
      ),
    );
  }
}
