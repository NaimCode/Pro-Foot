import 'package:api_football/Models/fixture.dart';
import 'package:api_football/Routes/Matchs/match_detail.dart';
import 'package:api_football/Widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FixtureItem extends StatelessWidget {
  final Fixture fixture;
  const FixtureItem({Key? key, required this.fixture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DateTime date = Datetime
    bool m = MediaQuery.of(context).size.width <= 450;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: m ? 15 : 0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        // onTap: () {
        //   Get.to(
        //     Root(
        //         page: MatchDetail(
        //       fixture: fixture,
        //     )),
        //     routeName: "/matchs/" + fixture.id.toString(),
        //     transition: Transition.leftToRight,
        //     duration: const Duration(milliseconds: 500),
        //   );
        // },
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
              SizedBox(
                height: m ? 10 : 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child:
                        //Mobile section
                        m
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    fixture.homeTeam!.name!,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    fixture.homeTeam!.name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.white),
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
                                    fixture.awayTeam!.logo!,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                fixture.awayTeam!.name!,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
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
                                    .copyWith(color: Colors.white),
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
