import 'package:api_football/Utils/theme.dart';
import 'package:api_football/Widgets/menu_bar.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  final Widget page;
  const Root({Key? key, required this.page}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MenuBar(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 70,
                ),
                Expanded(
                  child: widget.page,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
