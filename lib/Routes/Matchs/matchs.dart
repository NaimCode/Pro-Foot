import 'package:api_football/Models/fixture.dart';
import 'package:api_football/Routes/Equipe/equipe_fixture.dart';
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
                  fixtures.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
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
