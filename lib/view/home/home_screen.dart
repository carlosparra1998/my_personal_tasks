import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../model/task.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    sortList(taskList);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              color: Colors.black,
              icon: Icon(isSwitched ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                isSwitched = !isSwitched;
                setState(() {});
              })
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: taskList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                onTap: () {
                  modTask(
                          context,
                          taskList[index].title,
                          taskList[index].description,
                          taskList[index].priorityLevel,
                          index)
                      .then((value) {
                    setState(() {});
                  });
                },
                contentPadding: EdgeInsets.all(0),
                leading: Checkbox(
                  side: BorderSide(
                    color: (taskList[index].priorityLevel == 1)
                        ? Colors.red
                        : (taskList[index].priorityLevel == 2
                            ? Colors.orange
                            : Colors.blue), //your desire colour here
                    width: 2.5,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onChanged: (bool? value) {
                    setState(() {});
                    var auxil = <Task>[];
                    auxil.addAll(taskList);
                    taskList.removeAt(index);
                    final snackBar = SnackBar(
                      duration: Duration(milliseconds: 2300),
                      content: Text('Tarea completada :)'),
                      action: SnackBarAction(
                        label: 'Deshacer',
                        onPressed: () {
                          taskList = [];
                          taskList.addAll(auxil);

                          setState(() {});
                        },
                      ),
                    );

                    // Encuentra el Scaffold en el árbol de widgets y ¡úsalo para mostrar un SnackBar!
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    setState(() {});
                  },
                  value: false,
                ),
                title: Text(taskList[index].title),
                subtitle: Text(taskList[index].description),
              ),
            );
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask(context).then((value) {
            setState(() {});
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<String?> modTask(BuildContext context, String title, String subtitle,
    int priority, int index) async {
  var controllerNew = TextEditingController();
  var controllerNew2 = TextEditingController();

  controllerNew.text = title;
  controllerNew2.text = subtitle;

  var items = ['🔴 Prioridad 1', '🟠 Prioridad 2', '🔵 Prioridad 3'];
  String _dropdownvalue = items[priority - 1];

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              child: AlertDialog(
                icon: Icon(Icons.edit),
                title: Text('Modifica tu tarea'),
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
                          items: items
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
                            priority = (_dropdownvalue == items[0])
                                ? 1
                                : (_dropdownvalue == items[1] ? 2 : 3);

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
                      taskList[index].title = controllerNew.text;
                      taskList[index].description = controllerNew2.text;
                      taskList[index].priorityLevel = priority;
                      sortList(taskList);

                      setState(() {});

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

Future<String?> addTask(BuildContext context) async {
  var controllerNew = TextEditingController();
  var controllerNew2 = TextEditingController();
  String _dropdownvalue = '🔴 Prioridad 1';
  int priority = 1;
  var items = ['🔴 Prioridad 1', '🟠 Prioridad 2', '🔵 Prioridad 3'];

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
                          items: items
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
                            priority = (_dropdownvalue == items[0])
                                ? 1
                                : (_dropdownvalue == items[1] ? 2 : 3);
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
                      taskList.add(Task(taskList.last.id + 1,
                          controllerNew.text, controllerNew2.text, priority));

                      sortList(taskList);

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
