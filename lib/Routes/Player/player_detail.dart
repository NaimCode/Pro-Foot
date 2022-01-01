// ignore_for_file: unused_element

import 'package:api_football/Models/historique_model.dart';
import 'package:api_football/Models/player_statistic.dart';
import 'package:api_football/Models/primitives/sidelined.dart';
import 'package:api_football/Models/primitives/trophie.dart';
import 'package:api_football/Routes/Championants/classement.dart';
import 'package:api_football/Routes/Coachs/coach_detail.dart';

import 'package:api_football/Utils/api.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hive/hive.dart';

class PlayerDetail extends StatefulWidget {
  const PlayerDetail({Key? key}) : super(key: key);

  @override
  _PlayerDetailState createState() => _PlayerDetailState();
}

enum _Filter { statistic, trophies, events }
PlayerStatistic? _playerStatistic;
Rx<_Filter> _filter = _Filter.statistic.obs;
List<Trophie> _trophies = [];
List<Sidelined> _sidelined = [];

class _PlayerDetailState extends State<PlayerDetail> {
  @override
  void initState() {
    _playerStatistic = null;
    _trophies.clear();
    _sidelined.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _playerStatistic != null
        ? const Body()
        : FutureBuilder<dio.Response>(
            future: API().getPlayerStatistic("?id=" +
                Get.parameters['id']! +
                "&season=" +
                Get.parameters['season']!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              }
              if (snapshot.hasData) {
                _playerStatistic =
                    PlayerStatistic.fromMap(snapshot.data!.data.first);
                return const Body();
              }
              return const Text('Erreur');
            });
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(controller: ScrollController(), children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(90),
                  bottomLeft: Radius.circular(90))),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Image.network(_playerStatistic!.player!.photo!),
                  )),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: [
                      CoachItemText(
                          title: "nom",
                          value: _playerStatistic!.player!.firstname),
                      CoachItemText(
                          title: "prénom",
                          value: _playerStatistic!.player!.lastname),
                      CoachItemText(
                          title: "age",
                          value: _playerStatistic!.player!.age.toString()),
                      CoachItemText(
                          title: "taille",
                          value: _playerStatistic!.player!.height),
                      CoachItemText(
                          title: "poids",
                          value: _playerStatistic!.player!.weight),
                      CoachItemText(
                          title: "date de naissance",
                          value: _playerStatistic!.player!.dateNaissance),
                      CoachItemText(
                          title: "nationalité",
                          value: _playerStatistic!.player!.nationality),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 20),
          child: Row(
            children: [
              TextButton(
                  onPressed: () {
                    _filter.value = _Filter.statistic;
                  },
                  child: Obx(() => Opacity(
                        opacity: _filter.value == _Filter.statistic ? 1 : 0.5,
                        child: Text(
                          "Statistiques",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ))),
              const SizedBox(width: 40),
              TextButton(
                  onPressed: () {
                    _filter.value = _Filter.trophies;
                  },
                  child: Obx(() => Opacity(
                        opacity: _filter.value == _Filter.trophies ? 1 : 0.5,
                        child: Text(
                          "Trophées",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ))),
              const SizedBox(width: 40),
              TextButton(
                  onPressed: () {
                    _filter.value = _Filter.events;
                  },
                  child: Obx(() => Opacity(
                        opacity: _filter.value == _Filter.events ? 1 : 0.5,
                        child: Text(
                          "Evénement",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ))),
            ],
          ),
        ),
        Obx(() => _filter.value == _Filter.statistic
            ? const Statistics()
            : _filter.value == _Filter.trophies
                ? _trophies.isNotEmpty
                    ? const TrophieCoach()
                    : FutureBuilder<dio.Response>(
                        future: API().getTrophies("?player=" +
                            _playerStatistic!.player!.id.toString()),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return const SizedBox(
                              height: 300,
                              child: LoadingPage(),
                            );
                          }
                          if (snap.hasData) {
                            _trophies = snap.data!.data
                                .map((l) => Trophie.fromMap(l))
                                .toList()
                                .cast<Trophie>();
                          }
                          if (snap.hasError) {
                            print(snap.error);
                          }

                          return const TrophieCoach();
                        })
                : _sidelined.isNotEmpty
                    ? const SidelinedCoach()
                    : FutureBuilder<dio.Response>(
                        future: API().getSidelined("?player=" +
                            _playerStatistic!.player!.id.toString()),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return const SizedBox(
                              height: 300,
                              child: LoadingPage(),
                            );
                          }
                          if (snap.hasData) {
                            _sidelined = snap.data!.data
                                .map((l) => Sidelined.fromMap(l))
                                .toList()
                                .cast<Sidelined>();
                          }
                          if (snap.hasError) {
                            print(snap.error);
                          }
                          return const SidelinedCoach();
                        }))
      ]),
    );
  }
}

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        key: GlobalKey(),
        scrollDirection: Axis.horizontal,
        controller: ScrollController(),
        child: Center(
          child: DataTable(
              showCheckboxColumn: false,
              columns: const [
                DataColumn(label: ColumnItem(text: "Ligue"), numeric: false),
                DataColumn(label: ColumnItem(text: "Equipe")),
                DataColumn(label: ColumnItem(text: "Matchs"), numeric: true),
                DataColumn(label: ColumnItem(text: "Buts"), numeric: true),
                DataColumn(label: ColumnItem(text: "Tirs"), numeric: true),
                DataColumn(
                    label: ColumnItem(text: "Cartons jaunes"), numeric: true),
                // DataColumn(
                //     label: ColumnItem(text: "Marqués"), numeric: true),
                // DataColumn(
                //     label: ColumnItem(text: "Encaissés"), numeric: true),
                DataColumn(
                    label: ColumnItem(text: "Cartons rouges"), numeric: true),
                DataColumn(label: ColumnItem(text: "Dribles"), numeric: true),
                DataColumn(label: ColumnItem(text: "Tacles"), numeric: true),
              ],
              rows: _playerStatistic!.statisticPlayers!
                  .map((e) => DataRow(
                          onSelectChanged: (b) {
                            Box box = Hive.box("historique");
                            if (b!) {
                              if (!box.values.any((element) =>
                                  element.name == e.team_v1!.name)) {
                                box.add(HistoriqueModel(
                                  name: e.team_v1!.name,
                                  route: "/equipes/" + e.team_v1!.id.toString(),
                                  image: e.team_v1!.logo!,
                                ));
                              }
                              Get.toNamed(
                                  "/equipes/" + e.team_v1!.id.toString());
                            }
                          },
                          cells: [
                            DataCell(Text("${e.league_v2!.name}")),
                            DataCell(Text("${e.team_v1!.name}")),

                            DataCell(Text(
                              "${e.appearences}",
                              style: Theme.of(context).textTheme.caption,
                            )),
                            DataCell(Text(
                              "${e.goal}",
                              style: Theme.of(context).textTheme.caption,
                            )),
                            DataCell(Text(
                              "${e.shootTotal}",
                              style: Theme.of(context).textTheme.caption,
                            )),
                            DataCell(Text(
                              "${e.yellow}",
                              style: Theme.of(context).textTheme.caption,
                            )),
                            DataCell(Text(
                              e.red.toString(),
                              style: Theme.of(context).textTheme.caption,
                            )),
                            // DataCell(Text("${e.goalFor}")),
                            // DataCell(Text("${e.goalAgainst}")),
                            DataCell(Text(
                              "${e.dribleReussi}",
                              style: Theme.of(context).textTheme.caption,
                            )),
                            DataCell(Text(
                              "${e.tacle}",
                              style: Theme.of(context).textTheme.caption,
                            )),
                          ]))
                  .toList()),
        ),
      ),
    );
  }
}

class SidelinedCoach extends StatelessWidget {
  const SidelinedCoach({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: _sidelined
            .map((e) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Text(
                                e.type!,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    e.start!,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      "début",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(fontSize: 12),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    e.end!,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      "fin",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(fontSize: 12),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList());
  }
}

class TrophieCoach extends StatelessWidget {
  const TrophieCoach({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: _trophies
            .where((element) => element.place == "Winner")
            .map((e) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Text(
                                e.league!,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    e.season!,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      "saison",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(fontSize: 12),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList());
  }
}
