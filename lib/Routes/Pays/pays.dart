import 'package:api_football/Models/country.dart';
import 'package:api_football/Models/historique_model.dart';
import 'package:api_football/Utils/convertion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

List<String> _paysRecommandation = [
  "Belgique",
  "Brésil",
  "Égypte",
  "Angleterre",
  "Allemagne",
  "France",
  "Italie",
  "Maroc",
  "Portugal",
  "Espagne",
];

late Future<String> _futureCoutryList;
List<Country> _initCountries = [];
RxList<dynamic> _countries = [].obs;

RxString _title = "Recommandations".obs;

TextEditingController _rechercheController = TextEditingController();

class PagePays extends StatefulWidget {
  const PagePays({Key? key}) : super(key: key);

  @override
  _PagePaysState createState() => _PagePaysState();
}

class _PagePaysState extends State<PagePays> {
  @override
  void initState() {
    _futureCoutryList = Convertion.stringToJson("assets/countries.json");
    _rechercheController.addListener(() {
      if (_rechercheController.text.isEmpty) {
        _countries.value = _initCountries
            .where(
                (element) => _paysRecommandation.contains(element.name!.trim()))
            .toList();
        _title.value = "Recommandations";
      } else {
        if (_rechercheController.text.length >= 2) {
          _countries.value = _initCountries
              .where((element) => element.name!
                  .trim()
                  .toLowerCase()
                  .contains(_rechercheController.text.toLowerCase()))
              .toList();
          _title.value =
              "${_countries.length} résultats trouvés pour \"${_rechercheController.text}\"";
        }
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool m = MediaQuery.of(context).size.width <= 450;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: TextField(
              controller: _rechercheController,
              decoration: InputDecoration(
                  suffixIcon: Obx(() => IconButton(
                      tooltip: _title.value != "Recommandations"
                          ? "Effacer"
                          : "Rechercher",
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        _rechercheController.clear();
                      },
                      icon: Icon(_title.value != "Recommandations"
                          ? Icons.close
                          : Icons.search))),
                  hintText: "Recherche des pays",
                  contentPadding: const EdgeInsets.only(top: 15),
                  border: InputBorder.none),
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(70),
      ),
      body: _initCountries.isEmpty
          ? FutureBuilder(
              future: _futureCoutryList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Waiting');
                }

                if (snapshot.hasData) {
                  _initCountries = Convertion.fromLocalJsonToListCountry(
                      snapshot.data!.toString());

                  _countries.value = _initCountries
                      .where((element) =>
                          _paysRecommandation.contains(element.name!.trim()))
                      .toList();
                }
                return const Body();
              })
          : const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool m = MediaQuery.of(context).size.width <= 450;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _title.value,
                style: m
                    ? Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.blue[50])
                    : Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.blue[50]),
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: m ? 4 / 2 : 10 / 2,
                shrinkWrap: true,
                controller: ScrollController(),
                crossAxisSpacing: 13,
                mainAxisSpacing: 7,
                children: _countries
                    .getRange(
                        0, _countries.length < 20 ? _countries.length : 20)
                    .map((e) => countryiItem(league: e))
                    .toList(),
              ),
            ],
          )),
        ));
  }
}

class countryiItem extends StatelessWidget {
  final Country league;
  const countryiItem({Key? key, required this.league}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool m = MediaQuery.of(context).size.width <= 450;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Box box = Hive.box("historique");
          if (!box.values.any((element) => element.name == league.name)) {
            box.add(HistoriqueModel(
              name: league.name,
              route: "/pays/" + league.code.toString(),
              image: league.flag,
            ));
          }
          Get.toNamed("/pays/" + league.code!);
        },
        radius: 20,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: m ? 2 : 10,
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white70,
                child: Padding(
                  padding: EdgeInsets.all(m ? 15 : 10.0),
                  child: m
                      ? SvgPicture.network(
                          league.flag!,
                          fit: BoxFit.fitHeight,
                        )
                      : Image.network(
                          league.flag!,
                          scale: 3.0,
                          fit: BoxFit.fitHeight,
                        ),
                ),
              ),
              SizedBox(
                width: m ? 10 : 30,
              ),
              Flexible(
                child: Text(
                  league.name!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
