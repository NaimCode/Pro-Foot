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

class _LeagueCountryState extends State<LeagueCountry> {
  API api = API();
  @override
  Widget build(BuildContext context) {
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
              future: api.getLiguesByQuery("?country=" + countries[0].name!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingPage();
                }
                List<League> _leagues = [];
                if (snapshot.hasData) {
                  _leagues = snapshot.data!.data
                      .map((l) => League.fromMap(l))
                      .toList()
                      .cast<League>();
                }
                return Padding(
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LeagueContainer(
                                leagues: _leagues
                                    .where((l) => l.league_v1!.type == "League")
                                    .toList(growable: false)
                                    .cast(),
                                title: "Ligues",
                              ),
                              const SizedBox(
                                width: 40,
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
                        )));
              });
        });
  }
}
