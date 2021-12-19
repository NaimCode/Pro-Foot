import 'package:api_football/Routes/404.dart';
import 'package:api_football/Routes/Championants/championants.dart';
import 'package:api_football/Routes/Pays/pays.dart';
import 'package:api_football/Utils/Theme.dart';
import 'package:api_football/Widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';

import 'Routes/Home/home.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Api Football",
      initialRoute: "/",
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
          name: "/championants",
          page: () => const Root(page: Championants()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/pays",
          page: () => Root(page: PagePays()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/transferts",
          page: () => const Root(page: PageNotFound()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/versus",
          page: () => const Root(page: PageNotFound()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: "/joueurs",
          page: () => const Root(page: PageNotFound()),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ],
    );
  }
}
