import 'package:api_football/Models/coach.dart';
import 'package:api_football/Models/historique_model.dart';
import 'package:api_football/Models/primitives/career.dart';
import 'package:api_football/Models/primitives/sidelined.dart';
import 'package:api_football/Models/primitives/team_v1.dart';
import 'package:api_football/Models/primitives/trophie.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CoachDetail extends StatefulWidget {
  const CoachDetail({Key? key}) : super(key: key);

  @override
  _CoachDetailState createState() => _CoachDetailState();
}

enum _Filter { career, trophies, events }

Rx<_Filter> _filter = _Filter.career.obs;
List<Trophie> _trophies = [];
List<Sidelined> _sidelined = [];

class _CoachDetailState extends State<CoachDetail> {
  @override
  void initState() {
    // TODO: implement initState
    _trophies.clear();
    _sidelined.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool m = MediaQuery.of(context).size.width <= 450;
    return FutureBuilder<dio.Response>(
        future: API().getCoachsByID("?id=" + Get.parameters['id']!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          if (snapshot.hasData) {
            Coach coach = Coach.fromMap(snapshot.data!.data.first);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListView(
                controller: ScrollController(),
                children: [
                  !m
                      ? const SizedBox()
                      : CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Image.network(coach.photo!),
                          )),
                  SizedBox(height: m ? 10 : 0),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(m ? 10 : 90),
                            bottomLeft: Radius.circular(m ? 10 : 90))),
                    child: Row(
                      children: [
                        m
                            ? const SizedBox()
                            : CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Image.network(coach.photo!),
                                )),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              runAlignment: WrapAlignment.spaceBetween,
                              children: [
                                CoachItemText(
                                    title: "nom", value: coach.firstName),
                                CoachItemText(
                                    title: "prénom", value: coach.lastName),
                                CoachItemText(
                                    title: "age", value: coach.age.toString()),
                                CoachItemText(
                                    title: "taille", value: coach.height),
                                CoachItemText(
                                    title: "poids", value: coach.weight),
                                CoachItemText(
                                    title: "date de naissance",
                                    value: coach.dateNaissance),
                                CoachItemText(
                                    title: "nationalité",
                                    value: coach.nationality),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: m ? 20 : 40, bottom: m ? 10 : 20),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              _filter.value = _Filter.career;
                            },
                            child: Obx(() => Opacity(
                                  opacity:
                                      _filter.value == _Filter.career ? 1 : 0.5,
                                  child: Text(
                                    "Carrières",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ))),
                        const SizedBox(width: 40),
                        TextButton(
                            onPressed: () {
                              _filter.value = _Filter.trophies;
                            },
                            child: Obx(() => Opacity(
                                  opacity: _filter.value == _Filter.trophies
                                      ? 1
                                      : 0.5,
                                  child: Text(
                                    "Trophées",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ))),
                        const SizedBox(width: 40),
                        TextButton(
                            onPressed: () {
                              _filter.value = _Filter.events;
                            },
                            child: Obx(() => Opacity(
                                  opacity:
                                      _filter.value == _Filter.events ? 1 : 0.5,
                                  child: Text(
                                    "Evénement",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ))),
                      ],
                    ),
                  ),
                  Obx(() => _filter.value == _Filter.career
                      ? ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: coach.careers!
                              .map((e) => teamItem(career: e))
                              .toList())
                      : _filter.value == _Filter.trophies
                          ? _trophies.isNotEmpty
                              ? const TrophieCoach()
                              : FutureBuilder<dio.Response>(
                                  future: API().getTrophies(
                                      "?coach=" + coach.id.toString()),
                                  builder: (context, snap) {
                                    if (snap.connectionState ==
                                        ConnectionState.waiting) {
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
                                      return const SizedBox(
                                          height: 300, child: Error());
                                    }
                                    return const TrophieCoach();
                                  })
                          : _sidelined.isNotEmpty
                              ? const SidelinedCoach()
                              : FutureBuilder<dio.Response>(
                                  future: API().getSidelined(
                                      "?coach=" + coach.id.toString()),
                                  builder: (context, snap) {
                                    if (snap.connectionState ==
                                        ConnectionState.waiting) {
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
                                      return const SizedBox(
                                          height: 300, child: Error());
                                    }
                                    return const SidelinedCoach();
                                  }))
                ],
              ),
            );
          }

          return const Error();
        });
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

class CoachItemText extends StatelessWidget {
  final String title;
  final String? value;
  const CoachItemText({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value == "null"
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(
                  height: 4,
                ),
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
  }
}

class teamItem extends StatelessWidget {
  final Career career;
  const teamItem({Key? key, required this.career}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool m = MediaQuery.of(context).size.width <= 450;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Box box = Hive.box("historique");
          if (!box.values.any((element) => element.name == career.team!.name)) {
            box.add(HistoriqueModel(
              name: career.team!.name,
              route: "/equipes/" + career.team!.id.toString(),
              image: career.team!.logo!,
            ));
          }
          Get.toNamed("/equipes/" + career.team!.id.toString());
        },
        radius: 20,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: m ? 5 : 10,
              ),
              Expanded(
                flex: m ? 2 : 3,
                child: m
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(
                                career.team!.logo!,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Flexible(
                            child: Text(
                              career.team!.name!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: m ? 13 : null),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(
                                career.team!.logo!,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            career.team!.name!,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          career.start!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: m ? 12 : null),
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
              career.end == "null"
                  ? Expanded(flex: 2, child: Container())
                  : Expanded(
                      flex: 2,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                career.end!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: m ? 12 : null),
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
                    )
            ],
          ),
        ),
      ),
    );
  }
}
