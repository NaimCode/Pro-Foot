import 'package:api_football/Models/coach.dart';
import 'package:api_football/Models/historique_model.dart';
import 'package:api_football/Models/primitives/career.dart';
import 'package:api_football/Models/primitives/team_v1.dart';
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

class _CoachDetailState extends State<CoachDetail> {
  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Opacity(
                      opacity: 0.7,
                      child: Text(
                        "Carrières",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  ...coach.careers!.map((e) => teamItem(career: e))
                ],
              ),
            );
          }

          return const Center(
            child: Text("Erreur"),
          );
        });
  }
}

class CoachItemText extends StatelessWidget {
  final String title;
  final String? value;
  const CoachItemText({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value == null
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
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: Row(
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
                          style: Theme.of(context).textTheme.subtitle1,
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
                                style: Theme.of(context).textTheme.subtitle1,
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
