import 'dart:convert';

import 'package:api_football/Models/league.dart';
import 'package:api_football/Models/team.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Utils/convertion.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

List<Team> _initTeams = [];
RxList<dynamic> _teams = [].obs;
RxString _title = "Recommandations".obs;

TextEditingController _rechercheController = TextEditingController();

class Equipes extends StatefulWidget {
  const Equipes({Key? key}) : super(key: key);

  @override
  _EquipesState createState() => _EquipesState();
}

class _EquipesState extends State<Equipes> {
  API api = API();
  RxBool isLoaing = false.obs;

  iniLeagueFromLocal() async {
    var snapshot = await Convertion.stringToJson("assets/teams.json");
    _initTeams = Convertion.fromLocalJsonToListTeam(snapshot.toString());
    _teams.value = _initTeams;
  }

  recherche() async {
    if (_rechercheController.text.length >= 3) {
      isLoaing.value = true;
      var response = await api.getTeams(_rechercheController.text);
      _teams.value =
          response.data.map((l) => Team.fromMap(l)).toList().cast<Team>();
      _title.value =
          "${_teams.length < 20 ? _teams.length : 20} résultats trouvés pour \"${_rechercheController.text}\"";
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
        _teams.value = _initTeams;
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
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 10 / 2,
                shrinkWrap: true,
                controller: ScrollController(),
                crossAxisSpacing: 13,
                mainAxisSpacing: 7,
                children: _teams
                    .getRange(0, _teams.length < 20 ? _teams.length : 20)
                    .map((e) => teamItem(league: e))
                    .toList(),
              ),
            ))));
  }
}

class teamItem extends StatelessWidget {
  final Team league;
  const teamItem({Key? key, required this.league}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
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
                    league.team_v2!.logo!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                league.team_v2!.name!,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
