import 'package:api_football/Models/Country/country.dart';
import 'package:flutter/material.dart';

class CountryItem extends StatelessWidget {
  final Country country;
  const CountryItem({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Image.network(country.flag!, fit: BoxFit.fitWidth))
          ],
        ),
      ),
    );
  }
}
