import 'package:api_football/Models/Country/country.dart';
import 'package:api_football/Models/Country/country_list.dart';
import 'package:api_football/Routes/Pays/countryItem.dart';
import 'package:api_football/Utils/convertion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pays",
                style: Theme.of(context).textTheme.headline5,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 100),
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
                      hintText: "Recherche",
                      contentPadding: const EdgeInsets.only(top: 15),
                      border: InputBorder.none),
                ),
              )),
              IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
            ],
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
                  _initCountries =
                      CountryList.fromLocalJson(snapshot.data!.toString())
                          .countriesList!;

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
    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              Text(
                _title.value,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 40),
                  itemCount: _countries.length,
                  itemBuilder: (context, index) =>
                      CountryItem(country: _countries[index])),
            ],
          ),
        ));
  }
}
