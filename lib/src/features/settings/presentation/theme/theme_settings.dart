import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../data/theme.dart';

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Theme.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final theme = ref.watch(themeProvider);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      LocaleKeys.System_Prefrence.tr(),
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    Switch(
                      value: theme.themeMode == ThemeMode.system || false,
                      onChanged: (value) {
                        ref.read(themeProvider).setSystem();
                      },
                    )
                  ],
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final theme = ref.watch(themeProvider);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Iconsax.sun_1),
                    Text(
                      LocaleKeys.Light_Mode.tr(),
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    Switch(
                      value: theme.themeMode == ThemeMode.light || false,
                      onChanged: (value) {
                        if (!value) {
                          ref.read(themeProvider).setSystem();
                        } else {
                          ref.read(themeProvider).setLight();
                        }
                      },
                    )
                  ],
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Iconsax.moon),
                  Text(LocaleKeys.Dark_Mode.tr(),
                      style: const TextStyle(fontSize: 18.0)),
                  Switch(
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (value) {
                      if (!value) {
                        ref.read(themeProvider).setSystem();
                      } else {
                        ref.read(themeProvider).setDark();
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
