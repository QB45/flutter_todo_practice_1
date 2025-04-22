import 'package:flutter/material.dart';
import 'package:flutter_todo_practice_1/main.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../controllers/radio_controller.dart';

class SettingScreen extends StatelessWidget {
  final RadioController radioController = Get.put(RadioController());
  final theSortBox = Hive.box(sortBoxName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.all(8.0), child: Text('Sorting method:')),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                width: double.infinity,
                child: Flex(
                  direction: Axis.horizontal,

                  children: [
                    Flexible(
                      flex: 1,
                      child: GetX<RadioController>(
                        init: RadioController(),
                        initState: (_) {},
                        builder: (_) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [radio1(1), Text('By Date')]),
                              Row(children: [radio1(2), Text('By Priority')]),
                            ],
                          );
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: GetX<RadioController>(
                        init: RadioController(),
                        initState: (_) {},
                        builder: (_) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [radio2(1), Text('Ascending')]),
                              Row(children: [radio2(2), Text('Descending')]),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Radio<int> radio1(int radioButtonIndex) {
    return Radio(
      value: radioButtonIndex,
      groupValue: radioController.selected1Value.value,
      onChanged: (int? newValue) {
        radioController.setSelected1Value(newValue!);
        theSortBox.put('sortBy', radioController.selected1Value.value);
      },
    );
  }

  Radio<int> radio2(int radioButtonIndex) {
    return Radio(
      value: radioButtonIndex,
      groupValue: radioController.selected2Value.value,
      onChanged: (int? newValue) {
        radioController.setSelected2Value(newValue!);
        theSortBox.put('sortMode', radioController.selected2Value.value);
      },
    );
  }
}
