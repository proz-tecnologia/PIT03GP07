import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String get toBRL {
    return NumberFormat.currency(locale: 'pt_BR', symbol: "R\$").format(this);
  }
}
