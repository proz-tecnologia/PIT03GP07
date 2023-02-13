import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:money/controllers/content.page.controller.dart';
import 'package:money/ui/pages/home/home.page.dart';
import 'package:money/ui/pages/transactions/transactions.page.dart';
import 'package:money/ui/pages/wishes/wishes.page.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final _controller = ContentPageController();

  final controllerPage = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Observer(
          builder: (_) => PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controllerPage,
            children: const [HomePage(), TransactionsPage(), WishesPage()],
          ),
        ),
        bottomNavigationBar: Observer(
          builder: (_) => StylishBottomBar(
            currentIndex: _controller.pageCurrent,
            padding: const EdgeInsets.all(10),
            fabLocation: StylishBarFabLocation.center,
            barStyle: BubbleBarStyle.vertical,
            hasNotch: true,
            inkEffect: true,
            items: [
              BubbleBarItem(
                backgroundColor: Colors.white,
                icon: const Icon(Icons.home_outlined),
                title:
                    const Text("home", style: TextStyle(color: Colors.black)),
                activeIcon: const Icon(Icons.home, color: Colors.black),
              ),
              BubbleBarItem(
                  backgroundColor: Colors.white,
                  icon: const Icon(Icons.list_outlined, color: Colors.black),
                  activeIcon: const Icon(Icons.list, color: Colors.black),
                  title: const Text("Transações",
                      style: TextStyle(color: Colors.black))),
              BubbleBarItem(
                  backgroundColor: Colors.white,
                  icon: const Icon(Icons.favorite_border, color: Colors.black),
                  activeIcon: const Icon(Icons.favorite, color: Colors.black),
                  title: const Text("Desejos",
                      style: TextStyle(color: Colors.black)))
            ],
            onTap: (value) {
              _controller.setPage(value!);
              controllerPage.animateToPage(
                value,
                duration: const Duration(microseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          direction: SpeedDialDirection.up,
          children: [
            SpeedDialChild(
              backgroundColor: Colors.red,
              label: "Nova despesa",
              child: const Icon(Icons.arrow_downward_outlined,
                  color: Colors.white),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, "/add-expense"),
            ),
            SpeedDialChild(
              backgroundColor: Colors.green,
              label: "Nova receita",
              child:
                  const Icon(Icons.arrow_upward_outlined, color: Colors.white),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, "/add-income"),
            ),
            SpeedDialChild(
              backgroundColor: Colors.blue,
              label: "Novo desejo",
              child:
                  const Icon(Icons.favorite_border, color: Colors.white),
              onTap: () =>
                  Navigator.pushNamed(context, '/add-wishe'),
            ),
          ],
        ));
  }
}
