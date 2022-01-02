import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitChasingDots(
          color: Colors.red[50],
          size: 50.0,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Chargement...",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.red[50]),
        )
      ],
    ));
  }
}

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: 400,
            child: Text(
              "Erreur de chargement, soit votre connexion soit le nombre de requêtes a été atteint",
              style: TextStyle(color: Colors.red[200], fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class Laoding extends StatelessWidget {
  const Laoding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 60,
      height: 60,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}
