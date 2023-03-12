import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_personal_tasks/app.dart';
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
                const Color.fromARGB(255, 46, 46, 46),
                Colors.white,
                const Color.fromARGB(255, 185, 185, 185),
                const Color.fromARGB(255, 88, 88, 88),
                Colors.black,
                const Color.fromARGB(255, 255, 212, 212))),
      ],
      child: const MyPersonalTasksApp(),
    ));

    final fab1 = find.byKey(const Key("fab1"));

    expect(find.byKey(const Key("fab1")), findsOneWidget);

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

  testWidgets('Task modification test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskVM()),
        ChangeNotifierProvider(
            create: (_) => ThemeVM(
                true,
                const Color.fromARGB(255, 46, 46, 46),
                Colors.white,
                const Color.fromARGB(255, 185, 185, 185),
                const Color.fromARGB(255, 88, 88, 88),
                Colors.black,
                const Color.fromARGB(255, 255, 212, 212))),
      ],
      child: const MyPersonalTasksApp(),
    ));

    await tester.pump();

    expect(find.text('Tarea test'), findsOneWidget);
    expect(find.text('Tarea descripción'), findsOneWidget);

    await tester.tap(find.byType(ListTile));
    await tester.pump();

    final titleModTextField = find.byKey(const Key("titleMod"));
    final descriptionModTextField = find.byKey(const Key("descriptionMod"));
    final modifyButton = find.byKey(const Key("modifyButton"));

    expect(titleModTextField, findsOneWidget);
    expect(descriptionModTextField, findsOneWidget);
    expect(modifyButton, findsOneWidget);

    await tester.enterText(titleModTextField, 'Tarea test 2');
    await tester.pump();

    await tester.enterText(descriptionModTextField, 'Tarea descripción 2');
    await tester.pump();

    await tester.tap(modifyButton);
    await tester.pump();

    expect(modifyButton, findsNothing);
    expect(find.text('Tarea test 2'), findsOneWidget);
    expect(find.text('Tarea descripción 2'), findsOneWidget);
  });
  testWidgets('Task delete test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskVM()),
        ChangeNotifierProvider(
            create: (_) => ThemeVM(
                true,
                const Color.fromARGB(255, 46, 46, 46),
                Colors.white,
                const Color.fromARGB(255, 185, 185, 185),
                const Color.fromARGB(255, 88, 88, 88),
                Colors.black,
                const Color.fromARGB(255, 255, 212, 212))),
      ],
      child: const MyPersonalTasksApp(),
    ));

    await tester.pump();

    final completeCheck = find.byKey(const Key("completeCheck"));

    expect(completeCheck, findsOneWidget);
    expect(find.text('Tarea test 2'), findsOneWidget);
    expect(find.text('Tarea descripción 2'), findsOneWidget);

    await tester.tap(completeCheck);
    await tester.pumpAndSettle();

    expect(completeCheck, findsNothing);
    expect(find.text('Tarea test 2'), findsNothing);
    expect(find.text('Tarea descripción 2'), findsNothing);
  });
}
