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
        const SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Chargement...",
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    ));
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
