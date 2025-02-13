import 'dart:io';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'features/settings/data/theme.dart';
import 'routing/routes.dart';
import 'shared/styles/lib_color_schemes.g.dart';
import 'shared/windows/title_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialAppWithTheme();
  }
}

class MaterialAppWithTheme extends ConsumerWidget {
  const MaterialAppWithTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    final router = baseRoutes;

    return _App(
      theme: theme,
      enableCustomTitleBar: Platform.isWindows == true,
      builder: (context) => MaterialApp.router(
        showPerformanceOverlay: kProfileMode == true,
        routeInformationProvider: router.routeInformationProvider,
        useInheritedMediaQuery: true,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        builder: (context, widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget!),
            breakpoints: const [
              ResponsiveBreakpoint.resize(480, name: MOBILE),
              ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ]),
        themeMode: theme.themeMode,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      ),
    );
  }
}

class _App extends StatelessWidget {
  const _App({
    required this.builder,
    required this.theme,
    this.enableCustomTitleBar = false,
  });
  final WidgetBuilder builder;
  final bool enableCustomTitleBar;
  final ThemeNotifer theme;
  @override
  Widget build(BuildContext context) {
    
    if (!enableCustomTitleBar) {
      return builder(context);
    }
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: AppThemeBuilder(
        themeMode: theme.themeMode,
        darkDynamic: darkColorScheme,
        lightDynamic: lightColorScheme,
        child: Stack(
          children: [
            MediaQuery.fromWindow(
              child: Builder(builder: (context) {
                final mediaQueryData = MediaQuery.of(context);
                return MediaQuery(
                  data: mediaQueryData.copyWith(
                    viewPadding: mediaQueryData.padding
                        .copyWith(top: mediaQueryData.viewPadding.top + 50),
                  ),
                  child: builder(context),
                );
              }),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: TitleBar(),
            ),
          ],
        ),
      ),
    );
  }
}
