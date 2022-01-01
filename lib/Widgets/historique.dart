import 'package:api_football/Models/historique_model.dart';
import 'package:api_football/Widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class Historique extends StatelessWidget {
  const Historique({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool m = MediaQuery.of(context).size.width <= 450;
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box('historique').listenable(),
        builder: (context, box, widget) {
          return Container(
              width: m ? double.infinity : 300,
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                //shape: BoxShape.rectangle,
                border: m
                    ? null
                    : Border(
                        left: BorderSide(color: Theme.of(context).dividerColor),
                      ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  title: Opacity(
                    opacity: 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Historique",
                          style: Theme.of(context).textTheme.headline6!,
                        ),
                        IconButton(
                            tooltip: "Effacer l'historique",
                            onPressed: Hive.box("historique").clear,
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
                body:
                    // Obx(
                    //   () =>
                    box.isEmpty
                        ? Opacity(
                            opacity: 0.5,
                            child: Center(
                              child: Text(
                                "Aucun historique disponible",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ))
                        : ListView.builder(
                            controller: ScrollController(),
                            itemCount: box.length,
                            itemBuilder: (context, index) =>
                                HistoriqueItem(historique: box.get(index))),
              )
              //),
              );
        });
  }
}

class HistoriqueItem extends StatelessWidget {
  final HistoriqueModel historique;
  const HistoriqueItem({Key? key, required this.historique}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool m = MediaQuery.of(context).size.width <= 450;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: historique.goTo,
        radius: 20,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: historique.image!.contains("coachs") ||
                        historique.image!.contains("players")
                    ? Colors.white
                    : Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: m && historique.image!.contains("svg")
                      ? SvgPicture.network(
                          historique.image!,
                          fit: BoxFit.fitHeight,
                        )
                      : Image.network(
                          historique.image!,
                          fit: BoxFit.fitHeight,
                        ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                child: Text(
                  historique.name!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
