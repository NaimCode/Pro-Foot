import 'package:api_football/Models/fixture.dart';
import 'package:api_football/Models/fixture_statistic.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:flutter/material.dart';
import "package:dio/dio.dart" as dio;
import 'package:get/get.dart';

class MatchDetail extends StatefulWidget {
  final Fixture? fixture;
  const MatchDetail({Key? key, required this.fixture}) : super(key: key);

  @override
  _MatchDetailState createState() => _MatchDetailState();
}

class _MatchDetailState extends State<MatchDetail> {
  API api = API();

  @override
  void initState() {
    if (widget.fixture == null) Get.toNamed("/matchs");

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dio.Response>(
        future: api.getMatchDetail(widget.fixture!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          FixtureStatistic fixtureStatistic;
          if (snapshot.hasData) {
            print(snapshot.data!.data);
            fixtureStatistic = FixtureStatistic.fromMap(snapshot.data!.data);
          }
          return Text('test');
          //Body(fixtureStatistic: fixtureStatistic);
        });
  }
}

class Body extends StatelessWidget {
  final FixtureStatistic fixtureStatistic;
  const Body({Key? key, required this.fixtureStatistic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                      fixtureStatistic.fixtureStatistic_v1s![0].team!.logo!),
                ))
          ],
        )
      ],
    );
  }
}
