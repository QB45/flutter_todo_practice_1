import 'package:get/get.dart';

class RadioController extends GetxController {
  RxInt selected1Value = 1.obs; // Observable to track the selected radio button value
  RxInt selected2Value = 1.obs; // Observable to track the selected radio button value
  RxInt selected3Value = 1.obs; // Observable to track the selected radio button value
  RxInt selected4Value = 1.obs; // Observable to track the selected radio button value

  void setSelected1Value(int newValue) {
    selected1Value.value = newValue;
  }

  void setSelected2Value(int newValue) {
    selected2Value.value = newValue;
  }

  void setSelected3Value(int newValue) {
    selected3Value.value = newValue;
  }

  void setSelected4Value(int newValue) {
    selected4Value.value = newValue;
  }
}
