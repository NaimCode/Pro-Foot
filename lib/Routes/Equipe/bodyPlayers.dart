import 'package:api_football/Models/historique_model.dart';
import 'package:api_football/Models/primitives/player.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart' as dio;
import '../../Models/team.dart';

class BodyPlayers extends StatefulWidget {
  const BodyPlayers({Key? key}) : super(key: key);

  @override
  _BodyPlayersState createState() => _BodyPlayersState();
}

class _BodyPlayersState extends State<BodyPlayers> {
  int page = 1;
  API api = API();
  @override
  Widget build(BuildContext context) {
    int team = context.watch<int>();

    return FutureBuilder<dio.Response>(
        future: api.getPlayers("?team=$team&page=$page&season=2021"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          int pageTotal = 0;
          List<Player> players = [];
          if (snapshot.hasData) {
            players = snapshot.data!.data['players']
                .map((l) => Player.fromMap(l))
                .toList()
                .cast<Player>();
            pageTotal = snapshot.data!.data['page'];
          }
          return Scaffold(
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 60,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                const Expanded(
                    child: Opacity(
                        opacity: 0.5,
                        child: Text(
                          "page",
                        ))),
                ...List.generate(
                    pageTotal,
                    (index) => InkWell(
                        radius: 10,
                        onTap: () {
                          setState(() {
                            page = index + 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Opacity(
                            opacity: page == 1 + index ? 1 : 0.5,
                            child: Text((1 + index).toString(),
                                style: Theme.of(context).textTheme.subtitle1),
                          ),
                        ))),
              ]),
              //color: Colors.white,
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Text("Joueurs de cette saison",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.blue[100])),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 260,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 40),
                  itemCount: players.length,
                  itemBuilder: (context, index) =>
                      playerItem(coach: players[index])),
            ),
          );
        });
  }
}

class playerItem extends StatelessWidget {
  final Player coach;
  const playerItem({Key? key, required this.coach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Box box = Hive.box("historique");
        if (!box.values.any((element) => element.name == coach.name)) {
          box.add(HistoriqueModel(
            name: coach.name,
            route: "/joueurs/" + coach.id.toString() + "/2021",
            image: coach.photo,
          ));
        }
        Get.toNamed("/joueurs/" + coach.id.toString() + "/2021");
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.network(
                    coach.photo!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                coach.name!,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
