import 'package:api_football/Models/historique_model.dart';
import 'package:api_football/Widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class Historique extends StatelessWidget {
  const Historique({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box('historique').listenable(),
        builder: (context, box, widget) {
          print(box.toMap());
          return Container(
              width: 300,
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  left: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  title: Opacity(
                    opacity: 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Historique",
                          style: Theme.of(context).textTheme.headline6!,
                        ),
                        const Icon(Icons.history)
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
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
                backgroundColor: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
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
