import 'package:api_football/Models/league.dart';
import 'package:api_football/Utils/convertion.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

List<String> _paysRecommandation = [
  "Belgique",
  "Brésil",
  "Égypte",
  "Angleterre",
  "Allemagne",
  "France",
  "Italie",
  "Maroc",
  "Portugal",
  "Espagne",
];

late Future<String> _futureCoutryList;
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
  @override
  void initState() {
    _futureCoutryList = Convertion.stringToJson("assets/leagues.json");
    _rechercheController.addListener(() {
      if (_rechercheController.text.isEmpty) {
        _leagues.value = _initLeagues;
      } else {
        if (_rechercheController.text.length >= 2) {
          _leagues.value = _initLeagues;
          _title.value =
              "${_leagues.length} résultats trouvés pour \"${_rechercheController.text}\"";
        }
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
          title: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _rechercheController,
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
      body: _initLeagues.isEmpty
          ? FutureBuilder(
              future: _futureCoutryList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Waiting');
                }

                if (snapshot.hasData) {
                  _initLeagues = Convertion.fromLocalJsonToListLeague(
                      snapshot.data!.toString());
                  _leagues.value = _initLeagues;
                }
                return Body();
              })
          : Body(),
    );
  }
}

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<League> leagues =
        _leagues.where((l) => l.league_v1.type == "League").toList().cast();
    List<League> coupes = _leagues
        .where((l) => l.league_v1.type == "Cup")
        .toList()
        .cast<League>();
    leagues.printInfo();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 00),
        child: Scaffold(
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
                    leagues: leagues,
                    title: "Ligues",
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  LeagueContainer(
                    leagues: coupes,
                    title: "Coupes",
                  ),
                ],
              ),
            )));
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
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.5,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ...leagues.map((e) => LeagueItem(league: e)).toList()
      ],
    ));
  }
}

class LeagueItem extends StatelessWidget {
  final League league;
  const LeagueItem({Key? key, required this.league}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
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
