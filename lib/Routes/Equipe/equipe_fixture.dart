import 'package:api_football/Models/fixture.dart';
import 'package:api_football/Models/primitives/player.dart';
import 'package:api_football/Models/primitives/team_v1.dart';
import 'package:api_football/Models/team.dart';
import 'package:api_football/Routes/Home/home.dart';
import 'package:api_football/Routes/Matchs/match_detail.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:api_football/Widgets/page.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EquipeFixture extends StatefulWidget {
  final Team? team;
  const EquipeFixture({Key? key, required this.team}) : super(key: key);

  @override
  _EquipeFixtureState createState() => _EquipeFixtureState();
}

enum _Filter { matchs, players, statistics }

Rx<_Filter> _filter = _Filter.matchs.obs;

class _EquipeFixtureState extends State<EquipeFixture> {
  API api = API();
  @override
  void initState() {
    if (widget.team == null) Get.toNamed("/equipes");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Obx(() => _filter.value == _Filter.matchs
            ? MatchFixture(api: api, widget: widget)
            : MatchFixture(api: api, widget: widget)));
  }
}
// class MatchPlayers extends StatelessWidget {
//   const MatchPlayers({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Scaffold(
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             centerTitle: false,
//             title: Text(_title.value,
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline4!
//                     .copyWith(color: Colors.blue[100])),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: GridView.builder(
//                 shrinkWrap: true,
//                 controller: ScrollController(),
//                 gridDelegate:
//                     const SliverGridDelegateWithMaxCrossAxisExtent(
//                         maxCrossAxisExtent: 260,
//                         childAspectRatio: 1.2,
//                         crossAxisSpacing: 40,
//                         mainAxisSpacing: 40),
//                 itemCount: _coaches.length,
//                 itemBuilder: (context, index) =>
//                     coachItem(coach: _coaches[index])),
//           ),
//         ));
//   }
// }

class playerItem extends StatelessWidget {
  final Player coach;
  const playerItem({Key? key, required this.coach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        radius: 50,
        borderRadius: BorderRadius.circular(10),
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
                    " coach.",
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

class MatchStatistique extends StatelessWidget {
  const MatchStatistique({
    Key? key,
    required this.api,
    required this.widget,
  }) : super(key: key);

  final API api;
  final EquipeFixture widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dio.Response>(
        future: api.getFixtureTeam(30, widget.team!.team_v2!.id!),
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
  const MatchFixture({
    Key? key,
    required this.api,
    required this.widget,
  }) : super(key: key);

  final API api;
  final EquipeFixture widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dio.Response>(
        future: api.getFixtureTeam(30, widget.team!.team_v2!.id!),
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

class FixtureItem extends StatelessWidget {
  final Fixture fixture;
  const FixtureItem({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DateTime date = Datetime

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Get.to(
            Root(
                page: MatchDetail(
              fixture: fixture,
            )),
            routeName: "/matchs/" + fixture.id.toString(),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 500),
          );
        },
        radius: 20,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(fixture.league_v2!.name!,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 10,
                            color: Colors.blue[100]!.withOpacity(0.6))),
                  ),
                  Text(fixture.league_v2!.round!,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 10,
                          color: Colors.blue[100]!.withOpacity(0.6))),
                  Expanded(
                    child: Text(fixture.toStringDate(),
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 10,
                            color: Colors.blue[100]!.withOpacity(0.6))),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          fixture.homeTeam!.name!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white54),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white70,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              fixture.homeTeam!.logo!,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            fixture.homeGoal.toString() +
                                " - " +
                                fixture.awayGoal.toString(),
                            style: Theme.of(context).textTheme.headline6),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(fixture.status!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontSize: 10,
                                    color:
                                        Colors.yellow[50]!.withOpacity(0.6))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white70,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              fixture.awayTeam!.logo!,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          fixture.awayTeam!.name!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white54),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
