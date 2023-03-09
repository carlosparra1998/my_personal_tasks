import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/task.dart';
import '../../../utils/strings.dart' as s;
import '../../../utils/utils.dart';
import '../../../view_model/task_view_model.dart';
import '../../../view_model/theme_view_model.dart';

Future<String?> addTaskDialog(BuildContext context) async {

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  String dropdownvalue = s.priority1;

  int priority = 1;

  TaskVM taskViewModel = Provider.of<TaskVM>(context, listen: false);

  return showDialog(
      context: context,
      builder: (context) {
        ThemeVM themeViewModel = context.watch<ThemeVM>();

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: themeViewModel.cardColor,
              icon: Icon(
                Icons.task,
                color: themeViewModel.fontColor,
              ),
              title: Text(
                s.addTask,
                style: TextStyle(color: themeViewModel.fontColor),
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      style: TextStyle(color: themeViewModel.fontColor),
                      cursorColor: themeViewModel.subtitleColor,
                      controller: titleController,
                      decoration: InputDecoration(
                          labelText: s.titleTask,
                          labelStyle:
                              TextStyle(color: themeViewModel.subtitleColor),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8.0)))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      cursorColor: themeViewModel.subtitleColor,
                      controller: descriptionController,
                      style: TextStyle(color: themeViewModel.fontColor),
                      decoration: InputDecoration(
                          labelText: s.descriptionTask,
                          labelStyle:
                              TextStyle(color: themeViewModel.subtitleColor),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8.0)))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        iconEnabledColor: themeViewModel.subtitleColor,
                        dropdownDecoration: BoxDecoration(
                            color: themeViewModel.cardColor),
                        buttonDecoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(color: Colors.grey[500]!)),
                        alignment: AlignmentDirectional.centerStart,

                        items: priorities
                            .map((item) => DropdownMenuItem<String>(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        color: themeViewModel.fontColor),
                                  ),
                                ))
                            .toList(),
                        value: dropdownvalue,
                        onChanged: (String? newValue) {
                          dropdownvalue = newValue!;
                          priority = (dropdownvalue == priorities[0])
                              ? 1
                              : (dropdownvalue == priorities[1] ? 2 : 3);
                          setState(() {});
                        },

                      ),
                    ),
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    if(titleController.text.isEmpty){
                      showToast(s.emptyField);
                      return;
                    }
                    taskViewModel.setTaskInList(Task(
                        taskViewModel.getIdLast + 1,
                        titleController.text,
                        descriptionController.text,
                        priority));

                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: BorderSide(color: themeViewModel.buttonColor, width: 1.5),
                  ),
                  child: Text(
                    s.save,
                    style: TextStyle(fontSize: 18.0, color: themeViewModel.buttonColor),
                  ),
                ),
              ],
            );
          },
        );
      });
}
