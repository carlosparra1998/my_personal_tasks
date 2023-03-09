import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/task.dart';
import '../../../utils/utils.dart';
import '../../../view_model/task_view_model.dart';
import '../../../view_model/theme_view_model.dart';

Future<String?> addTaskDialog(BuildContext context) async {

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  String dropdownvalue = '🔴 Prioridad 1';

  int priority = 1;

  TaskVM moviesViewModel = Provider.of<TaskVM>(context, listen: false);

  return showDialog(
      context: context,
      builder: (context) {
        ThemeVM themeViewModel = context.watch<ThemeVM>();

        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              child: AlertDialog(
                backgroundColor: themeViewModel.cardColor,
                icon: Icon(
                  Icons.task,
                  color: themeViewModel.fontColor,
                ),
                title: Text(
                  'Añade una nueva tarea',
                  style: TextStyle(color: themeViewModel.fontColor),
                ),
                shape: RoundedRectangleBorder(
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
                            labelText: 'Título de la tarea',
                            labelStyle:
                                TextStyle(color: themeViewModel.subtitleColor),
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        cursorColor: themeViewModel.subtitleColor,
                        controller: descriptionController,
                        style: TextStyle(color: themeViewModel.fontColor),
                        decoration: InputDecoration(
                            labelText: 'Descripción de la tarea',
                            labelStyle:
                                TextStyle(color: themeViewModel.subtitleColor),
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)))),
                      ),
                      SizedBox(
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
                          //dropdownWidth : 1205.0,

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

                          //itemHeight: 40,
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
                        showToast("El campo título no puede estar vacío");
                        return;
                      }
                      moviesViewModel.setTaskInList(Task(
                          moviesViewModel.getIdLast + 1,
                          titleController.text,
                          descriptionController.text,
                          priority));

                      Navigator.pop(context);
                    },
                    child: Text(
                      "Guardar",
                      style: TextStyle(fontSize: 18.0, color: themeViewModel.buttonColor),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: BorderSide(color: themeViewModel.buttonColor, width: 1.5),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      });
}
