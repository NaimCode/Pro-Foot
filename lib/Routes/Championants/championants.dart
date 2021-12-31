import 'dart:convert';

import 'package:api_football/Models/historique_model.dart';
import 'package:api_football/Models/league.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Utils/convertion.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:api_football/Widgets/page.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:hive/hive.dart';

List<League> _initLeagues = [];
RxList<dynamic> _leagues = [].obs;
RxString _title = "Recommandations".obs;

TextEditingController _rechercheController = TextEditingController();

class Championants extends StatefulWidget {
  const Championants({Key? key}) : super(key: key);

  @override
  _ChampionantsState createState() => _ChampionantsState();
}

class _ChampionantsState extends State<Championants> {
  API api = API();
  RxBool isLoaing = false.obs;

  iniLeagueFromLocal() async {
    var snapshot = await Convertion.stringToJson("assets/leagues.json");
    _initLeagues = Convertion.fromLocalJsonToListLeague(snapshot.toString());
    _leagues.value = _initLeagues;
  }

  recherche() async {
    if (_rechercheController.text.length >= 3) {
      isLoaing.value = true;
      var response = await api.getLigues(_rechercheController.text);
      _leagues.value =
          response.data.map((l) => League.fromMap(l)).toList().cast<League>();
      _title.value = "Résultats trouvés pour \"${_rechercheController.text}\"";
      isLoaing.value = false;
    }
  }

  @override
  void initState() {
    iniLeagueFromLocal();
    _rechercheController.addListener(() {
      if (_rechercheController.text.isEmpty ||
          _rechercheController.text.length < 3) {
        _title.value = "Recommandations";
        _leagues.value = _initLeagues;
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _rechercheController,
                onEditingComplete: recherche,
                decoration: InputDecoration(
                    suffixIcon: Obx(() => IconButton(
                        tooltip: _title.value != "Recommandations"
                            ? "Effacer"
                            : "Rechercher",
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          _rechercheController.clear();
                        },
                        icon: Icon(_title.value != "Recommandations"
                            ? Icons.close
                            : Icons.search))),
                    hintText: "Recherche des championants",
                    contentPadding: const EdgeInsets.only(top: 15),
                    border: InputBorder.none),
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(70),
        ),
        body: Obx(() => isLoaing.value ? const LoadingPage() : const Body()));
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 00),
        child: Obx(() => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Text(_title.value,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.blue[100])),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeagueContainer(
                    leagues: _leagues
                        .where((l) => l.league_v1.type == "League")
                        .toList(growable: false)
                        .cast(),
                    title: "Ligues",
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  LeagueContainer(
                    leagues: _leagues
                        .where((l) => l.league_v1.type == "Cup")
                        .toList(growable: false)
                        .cast<League>(),
                    title: "Coupes",
                  ),
                ],
              ),
            ))));
  }
}

class LeagueContainer extends StatelessWidget {
  const LeagueContainer({
    Key? key,
    required this.leagues,
    required this.title,
  }) : super(key: key);

  final String title;
  final List<League> leagues;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: 0.5,
            child: Text(
              "$title: ${leagues.length > 20 ? 20 : leagues.length}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ...leagues
              .getRange(0, leagues.length > 20 ? 20 : leagues.length)
              .map((e) => LeagueItem(league: e))
              .toList()
        ],
      ),
    ));
  }
}

class LeagueItem extends StatelessWidget {
  final League league;
  const LeagueItem({Key? key, required this.league}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Box box = Hive.box("historique");
          // historiqueList.addIf(
          //     !historiqueList
          //         .any((element) => element.name == league.league_v1!.name),
          //     HistoriqueModel(
          //       name: league.league_v1!.name,
          //       route: "/championants/" +
          //           league.league_v1!.id.toString() +
          //           "/" +
          //           league.seasons!.last.year!.toString(),
          //       image: league.league_v1!.logo!,
          //     )
          // );

          if (!box.values
              .any((element) => element.name == league.league_v1!.name)) {
            box.add(HistoriqueModel(
              name: league.league_v1!.name,
              route: "/championants/" +
                  league.league_v1!.id.toString() +
                  "/" +
                  league.seasons!.last.year!.toString(),
              image: league.league_v1!.logo!,
            ));
          }
          Get.toNamed(
            "/championants/" +
                league.league_v1!.id.toString() +
                "/" +
                league.seasons!.last.year!.toString(),
          );
        },
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
                    league.league_v1!.logo!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                league.league_v1!.name!,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
