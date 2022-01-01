import 'package:api_football/Models/fixture.dart';
import 'package:api_football/Models/league.dart';
import 'package:api_football/Models/primitives/player.dart';
import 'package:api_football/Models/primitives/team_v1.dart';
import 'package:api_football/Models/team.dart';
import 'package:api_football/Models/team_statistic.dart';
import 'package:api_football/Routes/Home/home.dart';
import 'package:api_football/Routes/Matchs/match_detail.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:api_football/Widgets/page.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Item.dart';
import 'bodyPlayers.dart';

class EquipeFixture extends StatefulWidget {
  const EquipeFixture({Key? key}) : super(key: key);

  @override
  _EquipeFixtureState createState() => _EquipeFixtureState();
}

enum _Filter { matchs, players, statistics }

Rx<_Filter> _filter = _Filter.matchs.obs;
List<League> _leagues = [];
RxInt _leagueSelected = 0.obs;
List<Fixture> _fixtures = [];

class _EquipeFixtureState extends State<EquipeFixture> {
  API api = API();
  @override
  void initState() {
    _leagues.clear();

    _fixtures.clear();
    //_filter.value = _Filter.matchs;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<int>(
      create: (context) => int.parse(Get.parameters['id']!),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              TextButton(
                  onPressed: () {
                    _filter.value = _Filter.matchs;
                  },
                  child: Obx(() => Opacity(
                        opacity: _filter.value == _Filter.matchs ? 1 : 0.5,
                        child: Text(
                          "Matchs",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ))),
              const SizedBox(width: 40),
              TextButton(
                  onPressed: () {
                    _filter.value = _Filter.statistics;
                  },
                  child: Obx(() => Opacity(
                        opacity: _filter.value == _Filter.statistics ? 1 : 0.5,
                        child: Text(
                          "Statistiques",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ))),
              const SizedBox(width: 40),
              TextButton(
                  onPressed: () {
                    _filter.value = _Filter.players;
                  },
                  child: Obx(() => Opacity(
                        opacity: _filter.value == _Filter.players ? 1 : 0.5,
                        child: Text(
                          "Joueurs",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ))),
            ],
          ),
        ),
        body: Obx(
          () => _filter.value == _Filter.matchs
              ? MatchFixture()
              : _filter.value == _Filter.statistics
                  ? const BodyStatistique()
                  : const BodyPlayers(),
        ),
      ),
    );
  }
}

class BodyStatistique extends StatefulWidget {
  const BodyStatistique({Key? key}) : super(key: key);

  @override
  _BodyStatistiqueState createState() => _BodyStatistiqueState();
}

class _BodyStatistiqueState extends State<BodyStatistique> {
  API api = API();
  @override
  Widget build(BuildContext context) {
    int id = context.watch<int>();
    return _leagues.isEmpty
        ? FutureBuilder<dio.Response>(
            future: api.getLiguesQuery("?team=" + id.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              }

              if (snapshot.hasData) {
                _leagues = snapshot.data!.data
                    .map((l) => League.fromMap(l))
                    .toList()
                    .cast<League>();
                _leagueSelected.value = 0;
              }

              return Scaffold(
                  appBar: AppBar(
                      automaticallyImplyLeading: false,
                      title: const LeagueTeam()),
                  body: const TeamState());
            },
          )
        : Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false, title: const LeagueTeam()),
            body: const TeamState());
  }
}

class LeagueTeam extends StatelessWidget {
  const LeagueTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: ScrollController(),
        scrollDirection: Axis.horizontal,
        child: Obx(
          () => Row(
            children: _leagues
                .map((e) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(
                            _leagues.indexOf(e) == _leagueSelected.value
                                ? 1
                                : 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          _leagueSelected.value = _leagues.indexOf(e);
                        },
                        radius: 20,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 2,
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(
                                    e.league_v1!.logo!,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Opacity(
                                opacity: 0.5,
                                child: Text(
                                  e.league_v1!.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )))
                .toList(),
          ),
        ));
  }
}

class MatchStatistique extends StatelessWidget {
  final API api = API();
  MatchStatistique({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int id = context.watch<int>();
    return FutureBuilder<dio.Response>(
        future: api.getFixtureTeam(30, id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          List<Fixture> fixtures = [];
          if (snapshot.hasData) {
            var response = snapshot.data!;

            fixtures = response.data
                .map((l) => Fixture.fromMap(l))
                .toList()
                .cast<Fixture>();
            //  fixtures = fixtures;
            fixtures.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
          }
          return ListView.builder(
              controller: ScrollController(),
              itemCount: fixtures.length,
              itemBuilder: (context, index) =>
                  FixtureItem(fixture: fixtures[index]));
        });
  }
}

class MatchFixture extends StatelessWidget {
  final API api = API();
  MatchFixture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int id = context.watch<int>();
    return _fixtures.isEmpty
        ? FutureBuilder<dio.Response>(
            future: api.getFixtureTeam(30, id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              }

              if (snapshot.hasData) {
                var response = snapshot.data!;

                _fixtures = response.data
                    .map((l) => Fixture.fromMap(l))
                    .toList()
                    .cast<Fixture>();
                //  fixtures = fixtures;
                _fixtures.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
              }
              return ListView.builder(
                  controller: ScrollController(),
                  itemCount: _fixtures.length,
                  itemBuilder: (context, index) =>
                      FixtureItem(fixture: _fixtures[index]));
            })
        : ListView.builder(
            controller: ScrollController(),
            itemCount: _fixtures.length,
            itemBuilder: (context, index) =>
                FixtureItem(fixture: _fixtures[index]));
  }
}

