import 'package:api_football/Data/list.dart';
import 'package:api_football/Widgets/constants/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Color pc = Theme.of(context).primaryColor;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/background.jpeg"),
          fit: BoxFit.cover,
        )),
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Logo(),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'BIENVENUE A',
                  style:
                      TextStyle(fontWeight: FontWeight.w200, letterSpacing: 4),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    '• PRO FOOT •',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
                  ),
                ),
                const SizedBox(
                  width: 500,
                  child: Text(
                    "Vous trouverez ici tout sur les meilleures équipes du monde entier. Les championants les plus suivis ainsi que les moins, les dernières nouvelles, des statistiques en détail et bien plus encore.",
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: listMenu
                      .where((element) => element['titre'] != "Home")
                      .map((menu) => HomeMenu(
                            menu: menu,
                          ))
                      .toList(),
                )
              ],
            )) /* add child content here */,
      ),
    );
  }
}

class HomeMenu extends StatelessWidget {
  final Map menu;
  const HomeMenu({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(menu['route']);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: 130,
          height: 100,
          child: Card(
            color: Theme.of(context).cardColor.withOpacity(0.8),
            child: Opacity(
              opacity: 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(menu['icon'], color: Theme.of(context).iconTheme.color),
                  const SizedBox(height: 5),
                  Text(
                    menu['titre'],
                    style: const TextStyle(fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
