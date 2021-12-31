import 'dart:io';

import 'package:api_football/Routes/verus/404.dart';
import 'package:api_football/Routes/Championants/championants.dart';
import 'package:api_football/Routes/Coachs/coachs.dart';
import 'package:api_football/Routes/Equipe/equipe.dart';
import 'package:api_football/Routes/Matchs/matchs.dart';
import 'package:api_football/Routes/Pays/pays.dart';
import 'package:api_football/Utils/Theme.dart';
import 'package:api_football/Widgets/page.dart';
import 'package:api_football/Routes/Equipe/bodyPlayers.dart';
import 'package:api_football/Routes/Championants/classement.dart';
import 'package:api_football/Routes/Pays/League_pays.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'Models/historique_model.dart';
import 'Routes/Equipe/equipe_fixture.dart';
import 'Routes/Home/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HistoriqueModelAdapter());
  var box = await Hive.openBox('historique');

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Api Football",
      initialRoute: "/home",
      unknownRoute: GetPage(
          name: "/404",
          page: () => const Root(page: PageNotFound()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500)),
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: "/",
          page: () => const Root(page: Home()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/home",
          page: () => const Root(page: Home()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/equipes",
          page: () => const Root(page: Equipes()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/equipes/:id",
          page: () => const Root(page: EquipeFixture()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/coaches",
          page: () => const Root(page: CoachsPage()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/matchs",
          page: () => const Root(page: Matchs()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/championants",
          page: () => const Root(page: Championants()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/pays",
          page: () => const Root(page: PagePays()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/pays/:country",
          page: () => const Root(page: LeagueCountry()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/championants/:league/:season",
          page: () => const Root(page: BodyClassement()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/versus",
          page: () => const Root(page: PageNotFound()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ],
    );
  }
}
