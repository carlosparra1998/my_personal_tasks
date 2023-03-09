import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'view_model/task_view_model.dart';
import 'view_model/theme_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var prefs = await SharedPreferences.getInstance();

  bool darkTheme = prefs.getBool('darkTheme') ?? false;

  Color themeColor =
      (darkTheme) ? Color.fromARGB(255, 46, 46, 46) : Colors.white;
  Color fontColor = (darkTheme) ? Colors.white : Colors.black;
  Color subtitleColor = (darkTheme)
      ? Color.fromARGB(255, 185, 185, 185)
      : Color.fromARGB(255, 139, 139, 139);
  Color cardColor =
      (darkTheme) ? Color.fromARGB(255, 88, 88, 88) : Colors.white;
  Color iconColor = (darkTheme) ? Colors.black : Colors.white;
  Color buttonColor =
      (darkTheme) ? Color.fromARGB(255, 255, 212, 212) : Colors.red;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskVM()),
        ChangeNotifierProvider(
            create: (_) => ThemeVM(darkTheme, themeColor, fontColor,
                subtitleColor, cardColor, iconColor, buttonColor)),
      ],
      child: const MyPersonalTasksApp(),
    ),
  );
}
