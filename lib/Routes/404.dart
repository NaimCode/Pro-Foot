import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page introuvable pour le moment',
          style: Theme.of(context).textTheme.headline3),
    );
  }
}
