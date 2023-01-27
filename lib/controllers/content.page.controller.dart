import 'package:mobx/mobx.dart';

part 'content.page.controller.g.dart';

class ContentPageController = ContentPageControllerBase with _$ContentPageController;

abstract class ContentPageControllerBase with Store {
  @observable
  int pageCurrent = 0;

  @action
  setPage(int value){
    pageCurrent = value;
  }
  
}