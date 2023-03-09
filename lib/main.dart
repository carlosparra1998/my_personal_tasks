import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'utils/strings.dart' as s;
import 'view_model/task_view_model.dart';
import 'view_model/theme_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var prefs = await SharedPreferences.getInstance();

  bool darkTheme = prefs.getBool(s.darkThemeKey) ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskVM()),
        ChangeNotifierProvider(
            create: (_) => ThemeVM(
                darkTheme,
                (darkTheme)
                    ? const Color.fromARGB(255, 46, 46, 46)
                    : Colors.white,
                (darkTheme) ? Colors.white : Colors.black,
                (darkTheme)
                    ? const Color.fromARGB(255, 185, 185, 185)
                    : const Color.fromARGB(255, 139, 139, 139),
                (darkTheme)
                    ? const Color.fromARGB(255, 88, 88, 88)
                    : Colors.white,
                (darkTheme) ? Colors.black : Colors.white,
                (darkTheme)
                    ? const Color.fromARGB(255, 255, 212, 212)
                    : Colors.red)),
      ],
      child: const MyPersonalTasksApp(),
    ),
  );
}
