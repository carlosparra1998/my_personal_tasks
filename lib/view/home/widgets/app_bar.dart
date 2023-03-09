import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/theme_view_model.dart';

PreferredSizeWidget HomeAppBar(BuildContext context, String title){
  ThemeVM themeViewModel = context.watch<ThemeVM>();
  
  return AppBar(
          backgroundColor: themeViewModel.themeColor,
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(color: themeViewModel.fontColor),
          ),
          actions: [
            IconButton(
                color: themeViewModel.fontColor,
                icon: Icon(!themeViewModel.getDarkTheme
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  themeViewModel.changeTheme();
                })
          ],
        );
}