import 'package:flutter/material.dart';
import '../components/my_styles.dart';
import '../controllers/checkbox_controller.dart';
import 'package:flutter_todo_practice_1/main.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../controllers/radio_controller.dart';
import '../controllers/task_controller.dart';

class SettingScreen extends StatelessWidget {
  final TaskController taskController = Get.find();
  final RadioController radioController = Get.find();
  final CheckboxController checkboxController = Get.find();
  final theSettingBox = Hive.box(settingBoxName);

  SettingScreen({super.key});

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sorting method:', style: txs16),
              ),
              // SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Flex(
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
                                  radio3(1, Text('By Date', style: txs12)),
                                  radio3(2, Text('By Priority', style: txs12)),
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
                                  radio4(1, Text('Ascending', style: txs12)),
                                  radio4(2, Text('Descending', style: txs12)),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    GetX<CheckboxController>(
                      init: CheckboxController(),
                      initState: (_) {},
                      builder: (_) {
                        return SizedBox(
                          child: CheckboxListTile(
                            value: checkboxController.highPriorityOnly.value,
                            tristate: false,
                            title: Text('Show Only High Priority Tasks', style: txs14),
                            onChanged: (bool? value) {
                              checkboxController.highPriorityOnly.value = value!;
                              theSettingBox.put('highPriorityOnly', value);
                              taskController.taskList.refresh();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  // Radio<int> radio1(int radioButtonIndex) {
  //   return Radio(
  //     value: radioButtonIndex,
  //     groupValue: radioController.selected1Value.value,
  //     onChanged: (int? newValue) {
  //       radioController.setSelected1Value(newValue!);
  //       theSettingBox.put('sortBy', radioController.selected1Value.value);
  //     },
  //   );
  // }

  // Radio<int> radio2(int radioButtonIndex) {
  //   return Radio(
  //     value: radioButtonIndex,
  //     groupValue: radioController.selected2Value.value,
  //     onChanged: (int? newValue) {
  //       radioController.setSelected2Value(newValue!);
  //       theSettingBox.put('sortMode', radioController.selected2Value.value);
  //     },
  //   );
  // }

  RadioListTile<int> radio3(int radioButtonIndex, Widget theWidget) {
    return RadioListTile(
      title: theWidget,
      value: radioButtonIndex,
      groupValue: radioController.selected1Value.value,
      onChanged: (int? newValue) {
        radioController.setSelected1Value(newValue!);
        theSettingBox.put('sortBy', radioController.selected1Value.value);
      },
    );
  }

  RadioListTile<int> radio4(int radioButtonIndex, Widget theWidget) {
    return RadioListTile(
      title: theWidget,
      value: radioButtonIndex,
      groupValue: radioController.selected2Value.value,
      onChanged: (int? newValue) {
        radioController.setSelected2Value(newValue!);
        theSettingBox.put('sortMode', radioController.selected2Value.value);
      },
    );
  }
}
