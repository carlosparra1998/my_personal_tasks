import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_personal_tasks/app.dart';
import 'package:my_personal_tasks/view/home/home_screen.dart';
import 'package:my_personal_tasks/view/home/widgets/list_view.dart';
import 'package:my_personal_tasks/view_model/task_view_model.dart';
import 'package:my_personal_tasks/view_model/theme_view_model.dart';
import 'package:provider/provider.dart';

void main() {

  testWidgets('Task creation test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskVM()),
        ChangeNotifierProvider(
            create: (_) => ThemeVM(
                true,
                (true) ? const Color.fromARGB(255, 46, 46, 46) : Colors.white,
                (true) ? Colors.white : Colors.black,
                (true)
                    ? const Color.fromARGB(255, 185, 185, 185)
                    : const Color.fromARGB(255, 139, 139, 139),
                (true) ? const Color.fromARGB(255, 88, 88, 88) : Colors.white,
                (true) ? Colors.black : Colors.white,
                (true)
                    ? const Color.fromARGB(255, 255, 212, 212)
                    : Colors.red)),
      ],
      child: const MyPersonalTasksApp(),
    ));

    final fab1 = find.byKey(const Key("fab1"));

    expect(fab1, findsOneWidget);

    await tester.tap(fab1);

    await tester.pump();

    final titleTextField = find.byKey(const Key("titleField"));
    final descriptionTextField = find.byKey(const Key("descriptionField"));
    final saveButton = find.byKey(const Key("createButton"));

    expect(titleTextField, findsOneWidget);
    expect(descriptionTextField, findsOneWidget);
    expect(saveButton, findsOneWidget);

    await tester.enterText(titleTextField, 'Tarea test');
    await tester.pump();

    await tester.enterText(descriptionTextField, 'Tarea descripción');
    await tester.pump();

    await tester.tap(saveButton);
    await tester.pump();

    final listTile = find.byType(ListTile);
    final listView = find.byKey(const Key("listView"));

    expect(saveButton, findsNothing);
    expect(listView, findsOneWidget);
    expect(listTile, findsOneWidget);
    expect(find.text('Tarea test'), findsOneWidget);
    expect(find.text('Tarea descripción'), findsOneWidget);
  });
    testWidgets('Task delete test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskVM()),
        ChangeNotifierProvider(
            create: (_) => ThemeVM(
                true,
                (true) ? const Color.fromARGB(255, 46, 46, 46) : Colors.white,
                (true) ? Colors.white : Colors.black,
                (true)
                    ? const Color.fromARGB(255, 185, 185, 185)
                    : const Color.fromARGB(255, 139, 139, 139),
                (true) ? const Color.fromARGB(255, 88, 88, 88) : Colors.white,
                (true) ? Colors.black : Colors.white,
                (true)
                    ? const Color.fromARGB(255, 255, 212, 212)
                    : Colors.red)),
      ],
      child: const MyPersonalTasksApp(),
    ));

    final fab1 = find.byKey(const Key("fab1"));

    await tester.tap(fab1);

    await tester.pump();

    final titleTextField = find.byKey(const Key("titleField"));
    final descriptionTextField = find.byKey(const Key("descriptionField"));
    final saveButton = find.byKey(const Key("createButton"));

    await tester.enterText(titleTextField, 'Tarea 2 test');
    await tester.pump();

    await tester.enterText(descriptionTextField, 'Tarea 2 descripción');
    await tester.pump();

    await tester.tap(saveButton);
    await tester.pump();

    final listTile = find.byType(ListTile);
    final listView = find.byKey(const Key("listView"));

    final completeCheck = find.byKey(const Key("completeCheck"));

    expect(completeCheck, findsOneWidget);
    expect(find.text('Tarea 2 test'), findsOneWidget);
    expect(find.text('Tarea 2 descripción'), findsOneWidget);
    
    await tester.tap(completeCheck);
    await tester.pumpAndSettle();
    
    expect(completeCheck, findsNothing);
    expect(find.text('Tarea 2 test'), findsNothing);
    expect(find.text('Tarea 2 descripción'), findsNothing);

  });

  
  testWidgets('Task modification test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskVM()),
        ChangeNotifierProvider(
            create: (_) => ThemeVM(
                true,
                (true) ? const Color.fromARGB(255, 46, 46, 46) : Colors.white,
                (true) ? Colors.white : Colors.black,
                (true)
                    ? const Color.fromARGB(255, 185, 185, 185)
                    : const Color.fromARGB(255, 139, 139, 139),
                (true) ? const Color.fromARGB(255, 88, 88, 88) : Colors.white,
                (true) ? Colors.black : Colors.white,
                (true)
                    ? const Color.fromARGB(255, 255, 212, 212)
                    : Colors.red)),
      ],
      child: const MyPersonalTasksApp(),
    ));

    final fab1 = find.byKey(const Key("fab1"));

    await tester.tap(fab1);

    await tester.pump();

    final titleTextField = find.byKey(const Key("titleField"));
    final descriptionTextField = find.byKey(const Key("descriptionField"));
    final saveButton = find.byKey(const Key("createButton"));

    await tester.enterText(titleTextField, 'Tarea 3 test');
    await tester.pump();

    await tester.enterText(descriptionTextField, 'Tarea 3 descripción');
    await tester.pump();

    await tester.tap(saveButton);
    await tester.pump();

    final listTile = find.byType(ListTile);
    final listView = find.byKey(const Key("listView"));

    expect(find.text('Tarea 3 test'), findsOneWidget);
    expect(find.text('Tarea 3 descripción'), findsOneWidget);

    await tester.tap(listTile);
    await tester.pump();

    final titleModTextField = find.byKey(const Key("titleMod"));
    final descriptionModTextField = find.byKey(const Key("descriptionMod"));
    final modifyButton = find.byKey(const Key("modifyButton"));

    expect(titleModTextField, findsOneWidget);
    expect(descriptionModTextField, findsOneWidget);
    expect(modifyButton, findsOneWidget);

    await tester.enterText(titleModTextField, 'Tarea 3 test mod');
    await tester.pump();

    await tester.enterText(descriptionModTextField, 'Tarea 3 descripción mod');
    await tester.pump();

    await tester.tap(modifyButton);
    await tester.pump();

    expect(modifyButton, findsNothing);
    expect(find.text('Tarea 3 test mod'), findsOneWidget);
    expect(find.text('Tarea 3 descripción mod'), findsOneWidget);

    
  });
}
