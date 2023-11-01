import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spacepictures/utils/color_schemes.g.dart';
import 'package:spacepictures/utils/constants.dart';
import 'package:spacepictures/utils/custome_router.dart';
import 'package:spacepictures/utils/hive_managment.dart';
import 'package:spacepictures/utils/typography.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveManagment.initHive();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(settingsBox).listenable(),
      builder: (context, box, _) {
        bool darkMode = box.get(darkModeValue) ?? false;
        String language = box.get(languageValue) ?? "en";
        return MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          title: nasaNews,
          debugShowCheckedModeBanner: false,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          locale: Locale(language),
          theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: true,
            textTheme: textTheme,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: true,
            textTheme: textTheme,
          ),
          routerConfig: appRouter.router,
        );
      },
    );
  }
}
