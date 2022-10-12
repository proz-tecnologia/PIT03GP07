import 'package:flutter/cupertino.dart';
import 'package:proz_project_finance/ui/components/account_balance.dart';
import 'package:proz_project_finance/ui/components/movement_value.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      decoration:const BoxDecoration(
        color: Color(0xff1E90FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(
            20,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:const [
          AccontBalance(),
        ],
      ),
    );
  }
}
