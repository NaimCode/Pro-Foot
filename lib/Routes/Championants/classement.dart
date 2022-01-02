// ignore_for_file: non_constant_identifier_names

import 'package:api_football/Models/historique_model.dart';
import 'package:api_football/Models/primitives/team_v1.dart';
import 'package:api_football/Models/standing.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:api_football/Widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class BodyClassement extends StatefulWidget {
  const BodyClassement({Key? key}) : super(key: key);

  @override
  _BodyClassementState createState() => _BodyClassementState();
}

class _BodyClassementState extends State<BodyClassement> {
  API api = API();

  @override
  Widget build(BuildContext context) {
    bool m = MediaQuery.of(context).size.width <= 450;
    return FutureBuilder<dio.Response>(
        future: api.getLeagueClassement(
            "?league=${Get.parameters['league']}&season=${Get.parameters['season']}"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }

          if (snapshot.hasData) {
            Standing standing = Standing.fromMap(snapshot.data!.data);

            return Scaffold(
                body: Center(
              child: ListView(
                controller: ScrollController(),
                children: standing.standings_groups
                    .map(
                      (s) => SingleChildScrollView(
                        key: GlobalKey(),
                        scrollDirection: Axis.horizontal,
                        controller: ScrollController(),
                        child: Center(
                          child: DataTable(
                              columnSpacing: m ? 10 : null,
                              horizontalMargin: 20,
                              showCheckboxColumn: false,
                              columns: [
                                DataColumn(
                                    label:
                                        ColumnItem(text: m ? "" : "Classement"),
                                    numeric: true),
                                const DataColumn(
                                    label: ColumnItem(text: "Equipe")),
                                const DataColumn(
                                    label: ColumnItem(text: "Victoires"),
                                    numeric: true),
                                const DataColumn(
                                    label: ColumnItem(text: "Nuls"),
                                    numeric: true),
                                const DataColumn(
                                    label: ColumnItem(text: "Défaites"),
                                    numeric: true),
                                const DataColumn(
                                    label: ColumnItem(text: "Matchs")),
                                // DataColumn(
                                //     label: ColumnItem(text: "Marqués"), numeric: true),
                                // DataColumn(
                                //     label: ColumnItem(text: "Encaissés"), numeric: true),
                                const DataColumn(
                                    label: ColumnItem(text: "Points"),
                                    numeric: true),
                                const DataColumn(
                                    label: ColumnItem(text: "Différence"),
                                    numeric: true),
                              ],
                              rows: s.standing_v1s!
                                  .map((e) => DataRow(
                                          onSelectChanged: (b) {
                                            if (b!) {
                                              historiqueList.addIf(
                                                !historiqueList.any((element) =>
                                                    element.name ==
                                                    e.team_v1!.name),
                                                HistoriqueModel(
                                                  name: e.team_v1!.name,
                                                  route: "/equipes/" +
                                                      e.team_v1!.id.toString(),
                                                  image: e.team_v1!.logo!,
                                                ),
                                              );
                                              Get.toNamed(
                                                "/equipes/" +
                                                    e.team_v1!.id.toString(),
                                              );
                                            }
                                          },
                                          cells: [
                                            DataCell(Text("${e.rank}")),
                                            DataCell(Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.white54,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Image.network(
                                                      e.team_v1!.logo!,
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Opacity(
                                                    opacity: 0.7,
                                                    child: Text(
                                                        "${e.team_v1!.name}")),
                                              ],
                                            )),
                                            DataCell(Text(
                                              "${e.wins}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            )),
                                            DataCell(Text(
                                              "${e.draws}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            )),
                                            DataCell(Text(
                                              "${e.loses}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            )),
                                            DataCell(Text(
                                              e.form!
                                                  .replaceAll(RegExp(r'W'), 'V')
                                                  .replaceAll(RegExp(r'D'), 'N')
                                                  .replaceAll(
                                                      RegExp(r'L'), 'D'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            )),
                                            // DataCell(Text("${e.goalFor}")),
                                            // DataCell(Text("${e.goalAgainst}")),
                                            DataCell(Text(
                                              "${e.points}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            )),
                                            DataCell(Text(
                                              "${e.goalsDiff}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            )),
                                          ]))
                                  .toList()),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ));
          }

          return const Error();
        });
  }
}

class ColumnItem extends StatelessWidget {
  final String text;
  const ColumnItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 10));
  }
}
