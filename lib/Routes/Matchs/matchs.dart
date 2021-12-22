import 'package:api_football/Models/fixture.dart';
import 'package:api_football/Routes/Home/home.dart';
import 'package:api_football/Routes/Matchs/match_detail.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:api_football/Widgets/page.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Matchs extends StatefulWidget {
  const Matchs({Key? key}) : super(key: key);

  @override
  _MatchsState createState() => _MatchsState();
}

enum _Filter { all, live, finished }

Rx<_Filter> _filter = _Filter.all.obs;

class _MatchsState extends State<Matchs> {
  API api = API();
  @override
  void initState() {
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
                    _filter.value = _Filter.all;
                  },
                  child: Obx(() => Opacity(
                        opacity: _filter.value == _Filter.all ? 1 : 0.5,
                        child: Text(
                          "Tous les matchs",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ))),
              const SizedBox(width: 40),
              TextButton(
                  onPressed: () {
                    _filter.value = _Filter.live;
                  },
                  child: Obx(() => Opacity(
                        opacity: _filter.value == _Filter.live ? 1 : 0.5,
                        child: Text(
                          "En cours",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ))),
              const SizedBox(width: 40),
              TextButton(
                  onPressed: () {
                    _filter.value = _Filter.finished;
                  },
                  child: Obx(() => Opacity(
                        opacity: _filter.value == _Filter.finished ? 1 : 0.5,
                        child: Text(
                          "Terminés",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ))),
            ],
          ),
        ),
        body: Obx(
          () => FutureBuilder<dio.Response>(
              future: _filter.value == _Filter.all
                  ? api.getFixture(30)
                  : _filter.value == _Filter.live
                      ? api.getFixtureParam("?live=all")
                      : api.getFixtureParam("?status=FT&last=30"),
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
                }
                return ListView.builder(
                    controller: ScrollController(),
                    itemCount: fixtures.length,
                    itemBuilder: (context, index) =>
                        FixtureItem(fixture: fixtures[index]));
              }),
        ));
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
          child: Row(
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
                    Text(fixture.league_v2!.round!,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 10,
                            color: Colors.yellow[50]!.withOpacity(0.6))),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        fixture.homeGoal == "null" || fixture.awayGoal == "null"
                            ? "---"
                            : fixture.homeGoal.toString() +
                                " - " +
                                fixture.awayGoal.toString(),
                        style: Theme.of(context).textTheme.headline6),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(fixture.status!,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 10,
                            color: Colors.yellow[50]!.withOpacity(0.6))),
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
        ),
      ),
    );
  }
}
