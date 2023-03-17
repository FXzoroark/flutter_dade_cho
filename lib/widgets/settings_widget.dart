import 'package:flutter/material.dart';
import 'package:flutter_dade_cho/utils/ThemeManager.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Consumer<ThemeNotifier>(
            builder: (context, theme, child) {
              return IconButton(
                icon: Icon(theme.getValue() ? Icons.dark_mode : Icons.light_mode, color: Theme.of(context).iconTheme.color,),
                onPressed: (){
                  theme.change();
                },
              );
/*              return Switch(
                value: theme.getValue(),
                onChanged: (bool value) {
                  theme.setValue(value);
                },
              );*/
            }
          )
        )
      ],
    );
  }
}
