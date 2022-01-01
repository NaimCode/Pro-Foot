import 'package:api_football/Models/league.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../Models/country.dart';
import '../Championants/championants.dart';

class LeagueCountry extends StatefulWidget {
  const LeagueCountry({Key? key}) : super(key: key);

  @override
  _LeagueCountryState createState() => _LeagueCountryState();
}

List<League> _leagues = [];

class _LeagueCountryState extends State<LeagueCountry> {
  API api = API();
  @override
  void initState() {
    _leagues.clear();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool m = MediaQuery.of(context).size.width <= 450;
    return FutureBuilder<dio.Response>(
        future: api.getCountry("?code=" + Get.parameters['country']!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          List<Country> countries = [];
          if (snapshot.hasData) {
            countries = snapshot.data!.data
                .map((l) => Country.fromMap(l))
                .toList()
                .cast<Country>();
          }

          return FutureBuilder<dio.Response>(
              future: api.getLiguesByQuery(countries.isEmpty
                  ? "?country=2"
                  : "?country=" + countries[0].name!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingPage();
                }

                if (snapshot.hasData) {
                  _leagues = snapshot.data!.data
                      .map((l) => League.fromMap(l))
                      .toList()
                      .cast<League>();
                }
                return m
                    ? const MobileBody()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 00),
                        child: Scaffold(
                            appBar: AppBar(
                              automaticallyImplyLeading: false,
                              centerTitle: false,
                              title: Text("Championants",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(color: Colors.blue[100])),
                            ),
                            body: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LeagueContainer(
                                    leagues: _leagues
                                        .where((l) =>
                                            l.league_v1!.type == "League")
                                        .toList(growable: false)
                                        .cast(),
                                    title: "Ligues",
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  LeagueContainer(
                                    leagues: _leagues
                                        .where(
                                            (l) => l.league_v1!.type == "Cup")
                                        .toList(growable: false)
                                        .cast<League>(),
                                    title: "Coupes",
                                  ),
                                ],
                              ),
                            )));
              });
        });
  }
}

class MobileBody extends StatelessWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool m = MediaQuery.of(context).size.width <= 450;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Ligues",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Tab(
                  child: Text(
                "Coupes",
                style: Theme.of(context).textTheme.bodyText2,
              )),
            ],
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text("Championants",
              style: m
                  ? Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.blue[50])
                  : Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.blue[100])),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TabBarView(
            children: [
              LeagueContainer(
                leagues: _leagues
                    .where((l) => l.league_v1!.type == "League")
                    .toList(growable: false)
                    .cast(),
                title: "Ligues",
              ),
              LeagueContainer(
                leagues: _leagues
                    .where((l) => l.league_v1!.type == "Cup")
                    .toList(growable: false)
                    .cast<League>(),
                title: "Coupes",
              ),
            ],
          ),
        ),
      ),
    );
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
    bool m = MediaQuery.of(context).size.width <= 450;
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          m
              ? const SizedBox()
              : Opacity(
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
    );
  }
}
