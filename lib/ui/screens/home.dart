import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spacepictures/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/route_constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Box settings = Hive.box(settingsBox);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld,
            style: Theme.of(context).textTheme.displayMedium),
        centerTitle: true,
      ),
      drawer: Drawer(
          width: MediaQuery.sizeOf(context).width * .75,
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM1UX1GrpnOMWYcQpoEKilLsqALNn0JrgSAg&usqp=CAU",
                    ),
                  ),
                ),
                child: Text(""),
              ),
              ValueListenableBuilder(
                valueListenable: Hive.box(settingsBox).listenable(),
                builder: (context, box, _) {
                  bool darkMode = settings.get(darkModeValue) ?? false;
                  return Switch(
                    value: darkMode,
                    onChanged: (val) {
                      settings.put(darkModeValue, !darkMode);
                    },
                  );
                },
              ),
            ],
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .7,
              height: MediaQuery.sizeOf(context).height * .1,
              child: FilledButton(
                onPressed: () => context.push(news),
                child: Text(
                  AppLocalizations.of(context)!.goToNasa,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: Hive.box(settingsBox).listenable(),
              builder: (context, box, _) {
                String language = settings.get(languageValue) ?? "en";
                return Switch(
                  value: language == "en",
                  onChanged: (val) {
                    settings.put(languageValue, val ? "en" : "ar");
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
