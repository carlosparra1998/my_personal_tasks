import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/task.dart';
import '../../../utils/utils.dart';
import '../../../view_model/task_view_model.dart';

Future<String?> addTaskDialog(BuildContext context) async {
  var controllerNew = TextEditingController();
  var controllerNew2 = TextEditingController();
  String _dropdownvalue = '🔴 Prioridad 1';
  int priority = 1;
  
  TaskVM moviesViewModel = Provider.of<TaskVM>(context, listen: false);
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              child: AlertDialog(
                icon: Icon(Icons.task),
                title: Text('Añade una nueva tarea'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: controllerNew,
                        decoration: InputDecoration(
                            labelText: 'TODO title',
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: controllerNew2,
                        decoration: InputDecoration(
                            labelText: 'TODO description',
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
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
                                    ),
                                  ))
                              .toList(),
                          value: _dropdownvalue,
                          onChanged: (String? newValue) {
                            _dropdownvalue = newValue!;
                            priority = (_dropdownvalue == priorities[0])
                                ? 1
                                : (_dropdownvalue == priorities[1] ? 2 : 3);
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
                      moviesViewModel.setTaskInList(Task(moviesViewModel.getIdLast + 1,
                          controllerNew.text, controllerNew2.text, priority));

                      Navigator.pop(context);
                    },
                    child: Text(
                      "Guardar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: BorderSide(color: Colors.red, width: 1.5),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      });
}