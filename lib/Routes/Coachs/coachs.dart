import 'dart:convert';

import 'package:api_football/Models/coach.dart';
import 'package:api_football/Models/historique_model.dart';
import 'package:api_football/Models/league.dart';
import 'package:api_football/Models/team.dart';
import 'package:api_football/Utils/api.dart';
import 'package:api_football/Utils/convertion.dart';
import 'package:api_football/Widgets/constants/loading.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:hive/hive.dart';

List<Coach> _initCoachs = [];
RxList<dynamic> _coaches = [].obs;
RxString _title = "Recommandations".obs;

TextEditingController _rechercheController = TextEditingController();

class CoachsPage extends StatefulWidget {
  const CoachsPage({Key? key}) : super(key: key);

  @override
  _CoachsPageState createState() => _CoachsPageState();
}

class _CoachsPageState extends State<CoachsPage> {
  API api = API();
  RxBool isLoaing = false.obs;

  iniLeagueFromLocal() async {
    var snapshot = await Convertion.stringToJson("assets/coachs.json");
    _initCoachs = Convertion.fromLocalJsonToListCoach(snapshot.toString());
    _coaches.value = _initCoachs;
  }

  recherche() async {
    if (_rechercheController.text.length >= 3) {
      isLoaing.value = true;
      var response = await api.getCoachs(_rechercheController.text);
      _coaches.value =
          response.data.map((l) => Coach.fromMap(l)).toList().cast<Coach>();
      _title.value =
          "${_coaches.length < 20 ? _coaches.length : 20} résultats trouvés pour \"${_rechercheController.text}\"";
      isLoaing.value = false;
    }
  }

  @override
  void initState() {
    iniLeagueFromLocal();
    _rechercheController.addListener(() {
      if (_rechercheController.text.isEmpty ||
          _rechercheController.text.length < 3) {
        _title.value = "Recommandations";
        _coaches.value = _initCoachs;
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _rechercheController,
                onEditingComplete: recherche,
                decoration: InputDecoration(
                    suffixIcon: Obx(() => IconButton(
                        tooltip: _title.value != "Recommandations"
                            ? "Effacer"
                            : "Rechercher",
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          _rechercheController.clear();
                        },
                        icon: Icon(_title.value != "Recommandations"
                            ? Icons.close
                            : Icons.search))),
                    hintText: "Recherche des coaches",
                    contentPadding: const EdgeInsets.only(top: 15),
                    border: InputBorder.none),
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(70),
        ),
        body: Obx(() => isLoaing.value ? const LoadingPage() : const Body()));
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 00),
        child: Obx(() => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: false,
                title: Text(_title.value,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.blue[100])),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                    shrinkWrap: true,
                    controller: ScrollController(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 260,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 40,
                            mainAxisSpacing: 40),
                    itemCount: _coaches.length,
                    itemBuilder: (context, index) =>
                        coachItem(coach: _coaches[index])),
              ),
            )));
  }
}

class coachItem extends StatelessWidget {
  final Coach coach;
  const coachItem({Key? key, required this.coach}) : super(key: key);

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
        onTap: () {
          Box box = Hive.box('historique');

          if (!box.values.any((element) => element.name == coach.name)) {
            box.add(HistoriqueModel(
                image: coach.photo,
                name: coach.name,
                route: "/coachs/" + coach.id.toString()));
          }
          Get.toNamed("/coachs/" + coach.id.toString());
        },
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
                    coach.photo!,
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
