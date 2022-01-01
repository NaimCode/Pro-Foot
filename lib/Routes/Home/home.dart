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
    bool m = MediaQuery.of(context).size.width <= 450;
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
                SizedBox(
                  height: m ? 10 : 30,
                ),
                const Logo(),
                SizedBox(
                  height: m ? 20 : 50,
                ),
                const Text(
                  'BIENVENUE A',
                  style:
                      TextStyle(fontWeight: FontWeight.w200, letterSpacing: 4),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: m ? 10 : 20),
                  child: Text(
                    '• PRO FOOT •',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: m ? 49 : 60),
                  ),
                ),
                SizedBox(
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Vous trouverez ici tout sur les meilleures équipes du monde entier. Les championants les plus suivis ainsi que les moins, les dernières nouvelles, des statistiques en détail et bien plus encore.",
                      style: TextStyle(
                          color: Colors.white70, fontSize: m ? 14 : null),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Wrap(
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  runSpacing: 0,
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
    bool m = MediaQuery.of(context).size.width <= 450;
    return InkWell(
      onTap: () {
        Get.toNamed(menu['route']);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: m ? 100 : 130,
          height: m ? 70 : 100,
          child: Card(
            color: Theme.of(context).cardColor.withOpacity(0.8),
            child: Opacity(
              opacity: 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(menu['icon'],
                        color: Theme.of(context).iconTheme.color),
                    const SizedBox(height: 5),
                    Text(
                      menu['titre'],
                      style: TextStyle(
                          fontWeight: FontWeight.w200, fontSize: m ? 10 : null),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
