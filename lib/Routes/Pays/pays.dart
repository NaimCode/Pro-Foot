import 'package:api_football/Models/Country/country.dart';
import 'package:api_football/Models/Country/country_list.dart';
import 'package:api_football/Routes/Pays/countryItem.dart';
import 'package:api_football/Utils/convertion.dart';
import 'package:flutter/material.dart';

class PagePays extends StatefulWidget {
  const PagePays({Key? key}) : super(key: key);

  @override
  _PagePaysState createState() => _PagePaysState();
}

class _PagePaysState extends State<PagePays> {
  late Future<String> futureCoutryList;
  @override
  void initState() {
    futureCoutryList = Convertion.stringToJson("assets/countries.json");

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
                child: Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            tooltip: "Rechercher",
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {},
                            icon: const Icon(Icons.search)),
                        hintText: "Recherche",
                        contentPadding: const EdgeInsets.only(top: 15),
                        border: InputBorder.none),
                  ),
                ),
              )),
              IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
            ],
          ),
        ),
        preferredSize: const Size.fromHeight(70),
      ),
      body: FutureBuilder(
          future: futureCoutryList,
          builder: (context, snapshot) {
            List<Country> courtries = [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Waiting');
            }

            if (snapshot.hasData) {
              courtries = CountryList.fromLocalJson(snapshot.data!.toString())
                  .countriesList!;
            }
            return GridView.builder(
                controller: ScrollController(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 40),
                itemCount: 40,
                itemBuilder: (context, index) =>
                    CountryItem(country: courtries[index]));
          }),
    );
  }
}
