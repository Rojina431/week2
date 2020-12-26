import 'package:get/get.dart';

class MovieController extends GetxController {
  int _pageno = 1;
  int get pageno => _pageno;
  updatePageNo() {
    _pageno++;
  }
}