class TeamState extends StatefulWidget {
  const TeamState({Key? key}) : super(key: key);

  @override
  _TeamStateState createState() => _TeamStateState();
}

class _TeamStateState extends State<TeamState> {
  @override
  Widget build(BuildContext context) {
    int id = context.watch<int>();
    return Obx(() => FutureBuilder<dio.Response>(
          future: API().getTeamStatistic(
              "?team=$id&league=${_leagues[_leagueSelected.value].league_v1!.id}&season=${_leagues[_leagueSelected.value].seasons!.last.year}"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage();
            }

            if (snapshot.hasData) {
              TeamStatistic teamStatistic =
                  TeamStatistic.fromMap(snapshot.data!.data);

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Opacity(
                              opacity: 0.8,
                              child: Text(
                                "Etats des derniers matchs",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: teamStatistic.form!.length,
                                itemBuilder: (context, index) => CircleAvatar(
                                      radius: 30,
                                      backgroundColor: TeamStatistic.colorFrom(
                                          teamStatistic.form![
                                              teamStatistic.form!.length -
                                                  1 -
                                                  index]),
                                      child: Text(TeamStatistic.stringForm(
                                          teamStatistic.form![
                                              teamStatistic.form!.length -
                                                  1 -
                                                  index])),
                                    )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 130,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 5),
                                        child: Text(
                                          "Matchs joués",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  color: Colors.brown[100]),
                                        ),
                                      ),
                                      const Divider(),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .fixture_v1!.played!.home
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Domicile",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .fixture_v1!.played!.away
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Extérieur",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .fixture_v1!.played!.total
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Total",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 130,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 5),
                                        child: Text(
                                          "Matchs gagnés",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  color: Colors.blue[100]),
                                        ),
                                      ),
                                      const Divider(),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    teamStatistic
                                                        .fixture_v1!.wins!.home
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Opacity(
                                                    opacity: 0.4,
                                                    child: Text(
                                                      "Domicile",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontSize: 10),
                                                    ))
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    teamStatistic
                                                        .fixture_v1!.wins!.away
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Opacity(
                                                    opacity: 0.4,
                                                    child: Text(
                                                      "Extérieur",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontSize: 10),
                                                    ))
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    teamStatistic
                                                        .fixture_v1!.wins!.total
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Total",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 130,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 5),
                                        child: Text(
                                          "Matchs nuls",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  color: Colors.yellow[100]),
                                        ),
                                      ),
                                      const Divider(),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .fixture_v1!.draws!.home
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Domicile",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .fixture_v1!.draws!.away
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Extérieur",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .fixture_v1!.draws!.total
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Total",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 120,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 5),
                                        child: Text(
                                          "Matchs perdus",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.red[100]),
                                        ),
                                      ),
                                      Divider(),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .fixture_v1!.loses!.home
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Domicile",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .fixture_v1!.loses!.away
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Extérieur",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .fixture_v1!.loses!.total
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Total",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 130,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 5),
                                      child: Text(
                                        "Buts marqués",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: Colors.brown[100]),
                                      ),
                                    ),
                                    const Divider(),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                teamStatistic.goal!.forr!.home
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Opacity(
                                                opacity: 0.4,
                                                child: Text(
                                                  "Domicile",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(fontSize: 10),
                                                ))
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                teamStatistic.goal!.forr!.away
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Opacity(
                                                opacity: 0.4,
                                                child: Text(
                                                  "Extérieur",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(fontSize: 10),
                                                ))
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                teamStatistic.goal!.forr!.total
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Opacity(
                                                opacity: 0.4,
                                                child: Text(
                                                  "Total",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(fontSize: 10),
                                                ))
                                          ],
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 130,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 5),
                                      child: Text(
                                        "Buts encaissés",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: Colors.blue[100]),
                                      ),
                                    ),
                                    const Divider(),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .goal!.against!.home
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Domicile",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .goal!.against!.away
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                  opacity: 0.4,
                                                  child: Text(
                                                    "Extérieur",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(fontSize: 10),
                                                  ))
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  teamStatistic
                                                      .goal!.against!.total
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Opacity(
                                                opacity: 0.4,
                                                child: Text(
                                                  "Total",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ))
                  ],
                ),
              );
            }
            return const Center(
              child: Text("Erreur"),
            );
          },
        ));
  }
}
