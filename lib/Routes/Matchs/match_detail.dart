import 'package:api_football/Models/fixture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchDetail extends StatefulWidget {
  final Fixture? fixture;
  const MatchDetail({Key? key, required this.fixture}) : super(key: key);

  @override
  _MatchDetailState createState() => _MatchDetailState();
}

class _MatchDetailState extends State<MatchDetail> {
  @override
  void initState() {
    if (widget.fixture == null) Get.toNamed("/matchs");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      return Text(widget.fixture!.id.toString());
    });
  }
}
