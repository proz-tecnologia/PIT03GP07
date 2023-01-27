import 'package:mobx/mobx.dart';

part 'home.controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {

  @observable
  bool _isVisibility = true;

  bool get isVisibility => _isVisibility;

  @action
  setVisivibility() {
    _isVisibility = !_isVisibility;
  }
}